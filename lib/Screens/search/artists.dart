import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_app/API/ArtistAPI.api.dart';
import 'package:music_app/Widgets/artist_like_button.screen.dart';
import 'package:music_app/Widgets/bouncy_sliver_scroll_view.widget.dart';
import 'package:music_app/Widgets/copy_clipboard.widget.dart';
import 'package:music_app/Widgets/download_button.widget.dart';
import 'package:music_app/Widgets/empty_screen.widget.dart';
import 'package:music_app/Widgets/gradient_container.widget.dart';
import 'package:music_app/Widgets/horizontal_albumlist.widget.dart';
import 'package:music_app/Widgets/like_button.widget.dart';
import 'package:music_app/Widgets/miniplayer.widget.dart';
import 'package:music_app/Widgets/on_hover.widget.dart';
import 'package:music_app/Widgets/playlist_popupmenu.widget.dart';
import 'package:music_app/Widgets/snackbar.widget.dart';
import 'package:music_app/Widgets/song_tile_trailing_menu.widget.dart';
import 'package:share_plus/share_plus.dart';

class ArtistSearchPage extends StatefulWidget {
  final Map data;

  const ArtistSearchPage({
    super.key,
    required this.data,
  });

  @override
  _ArtistSearchPageState createState() => _ArtistSearchPageState();
}

class _ArtistSearchPageState extends State<ArtistSearchPage> {
  bool status = false;
  String category = '';
  String sortOrder = '';
  Map dataOneArtist = {};
  List<Map> SongList = [];
  List<Map> AlbumList = [];
  bool fetched = false;
  final ScrollController _scrollController = ScrollController();

