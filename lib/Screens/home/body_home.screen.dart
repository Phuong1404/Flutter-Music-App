import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:music_app/API/AlbumAPI.api.dart';
import 'package:music_app/API/SongAPI.api.dart';
import 'package:music_app/Screens/common/song_list.screen.dart';
import 'package:music_app/Services/player_service.dart';
import 'package:music_app/Services/store_token.service.dart';
import 'package:music_app/Widgets/horizontal_albumlist_separated.widget.dart';
import 'package:music_app/Widgets/on_hover.widget.dart';

class HomeBodyScreen extends StatefulWidget {
  @override
  _HomeBodyScreenState createState() => _HomeBodyScreenState();
}

class _HomeBodyScreenState extends State<HomeBodyScreen> {
  bool fetched = false;
  Map dataTrendingAlbum = Hive.box('cache').get('TrendingAlbum', defaultValue: {}) as Map;
  Map dataPopulateAlbum = Hive.box('cache').get('PopulateAlbum', defaultValue: {}) as Map;
  Map dataByUserAlbum = Hive.box('cache').get('UserAlbum', defaultValue: {}) as Map;
  List dataHistorySong = Hive.box('cache').get('HistorySong', defaultValue: []) as List;

  Future<Map> getDataTrending() async {
    final data = await AlbumAPI().getTrendingAlbum();
    if (data['message'] == null) {
      return data;
    }
    return {};
  }

  Future<List<Map>> getDataHistory() async {
    String? userId = await StoreToken.getToken();
    if (userId != null) {
      final data = await SongApi().getHistorySong(userId);
      return data;
    }
    return [];
  }

  Future<Map> getDataPopulate() async {
    final data = await AlbumAPI().getPopulateAlbum();
    if (data['message'] == null) {
      return data;
    }
    return {};
  }

  Future<Map> getDataByUser() async {
    final data = await AlbumAPI().getByUserAlbum();
    if (data['message'] == null) {
      return data;
    }
    return {};
  }

