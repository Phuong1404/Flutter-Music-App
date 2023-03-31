import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/Widgets/custom_physics.widget.dart';
import 'package:music_app/Widgets/empty_screen.widget.dart';
import 'package:music_app/Widgets/song_tile_trailing_menu.widget.dart';
import 'package:url_launcher/url_launcher.dart';

List localSongs = [];
List globalSongs = [];
bool localFetched = false;
bool globalFetched = false;
final ValueNotifier<bool> localFetchFinished = ValueNotifier<bool>(false);
final ValueNotifier<bool> globalFetchFinished = ValueNotifier<bool>(false);

class TopChartScreen extends StatefulWidget {
  final PageController pageController;
  const TopChartScreen({super.key, required this.pageController});

  @override
  _TopChartScreenState createState() => _TopChartScreenState();
}

class _TopChartScreenState extends State<TopChartScreen>
    with AutomaticKeepAliveClientMixin<TopChartScreen> {
  final ValueNotifier<bool> localFetchFinished = ValueNotifier<bool>(false);

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext cntxt) {
    super.build(context);
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool rotated = MediaQuery.of(context).size.height < screenWidth;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Color.fromARGB(255, 4, 192, 60),
            tabs: [
              Tab(
                child: Text(
                  "Local",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  // AppLocalizations.of(context)!.global,
                  "Global",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          title: Text(
            "Top Chart",
            style: TextStyle(
              fontSize: 18.5,
              color: Colors.white,
              fontWeight: FontWeight.w500
            ),
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
        ),
        body: NotificationListener(
          onNotification: (overscroll) {
            if (overscroll is OverscrollNotification &&
                overscroll.overscroll != 0 &&
                overscroll.dragDetails != null) {
              widget.pageController.animateToPage(
                overscroll.overscroll < 0 ? 0 : 2,
                curve: Curves.ease,
                duration: const Duration(milliseconds: 150),
              );
            }
            return true;
          },
          child: TabBarView(
            physics: const CustomPhysics(),
            children: [
              // ValueListenableBuilder(
              //   valueListenable: Hive.box('settings').listenable(),
              //   builder: (BuildContext context, Box box, Widget? widget) {
              //     return TopPage(
              //       type: box.get('region', defaultValue: 'India').toString(),
              //     );
              //   },
              // ),
              // TopPage(type: 'local'),
              const TopPage(type: 'Global'),
            ],
          ),
        ),
      ),
    );
  }
}

// Future<List> getChartDetails(String accessToken, String type) async {
//   final String globalPlaylistId = ConstantCodes.localChartCodes['Global']!;
//   final String localPlaylistId = ConstantCodes.localChartCodes.containsKey(type)
//       ? ConstantCodes.localChartCodes[type]!
//       : ConstantCodes.localChartCodes['India']!;
//   final String playlistId =
//       type == 'Global' ? globalPlaylistId : localPlaylistId;
//   final List data = [];
//   // final List tracks =
//   //     await SpotifyApi().getAllTracksOfPlaylist(accessToken, playlistId);
//   for (final track in tracks) {
//     final trackName = track['track']['name'];
//     final imageUrlSmall = track['track']['album']['images'].last['url'];
//     final imageUrlBig = track['track']['album']['images'].first['url'];
//     final spotifyUrl = track['track']['external_urls']['spotify'];
//     final artistName = track['track']['artists'][0]['name'].toString();
//     data.add({
//       'name': trackName,
//       'artist': artistName,
//       'image_url_small': imageUrlSmall,
//       'image_url_big': imageUrlBig,
//       'spotifyUrl': spotifyUrl,
//     });
//   }
//   return data;
// }

// Future<void> scrapData(String type, {bool signIn = false}) async {
//   final bool spotifySigned =
//       Hive.box('settings').get('spotifySigned', defaultValue: false) as bool;