  Future<void> getDataOneArtist(String Id) async {
    final data1 = await ArtistApi().getOneArtist(Id);
    if (data1.isNotEmpty) {
      dataOneArtist = data1;
      AlbumList = data1['album'];
      SongList = data1['song'];
      fetched = true;
      setState(() {});
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!status) {
      status = true;
      getDataOneArtist(
        widget.data['id'],
      );
    }
    double boxSize =
        MediaQuery.of(context).size.height > MediaQuery.of(context).size.width
            ? MediaQuery.of(context).size.width / 2
            : MediaQuery.of(context).size.height / 2.5;
    if (boxSize > 250) boxSize = 250;
    return GradientContainer(
      child: Column(
        children: [
          Expanded(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: !fetched
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 4, 192, 60),
                      ),
                    )
                  : dataOneArtist.isEmpty
                      ? emptyScreen(
                          context,
                          0,
                          ':( ',
                          100,
                          'SORRY',
                          60,
                          'Results Not Found',
                          20,
                        )
                      : BouncyImageSliverScrollView(
                          scrollController: _scrollController,
                          actions: [
                            IconButton(
                              icon: const Icon(Icons.share_rounded),
                              tooltip: 'Share',
                              onPressed: () {
                                Share.share(
                                  widget.data['name'],
                                );
                              },
                            ),
                            ArtistLikeButton(
                              data: {},
                              size: 27.0,
                            ),
                            PlaylistPopupMenu(
                              data: [],
                              title: widget.data['name'] ?? 'Songs',
                            ),
                          ],
                          title: widget.data['name'],
                          placeholderImage: 'assets/artist.png',
                          imageUrl: widget.data['avatar'],
                          sliverList: SliverList(
                            delegate: SliverChildListDelegate(
                              [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            // PlayerInvoke.init(
                                            //   songsList: data['Top Songs']!,
                                            //   index: 0,
                                            //   isOffline: false,
                                            // );
                                            // Navigator.pushNamed(
                                            //   context,
                                            //   '/player',
                                            // );
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                              top: 10,
                                              bottom: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100.0),
                                              color: Color.fromARGB(
                                                  255, 4, 192, 60),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 5.0,
                                                  offset: Offset(0.0, 3.0),
                                                )
                                              ],
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.play_arrow_rounded,
                                                    color: Colors.white,
                                                    size: 26.0,
                                                  ),
                                                  const SizedBox(width: 5.0),
                                                  Text(
                                                    'Play',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18.0,
                                                      color: Colors.white,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            ShowSnackBar().showSnackBar(
                                              context,
                                              'Connecting to Radio…',
                                              duration: const Duration(
                                                seconds: 2,
                                              ),
                                            );
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                              vertical: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100.0),
                                              border: Border.all(
                                                color: Colors.white,
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.podcasts_rounded,
                                                    color: Colors.white,
                                                    size: 26.0,
                                                  ),
                                                  const SizedBox(width: 5.0),
                                                  Text(
                                                    'Radio',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18.0,
                                                      color: Colors.white,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Container(
                                        margin: const EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                          border: Border.all(
                                            color: Colors.white,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: GestureDetector(
                                            child: Icon(
                                              Icons.shuffle_rounded,
                                              color: Colors.white,
                                              size: 24.0,
                                            ),
                                            onTap: () {
                                              // PlayerInvoke.init(
                                              //   songsList: data['Top Songs']!,
                                              //   index: 0,
                                              //   isOffline: false,
                                              //   shuffle: true,
                                              // );
                                              // Navigator.pushNamed(
                                              //   context,
                                              //   '/player',
                                              // );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding:
                                            EdgeInsets.only(left: 20, top: 9),
                                        child: Text(
                                          'Top Songs',
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 4, 192, 60),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, top: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          ChoiceChip(
                                            label: Text('Popularity'),
                                            elevation: 0,
                                            backgroundColor:
                                                Color.fromARGB(255, 57, 57, 57),
                                            selectedColor:
                                                Color.fromARGB(255, 42, 79, 50),
                                            labelStyle: TextStyle(
                                              color: category == ''
                                                  ? Color.fromARGB(
                                                      255, 4, 192, 60)
                                                  : Colors.white70,
                                              fontWeight: category == ''
                                                  ? FontWeight.w600
                                                  : FontWeight.normal,
                                            ),
                                            selected: category == '',
                                            shape: StadiumBorder(
                                                side: BorderSide(
                                                    color: category == ''
                                                        ? Color.fromARGB(
                                                            255, 42, 79, 50)
                                                        : Color.fromARGB(
                                                            255, 57, 57, 57))),
                                            onSelected: (bool selected) {
                                              if (selected) {
                                                category = '';
                                                sortOrder = '';
                                                status = false;
                                                setState(() {});
                                              }
                                            },
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          ChoiceChip(
                                            label: Text(
                                              'Date',
                                            ),
                                            selectedColor:
                                                Color.fromARGB(255, 42, 79, 50),
                                            backgroundColor:
                                                Color.fromARGB(255, 57, 57, 57),
                                            labelStyle: TextStyle(
                                              color: category == 'latest'
                                                  ? Color.fromARGB(
                                                      255, 4, 192, 60)
                                                  : Colors.white70,
                                              fontWeight: category == 'latest'
                                                  ? FontWeight.w600
                                                  : FontWeight.normal,
                                            ),
                                            shape: StadiumBorder(
                                                side: BorderSide(
                                                    color: category == 'latest'
                                                        ? Color.fromARGB(
                                                            255, 42, 79, 50)
                                                        : Color.fromARGB(
                                                            255, 57, 57, 57))),
                                            selected: category == 'latest',
                                            onSelected: (bool selected) {
                                              if (selected) {
                                                category = 'latest';
                                                sortOrder = 'desc';
                                                status = false;
                                                setState(() {});
                                              }
                                            },
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          ChoiceChip(
                                            label: Text(
                                              'Alphabetical',
                                            ),
                                            selectedColor:
                                                Color.fromARGB(255, 42, 79, 50),
                                            backgroundColor:
                                                Color.fromARGB(255, 57, 57, 57),
                                            labelStyle: TextStyle(
                                              color: category == 'alphabetical'
                                                  ? Color.fromARGB(
                                                      255, 4, 192, 60)
                                                  : Colors.white70,
                                              fontWeight:
                                                  category == 'alphabetical'
                                                      ? FontWeight.w600
                                                      : FontWeight.normal,
                                            ),
                                            selected:
                                                category == 'alphabetical',
                                            shape: StadiumBorder(
                                                side: BorderSide(
                                                    color: category ==
                                                            'alphabetical'
                                                        ? Color.fromARGB(
                                                            255, 42, 79, 50)
                                                        : Color.fromARGB(
                                                            255, 57, 57, 57))),
                                            onSelected: (bool selected) {
                                              if (selected) {
                                                category = 'alphabetical';
                                                sortOrder = 'asc';
                                                status = false;
                                                setState(() {});
                                              }
                                            },
                                          ),
                                          const Spacer(),
                                        ],
                                      ),
                                    ),
                                    //-----------------
                                    ListView.builder(
                                      padding: const EdgeInsets.fromLTRB(
                                        5,
                                        5,
                                        5,
                                        0,
                                      ),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: SongList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final name = SongList[index]['name'];
                                        final image = SongList[index]['image'];
                                        final artist =
                                            SongList[index]['artist'];
                                        return ListTile(
                                          contentPadding: const EdgeInsets.only(
                                            left: 15.0,
                                          ),
                                          title: Text(
                                            name,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          onLongPress: () {
                                            copyToClipboard(
                                              context: context,
                                              text: name,
                                            );
                                          },
                                          subtitle: Text(
                                            artist,
                                            style: const TextStyle(
                                              color: Colors.white70,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          leading: Card(
                                            margin: EdgeInsets.zero,
                                            elevation: 8,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                7.0,
                                              ),
                                            ),
                                            clipBehavior: Clip.antiAlias,
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              errorWidget: (context, _, __) =>
                                                  Image(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                  'assets/cover.jpg',
                                                ),
                                              ),
                                              imageUrl: image,
                                              placeholder: (context, url) =>
                                                  Image(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    'assets/cover.jpg'),
                                              ),
                                            ),
                                          ),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              DownloadButton(
                                                data: {},
                                                icon: 'download',
                                              ),
                                              LikeButton(
                                                data: SongList[index] as Map,
                                                mediaItem: null,
                                              ),
                                              SongTileTrailingMenu(
                                                data: {},
                                              ),
                                            ],
                                          ),
                                          onTap: () {},
                                        );
                                      },
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 6),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                15, 10, 0, 5),
                                            child: Text(
                                              'New Releases',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 4, 192, 60),
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: boxSize + 15,
                                        child: ListView.builder(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          itemCount: AlbumList.length,
                                          itemBuilder: (context, index) {
                                            final name =
                                                AlbumList[index]['name'];
                                            final image =
                                                AlbumList[index]['image'];
                                            final artist =
                                                dataOneArtist['name'];
                                            return GestureDetector(
                                              child: SizedBox(
                                                width: boxSize - 30,
                                                child: HoverBox(
                                                  child: Card(
                                                    elevation: 5,
                                                    color: Colors.black,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10.0,
                                                      ),
                                                    ),
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    child: Image.network(image),
                                                    // child: const Image(
                                                    //   // image: AssetImage(
                                                    //   //   'assets/cover.jpg',
                                                    //   // ),
                                                    // ),
                                                  ),
                                                  builder: (
                                                    BuildContext context,
                                                    bool isHover,
                                                    Widget? child,
                                                  ) {
                                                    return Card(
                                                      color: isHover
                                                          ? null
                                                          : Colors.transparent,
                                                      elevation: 0,
                                                      margin: EdgeInsets.zero,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          10.0,
                                                        ),
                                                      ),
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      child: Column(
                                                        children: [
                                                          SizedBox.square(
                                                            dimension: isHover
                                                                ? boxSize - 25
                                                                : boxSize - 30,
                                                            child: child,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              horizontal: 10.0,
                                                            ),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Text(
                                                                  name,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  softWrap:
                                                                      false,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      height:
                                                                          1.3,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                Text(
                                                                  artist,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  softWrap:
                                                                      false,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          11,
                                                                      color: Colors
                                                                          .white70),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              onTap: () async {
                                                Navigator.popAndPushNamed(
                                                    context, '/album');
                                              },
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
            ),
          ),
          MiniPlayer(),
        ],
      ),
    );
  }
}