  Future<void> getDataHome() async {
    dataTrendingAlbum = await getDataTrending();
    Hive.box('cache').put('TrendingAlbum', dataTrendingAlbum);
    dataPopulateAlbum = await getDataPopulate();
    Hive.box('cache').put('PopulateAlbum', dataPopulateAlbum);
    dataByUserAlbum = await getDataByUser();
    Hive.box('cache').put('UserAlbum', dataByUserAlbum);
    dataHistorySong = await getDataHistory();
    Hive.box('cache').put('HistorySong', dataHistorySong);
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!fetched) {
      getDataHome();
      fetched = true;
    }
    double boxSize =
        MediaQuery.of(context).size.height > MediaQuery.of(context).size.width
            ? MediaQuery.of(context).size.width / 2
            : MediaQuery.of(context).size.height / 2.5;
    if (boxSize > 250) boxSize = 250;
//===============================Không có data=======================================
    // return const Center(
    //       child: CircularProgressIndicator(
    //         color: Color.fromARGB(255, 4, 192, 60),
    //       ),
    //     );
//=====================================Có data=======================================
    return RefreshIndicator(
      color: Color.fromARGB(255, 42, 215, 94),
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 1200));
        await getDataHome();
        setState(() {});
      },
      child: ListView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          if (dataHistorySong.length > 0)
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 0, 5),
                      child: Text(
                        'Last Session',
                        style: TextStyle(
                          color: Color.fromARGB(255, 4, 192, 60),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                HorizontalAlbumsListSeparated(
                  songsList: dataHistorySong,
                  onTap: (int idx) {
                    PlayerInvoke.init(
                      songsList: dataHistorySong,
                      index: idx,
                      isOffline: false,
                    );
                    Navigator.pushNamed(context, '/player');
                  },
                ),
              ],
            ),
          dataByUserAlbum['length'] != null
              ? Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 0, 5),
                          child: Text(
                            'Your Playlists',
                            style: TextStyle(
                              color: Color.fromARGB(255, 4, 192, 60),
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
                          itemCount: dataByUserAlbum['length'],
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          itemBuilder: (context, index) {
                            final album = dataByUserAlbum['result'];
                            String name = album[index]['name'];
                            String image = album[index]['image'];
                            String artist = album[index]['artist'];
                            return GestureDetector(
                              child: SizedBox(
                                width: boxSize - 30,
                                child: HoverBox(
                                  child: Card(
                                    elevation: 5,
                                    color: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        10.0,
                                      ),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: image != ""
                                        ? Image.network(image)
                                        : const Image(
                                            image: AssetImage(
                                              'assets/cover.jpg',
                                            ),
                                          ),
                                  ),
                                  builder: (
                                    BuildContext context,
                                    bool isHover,
                                    Widget? child,
                                  ) {
                                    return Card(
                                      color:
                                          isHover ? null : Colors.transparent,
                                      elevation: 0,
                                      margin: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          10.0,
                                        ),
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      child: Column(
                                        children: [
                                          SizedBox.square(
                                            dimension: isHover
                                                ? boxSize - 25
                                                : boxSize - 30,
                                            child: child,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  name,
                                                  textAlign: TextAlign.center,
                                                  softWrap: false,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 1.3,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  artist,
                                                  textAlign: TextAlign.center,
                                                  softWrap: false,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.white70),
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
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                      opaque: false,
                                      pageBuilder: (
                                        _,
                                        __,
                                        ___,
                                      ) =>
                                          SongsListScreen(
                                            listItem: album[index],
                                          )),
                                );
                              },
                            );
                          },
                        ))
                  ],
                )
              : SizedBox(),
          dataTrendingAlbum['length'] != null
              ? Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 0, 5),
                          child: Text(
                            'Trending Now',
                            style: TextStyle(
                              color: Color.fromARGB(255, 4, 192, 60),
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
                          itemCount: dataTrendingAlbum['length'],
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          itemBuilder: (context, index) {
                            final album = dataTrendingAlbum['result'];
                            String name = album[index]['name'];
                            String image = album[index]['image'];
                            String artist = album[index]['artist'];
                            return GestureDetector(
                              child: SizedBox(
                                width: boxSize - 30,
                                child: HoverBox(
                                  child: Card(
                                    elevation: 5,
                                    color: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        10.0,
                                      ),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: image != ""
                                        ? Image.network(image)
                                        : const Image(
                                            image: AssetImage(
                                              'assets/cover.jpg',
                                            ),
                                          ),
                                  ),
                                  builder: (
                                    BuildContext context,
                                    bool isHover,
                                    Widget? child,
                                  ) {
                                    return Card(
                                      color:
                                          isHover ? null : Colors.transparent,
                                      elevation: 0,
                                      margin: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          10.0,
                                        ),
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      child: Column(
                                        children: [
                                          SizedBox.square(
                                            dimension: isHover
                                                ? boxSize - 25
                                                : boxSize - 30,
                                            child: child,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  name,
                                                  textAlign: TextAlign.center,
                                                  softWrap: false,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 1.3,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  artist,
                                                  textAlign: TextAlign.center,
                                                  softWrap: false,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.white70),
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
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                      opaque: false,
                                      pageBuilder: (
                                        _,
                                        __,
                                        ___,
                                      ) =>
                                          SongsListScreen(
                                            listItem: album[index],
                                          )),
                                );
                              },
                            );
                          },
                        )),
                  ],
                )
              : SizedBox(),
          dataByUserAlbum['length'] != null
              ? Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 0, 5),
                          child: Text(
                            'New Releases',
                            style: TextStyle(
                              color: Color.fromARGB(255, 4, 192, 60),
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
                          itemCount: dataByUserAlbum['length'],
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          itemBuilder: (context, index) {
                            final album = dataByUserAlbum['result'];
                            String name = album[index]['name'];
                            String image = album[index]['image'];
                            String artist = album[index]['artist'];
                            return GestureDetector(
                              child: SizedBox(
                                width: boxSize - 30,
                                child: HoverBox(
                                  child: Card(
                                    elevation: 5,
                                    color: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        10.0,
                                      ),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: image != ""
                                        ? Image.network(image)
                                        : const Image(
                                            image: AssetImage(
                                              'assets/cover.jpg',
                                            ),
                                          ),
                                  ),
                                  builder: (
                                    BuildContext context,
                                    bool isHover,
                                    Widget? child,
                                  ) {
                                    return Card(
                                      color:
                                          isHover ? null : Colors.transparent,
                                      elevation: 0,
                                      margin: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          10.0,
                                        ),
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      child: Column(
                                        children: [
                                          SizedBox.square(
                                            dimension: isHover
                                                ? boxSize - 25
                                                : boxSize - 30,
                                            child: child,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  name,
                                                  textAlign: TextAlign.center,
                                                  softWrap: false,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 1.3,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  artist,
                                                  textAlign: TextAlign.center,
                                                  softWrap: false,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.white70),
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
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                      opaque: false,
                                      pageBuilder: (
                                        _,
                                        __,
                                        ___,
                                      ) =>
                                          SongsListScreen(
                                            listItem: album[index],
                                          )),
                                );
                              },
                            );
                          },
                        ))
                  ],
                )
              : SizedBox()
        ],
      ),
    );
  }
}