//   if (!spotifySigned && !signIn) {
//     return;
//   }
//   final String? accessToken = await retriveAccessToken();
//   if (accessToken == null) {
//     launchUrl(
//       Uri.parse(
//         SpotifyApi().requestAuthorization(),
//       ),
//       mode: LaunchMode.externalApplication,
//     );
//     AppLinks(
//       onAppLink: (Uri uri, String link) async {
//         closeInAppWebView();
//         if (link.contains('code=')) {
//           final code = link.split('code=')[1];
//           Hive.box('settings').put('spotifyAppCode', code);
//           final currentTime = DateTime.now().millisecondsSinceEpoch / 1000;
//           final List<String> data =
//               await SpotifyApi().getAccessToken(code: code);
//           if (data.isNotEmpty) {
//             Hive.box('settings').put('spotifyAccessToken', data[0]);
//             Hive.box('settings').put('spotifyRefreshToken', data[1]);
//             Hive.box('settings').put('spotifySigned', true);
//             Hive.box('settings')
//                 .put('spotifyTokenExpireAt', currentTime + int.parse(data[2]));
//           }

//           final temp = await getChartDetails(data[0], type);
//           if (temp.isNotEmpty) {
//             Hive.box('cache').put('${type}_chart', temp);
//             if (type == 'Global') {
//               globalSongs = temp;
//             } else {
//               localSongs = temp;
//             }
//           }
//           if (type == 'Global') {
//             globalFetchFinished.value = true;
//           } else {
//             localFetchFinished.value = true;
//           }
//         }
//       },
//     );
//   } else {
//     final temp = await getChartDetails(accessToken, type);
//     if (temp.isNotEmpty) {
//       Hive.box('cache').put('${type}_chart', temp);
//       if (type == 'Global') {
//         globalSongs = temp;
//       } else {
//         localSongs = temp;
//       }
//     }
//     if (type == 'Global') {
//       globalFetchFinished.value = true;
//     } else {
//       localFetchFinished.value = true;
//     }
//   }
// }

