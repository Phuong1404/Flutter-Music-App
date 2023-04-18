import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_app/API/ArtistAPI.api.dart';
import 'package:music_app/Screens/search/artists.dart';
import 'package:music_app/Screens/search/search.screen.dart';

List DataArtistlist = [];
bool Fetched = false;

class ArtistScreen extends StatefulWidget {
  final PageController pageController;
  const ArtistScreen({super.key, required this.pageController});

  @override
  _ArtistScreenState createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen>
    with AutomaticKeepAliveClientMixin<ArtistScreen> {
  Future<void> getDataArtist() async {
    final data = await ArtistApi().getAllArtist();
    if (data.isNotEmpty) {
      DataArtistlist = data;
    }
  }
  
  @override
  Widget build(BuildContext cntxt) {
    // TODO: implement build
    super.build(context);
    if (!Fetched){
      getDataArtist();
    }
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool rotated = MediaQuery.of(context).size.height < screenWidth;

    return DefaultTabController(
        length: 3,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(
                "Artists",
                style: TextStyle(
                    fontSize: 18.5,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
              leading: (rotated && screenWidth < 1050)
                  ? null
                  : Builder(
                      builder: (BuildContext context) {
                        return Transform.rotate(
                          angle: 22 / 7 * 2,
                          child: IconButton(
                            color: Colors.white,
                            icon: const Icon(
                              Icons.horizontal_split_rounded,
                            ),
                            onPressed: () {
                              Scaffold.of(cntxt).openDrawer();
                            },
                            tooltip: MaterialLocalizations.of(cntxt)
                                .openAppDrawerTooltip,
                          ),
                        );
                      },
                    ),
              actions: [
                Container(
                  padding: EdgeInsets.only(right: 7),
                  child: IconButton(
                    color: Colors.white,
                    icon: const Icon(
                      Icons.search,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchPage(
                            query: '',
                            fromHome: true,
                            autofocus: true,
                          ),
                        ),
                      );
                    },
                    tooltip:
                        MaterialLocalizations.of(cntxt).openAppDrawerTooltip,
                  ),
                ),
              ],
            ),
            body: SizedBox(
              child: Container(
                  margin: EdgeInsets.only(left: 11, right: 11, top: 10),
                  child: GridView.builder(gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 170,
                      childAspectRatio: 2 / 2,
                      mainAxisSpacing: 9,
                      crossAxisSpacing: 0,
                    ), itemBuilder: (BuildContext context, int index) { 
                        GestureDetector(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 97.2,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10000.0),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl:DataArtistlist[index]['avatar'],
                                  errorWidget: (context, _, __) => const Image(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/cover.jpg'),
                                  ),
                                  placeholder: (context, url) => const Image(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/cover.jpg'),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              DataArtistlist[index]['name'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.5,
                                  height: 2),
                            )
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              opaque: false,
                              pageBuilder: (
                                _,
                                __,
                                ___,
                              ) =>
                                  ArtistSearchPage(
                                data: {
                                  "id":DataArtistlist[index]['id'],
                                  "name":DataArtistlist[index]['name'],
                                  "avatar":DataArtistlist[index]['avatar'],
                                  "album_count":DataArtistlist[index]['album_count'],
                                  "song_count":DataArtistlist[index]['song_count'],
                                },
                                
                              ),
                            ),
                          );
                        },
                      );
                     },
                    )
                  ),
            )));
  }

  @override
  bool get wantKeepAlive => true;
}
