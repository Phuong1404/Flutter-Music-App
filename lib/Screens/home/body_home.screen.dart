import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:music_app/API/AlbumAPI.api.dart';
import 'package:music_app/Screens/common/song_list.screen.dart';
import 'package:music_app/Widgets/horizontal_albumlist_separated.widget.dart';
import 'package:music_app/Widgets/on_hover.widget.dart';

class HomeBodyScreen extends StatefulWidget {
  @override
  _HomeBodyScreenState createState() => _HomeBodyScreenState();
}

class _HomeBodyScreenState extends State<HomeBodyScreen> {
  bool fetched = false;
  Map dataTrendingAlbum = {};
  Map dataPopulateAlbum = {};
  Map dataByUserAlbum = {};

  Future<Map> getDataTrending() async {
    final data = await AlbumAPI().getTrendingAlbum();
    if (data['message'] == null) {
      return data;
    }
    return {};
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
    dataPopulateAlbum = await getDataPopulate();
    dataByUserAlbum = await getDataByUser();
    setState(() {});
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
    return ListView(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [
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
            HorizontalAlbumsListSeparated(),
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
                                    color: isHover ? null : Colors.transparent,
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
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.3,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                artist,
                                                textAlign: TextAlign.center,
                                                softWrap: false,
                                                overflow: TextOverflow.ellipsis,
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
                                        SongsListScreen(Id:album[index]['id'].toString())),
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
                                    color: isHover ? null : Colors.transparent,
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
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.3,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                artist,
                                                textAlign: TextAlign.center,
                                                softWrap: false,
                                                overflow: TextOverflow.ellipsis,
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
                                        SongsListScreen(Id:album[index]['id'].toString())),
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
                                    color: isHover ? null : Colors.transparent,
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
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.3,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                artist,
                                                textAlign: TextAlign.center,
                                                softWrap: false,
                                                overflow: TextOverflow.ellipsis,
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
                                        SongsListScreen(Id:album[index]['id'].toString())),
                              );
                            },
                          );
                        },
                      ))
                ],
              )
            : SizedBox()
      ],
    );
  }
}