class TopPage extends StatefulWidget {
  final String type;
  const TopPage({super.key, required this.type});
  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage>
    with AutomaticKeepAliveClientMixin<TopPage> {
  Future<void> getCachedData(String type) async {
    if (type == 'Global') {
      globalFetched = true;
    } else {
      localFetched = true;
    }
    if (type == 'Global') {
      // globalSongs = await Hive.box('cache')
      //     .get('${type}_chart', defaultValue: []) as List;
      globalSongs = [] as List;
    } else {
      localSongs = [] as List;
      // localSongs = await Hive.box('cache')
      //     .get('${type}_chart', defaultValue: []) as List;
    }
    setState(() {});
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    getCachedData(widget.type);
    // scrapData(widget.type);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final bool isGlobal = widget.type == 'Global';
    if ((isGlobal && !globalFetched) || (!isGlobal && !localFetched)) {
      getCachedData(widget.type);
      // scrapData(widget.type);
    }
    return ValueListenableBuilder(
      valueListenable: isGlobal ? globalFetchFinished : localFetchFinished,
      builder: (BuildContext context, bool value, Widget? child) {
        final List showList = isGlobal ? globalSongs : localSongs;
        return Column(
          children: [
            // if (showList.isEmpty)
            //   Expanded(
            //     child: value
            //         ? emptyScreen(
            //             context,
            //             0,
            //             ':( ',
            //             100,
            //             'ERROR',
            //             60,
            //             'Service Unavailable',
            //             20,
            //           )
            //         : Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: const [
            //               CircularProgressIndicator(
            //                 color: Color.fromARGB(255, 4, 192, 60),
            //               ),
            //             ],
            //           ),
            //   )
            // // else
              Expanded(child: ListView(
                children: <Widget>[
                  ListTile(
                      leading: Card(
                        margin: EdgeInsets.zero,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          children: [
                            const Image(
                              image: AssetImage('assets/cover.jpg'),
                            ),
                            // if (showList[index]['image_url_small'] != '')
                              CachedNetworkImage(
                                fit: BoxFit.cover,
                                // imageUrl: showList[index]['image_url_small']
                                //     .toString(),
                                imageUrl: 'https://c-cl.cdn.smule.com/rs-s94/arr/18/66/011b2306-b067-44b7-ba7a-d7c3717fe92a.jpg',
                                errorWidget: (context, _, __) => const Image(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/cover.jpg'),
                                ),
                                placeholder: (context, url) => const Image(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/cover.jpg'),
                                ),
                              ),
                          ],
                        ),
                      ),
                      title: Text(
                        '1. Thương em là điều anh không thể ngờ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          height: 1.4
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        'Noo Phước Thịnh',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: SongTileTrailingMenu(
                        data: {},
                      ),
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => SearchPage(
                        //       query: showList[index]['name'].toString(),
                        //     ),
                        //   ),
                        // );
                      },
                    ),
                    ListTile(
                      leading: Card(
                        margin: EdgeInsets.zero,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          children: [
                            const Image(
                              image: AssetImage('assets/cover.jpg'),
                            ),
                            // if (showList[index]['image_url_small'] != '')
                              CachedNetworkImage(
                                fit: BoxFit.cover,
                                // imageUrl: showList[index]['image_url_small']
                                //     .toString(),
                                imageUrl: 'https://avatar-ex-swe.nixcdn.com/song/2018/11/08/2/8/3/9/1541660658234_500.jpg',
                                errorWidget: (context, _, __) => const Image(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/cover.jpg'),
                                ),
                                placeholder: (context, url) => const Image(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/cover.jpg'),
                                ),
                              ),
                          ],
                        ),
                      ),
                      title: Text(
                        '2. Xin em',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          height: 1.4
                        ),
                      ),
                      subtitle: Text(
                        'Bùi Anh Tuấn',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: SongTileTrailingMenu(
                        data: {},
                      ),
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => SearchPage(
                        //       query: showList[index]['name'].toString(),
                        //     ),
                        //   ),
                        // );
                      },
                    ),
                    ListTile(
                      leading: Card(
                        margin: EdgeInsets.zero,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          children: [
                            const Image(
                              image: AssetImage('assets/cover.jpg'),
                            ),
                            // if (showList[index]['image_url_small'] != '')
                              CachedNetworkImage(
                                fit: BoxFit.cover,
                                // imageUrl: showList[index]['image_url_small']
                                //     .toString(),
                                imageUrl: 'https://avatar-ex-swe.nixcdn.com/song/2020/06/15/b/0/f/a/1592231470406_640.jpg',
                                errorWidget: (context, _, __) => const Image(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/cover.jpg'),
                                ),
                                placeholder: (context, url) => const Image(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/cover.jpg'),
                                ),
                              ),
                          ],
                        ),
                      ),
                      title: Text(
                        '3. Cưới nhau đi(Yes I Do)',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          height: 1.4
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        'Bùi Anh Tuấn, Hiền Hồ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: SongTileTrailingMenu(
                        data: {},
                      ),
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => SearchPage(
                        //       query: showList[index]['name'].toString(),
                        //     ),
                        //   ),
                        // );
                      },
                    )
                
                
                ],
              )),
              // Expanded(
              //   child: ListView.builder(
              //     physics: const BouncingScrollPhysics(),
              //     itemCount: showList.length,
              //     itemExtent: 70.0,
              //     itemBuilder: (context, index) {
              //       return ListTile(
              //         leading: Card(
              //           margin: EdgeInsets.zero,
              //           elevation: 5,
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(7.0),
              //           ),
              //           clipBehavior: Clip.antiAlias,
              //           child: Stack(
              //             children: [
              //               const Image(
              //                 image: AssetImage('assets/cover.jpg'),
              //               ),
              //               if (showList[index]['image_url_small'] != '')
              //                 CachedNetworkImage(
              //                   fit: BoxFit.cover,
              //                   imageUrl: showList[index]['image_url_small']
              //                       .toString(),
              //                   errorWidget: (context, _, __) => const Image(
              //                     fit: BoxFit.cover,
              //                     image: AssetImage('assets/cover.jpg'),
              //                   ),
              //                   placeholder: (context, url) => const Image(
              //                     fit: BoxFit.cover,
              //                     image: AssetImage('assets/cover.jpg'),
              //                   ),
              //                 ),
              //             ],
              //           ),
              //         ),
              //         title: Text(
              //           '${index + 1}. ${showList[index]["name"]}',
              //           overflow: TextOverflow.ellipsis,
              //         ),
              //         subtitle: Text(
              //           showList[index]['artist'].toString(),
              //           overflow: TextOverflow.ellipsis,
              //         ),
              //         trailing: SongTileTrailingMenu(
              //           data: {},
              //         ),
              //         onTap: () {
              //           // Navigator.push(
              //           //   context,
              //           //   MaterialPageRoute(
              //           //     builder: (context) => SearchPage(
              //           //       query: showList[index]['name'].toString(),
              //           //     ),
              //           //   ),
              //           // );
              //         },
              //       );
              //     },
              //   ),
              // ),
          
          ],
        );
      },
    );
  }
}
