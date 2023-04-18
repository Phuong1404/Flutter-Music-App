import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_app/Screens/common/song_list.screen.dart';
import 'package:music_app/Screens/search/albums.dart';
import 'package:music_app/Screens/search/artists.dart';
import 'package:music_app/Widgets/copy_clipboard.widget.dart';
import 'package:music_app/Widgets/download_button.widget.dart';
import 'package:music_app/Widgets/empty_screen.widget.dart';
import 'package:music_app/Widgets/gradient_container.widget.dart';
import 'package:music_app/Widgets/like_button.widget.dart';
import 'package:music_app/Widgets/miniplayer.widget.dart';
import 'package:music_app/Widgets/search_bar.widget.dart';
import 'package:music_app/Widgets/snackbar.widget.dart';
import 'package:music_app/Widgets/song_tile_trailing_menu.widget.dart';

class SearchPage extends StatefulWidget {
  final String query;
  final bool fromHome;
  final bool autofocus;
  const SearchPage({
    super.key,
    required this.query,
    this.fromHome = false,
    this.autofocus = false,
  });

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = '';
  bool status = false;
  Map searchedData = {};
  Map position = {};
  List sortedKeys = [];
  final ValueNotifier<List<String>> topSearch = ValueNotifier<List<String>>(
    [],
  );
  bool fetched = false;
  bool alertShown = false;
  bool albumFetched = false;
  bool? fromHome;
  List search = [];
  bool showHistory = true;
  bool liveSearch = true;

  final controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.query;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget nothingFound(BuildContext context) {
    return emptyScreen(
      context,
      0,
      ':( ',
      100,
      'SORRY',
      60,
      'Results Not Found',
      20,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.transparent,
                body: SearchBar(
                  isYt: false,
                  controller: controller,
                  liveSearch: liveSearch,
                  autofocus: widget.autofocus,
                  hintText: 'Songs, albums or artists',
                  leading: IconButton(
                    splashColor: Colors.transparent,
                    icon: const Icon(Icons.arrow_back_rounded),
                    onPressed: () => Navigator.pop(context),
                  ),
//-------------------------------------------------------------------------------------------------------------
                  // body: SingleChildScrollView(
                  //         padding: const EdgeInsets.symmetric(
                  //           horizontal: 15,
                  //         ),
                  //         physics: const BouncingScrollPhysics(),
                  //         child: Column(
                  //           children: [
                  //             const SizedBox(
                  //               height: 76,
                  //             ),
                  //             Align(
                  //               alignment: Alignment.topLeft,
                  //               child: Wrap(
                  //                 children: [
                  //                   Padding(
                  //                       padding: const EdgeInsets.symmetric(
                  //                         horizontal: 5.0,
                  //                       ),
                  //                       child: GestureDetector(
                  //                         child: Chip(
                  //                           elevation:0,
                  //                           shape: StadiumBorder(side: BorderSide(color:Color.fromARGB(255, 77, 77, 77) )),
                  //                           backgroundColor:Color.fromARGB(255, 77, 77, 77),
                  //                           label: Text(
                  //                             'Text',
                  //                           ),
                  //                           labelStyle: TextStyle(
                  //                             color: Colors.white,
                  //                             fontWeight: FontWeight.normal,
                  //                           ),
                  //                           deleteIconColor:Colors.white,
                  //                           onDeleted: () {
                  //                           },
                  //                         ),
                  //                         onTap: () {

                  //                         },
                  //                       ),
                  //                     ),
                  //                     Padding(
                  //                       padding: const EdgeInsets.symmetric(
                  //                         horizontal: 5.0,
                  //                       ),
                  //                       child: GestureDetector(
                  //                         child: Chip(
                  //                           elevation:0,
                  //                           shape: StadiumBorder(side: BorderSide(color:Color.fromARGB(255, 77, 77, 77) )),
                  //                           backgroundColor:Color.fromARGB(255, 77, 77, 77),
                  //                           label: Text(
                  //                             'Text',
                  //                           ),
                  //                           labelStyle: TextStyle(
                  //                             color: Colors.white,
                  //                             fontWeight: FontWeight.normal,
                  //                           ),
                  //                           deleteIconColor:Colors.white,
                  //                           onDeleted: () {
                  //                           },
                  //                         ),
                  //                         onTap: () {

                  //                         },
                  //                       ),
                  //                     ),
                  //                     Padding(
                  //                       padding: const EdgeInsets.symmetric(
                  //                         horizontal: 5.0,
                  //                       ),
                  //                       child: GestureDetector(
                  //                         child: Chip(
                  //                           elevation:0,
                  //                           shape: StadiumBorder(side: BorderSide(color:Color.fromARGB(255, 77, 77, 77) )),
                  //                           backgroundColor:Color.fromARGB(255, 77, 77, 77),
                  //                           label: Text(
                  //                             'Text',
                  //                           ),
                  //                           labelStyle: TextStyle(
                  //                             color: Colors.white,
                  //                             fontWeight: FontWeight.normal,
                  //                           ),
                  //                           deleteIconColor:Colors.white,
                  //                           onDeleted: () {
                  //                           },
                  //                         ),
                  //                         onTap: () {

                  //                         },
                  //                       ),
                  //                     ),
                  //                     Padding(
                  //                       padding: const EdgeInsets.symmetric(
                  //                         horizontal: 5.0,
                  //                       ),
                  //                       child: GestureDetector(
                  //                         child: Chip(
                  //                           elevation:0,
                  //                           shape: StadiumBorder(side: BorderSide(color:Color.fromARGB(255, 77, 77, 77) )),
                  //                           backgroundColor:Color.fromARGB(255, 77, 77, 77),
                  //                           label: Text(
                  //                             'Text',
                  //                           ),
                  //                           labelStyle: TextStyle(
                  //                             color: Colors.white,
                  //                             fontWeight: FontWeight.normal,
                  //                           ),
                  //                           deleteIconColor:Colors.white,
                  //                           onDeleted: () {
                  //                           },
                  //                         ),
                  //                         onTap: () {

                  //                         },
                  //                       ),
                  //                     ),
                  //                     Padding(
                  //                       padding: const EdgeInsets.symmetric(
                  //                         horizontal: 5.0,
                  //                       ),
                  //                       child: GestureDetector(
                  //                         child: Chip(
                  //                           elevation:0,
                  //                           shape: StadiumBorder(side: BorderSide(color:Color.fromARGB(255, 77, 77, 77) )),
                  //                           backgroundColor:Color.fromARGB(255, 77, 77, 77),
                  //                           label: Text(
                  //                             'Text',
                  //                           ),
                  //                           labelStyle: TextStyle(
                  //                             color: Colors.white,
                  //                             fontWeight: FontWeight.normal,
                  //                           ),
                  //                           deleteIconColor:Colors.white,
                  //                           onDeleted: () {
                  //                           },
                  //                         ),
                  //                         onTap: () {

                  //                         },
                  //                       ),
                  //                     ),

                  //                 ]
                  //               ),
                  //             ),
                  //             Column(
                  //                   children: [
                  //                     Padding(
                  //                       padding: const EdgeInsets.symmetric(
                  //                         horizontal: 10,
                  //                         vertical: 10,
                  //                       ),
                  //                       child: Row(
                  //                         children: [
                  //                           Text(
                  //                             'Trending Search',
                  //                             style: TextStyle(
                  //                               color: Color.fromARGB(255, 4, 192, 60),
                  //                               fontSize: 20,
                  //                               fontWeight: FontWeight.w800,
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                     Align(
                  //                       alignment: Alignment.topLeft,
                  //                       child: Wrap(
                  //                         children: [
                  //                           Padding(
                  //                               padding:
                  //                                   const EdgeInsets.symmetric(
                  //                                 horizontal: 5.0,
                  //                               ),
                  //                               child: ChoiceChip(
                  //                                 elevation:0,
                  //                                 backgroundColor:Color.fromARGB(255, 77, 77, 77),
                  //                                 label: Text('2322332323'),
                  //                                 labelStyle: TextStyle(
                  //                                   color: Colors.white,
                  //                                   fontWeight:
                  //                                       FontWeight.normal,
                  //                                 ),
                  //                                 shape: StadiumBorder(side: BorderSide(color:Color.fromARGB(255, 77, 77, 77) )),
                  //                                 selected: false,
                  //                                 onSelected: (bool selected) {
                  //                                 },
                  //                               ),
                  //                             ),

                  //                         ]
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 )

                  //           ],
                  //         ),
                  //       ),
//--------------------------------Khong ton tai----------------------------------------
                  // body:nothingFound(context) ,
//------------------------------------Load lai----------------------------------------
                  // body:const Center(child: CircularProgressIndicator(),),
//--------------------------------Co data--------------------------------------s
                  body: SingleChildScrollView(
                    padding: const EdgeInsets.only(
                      top: 70,
                    ),
                    physics: const BouncingScrollPhysics(),
                    child: Column(children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 25, top: 10, bottom: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Artists',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 4, 192, 60),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    25,
                                    0,
                                    25,
                                    0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
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
                                                  AlbumSearchPage(
                                                query: query == ''
                                                    ? widget.query
                                                    : query,
                                                type: 'Artists',
                                              ),
                                            ),
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              'View All',
                                              style: TextStyle(
                                                color: Colors.white70,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                            Icon(
                                              Icons.chevron_right_rounded,
                                              color: Colors.white70,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(
                              left: 5,
                              right: 10,
                            ),
                            children: [
                              ListTile(
                                contentPadding: const EdgeInsets.only(
                                  left: 15.0,
                                ),
                                title: Text(
                                  'Bùi Anh Tuấn',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  '5 Songs',
                                  style: TextStyle(color: Colors.white70),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                isThreeLine: false,
                                leading: Card(
                                  margin: EdgeInsets.zero,
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      50.0,
                                    ),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    errorWidget: (context, _, __) => Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/album.png',
                                      ),
                                    ),
                                    imageUrl:
                                        'https://avatar-ex-swe.nixcdn.com/song/2018/11/08/2/8/3/9/1541660658234_640.jpg',
                                    placeholder: (context, url) => Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/album.png',
                                      ),
                                    ),
                                  ),
                                ),
                                trailing: null,
                                onLongPress: () {
                                  copyToClipboard(
                                    context: context,
                                    text: '',
                                  );
                                },
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
                                        data: {},
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 25, top: 10, bottom: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Albums',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 4, 192, 60),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    25,
                                    0,
                                    25,
                                    0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
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
                                                  AlbumSearchPage(
                                                query: query == ''
                                                    ? widget.query
                                                    : query,
                                                type: 'Albums',
                                              ),
                                            ),
                                          );
                                          // Navigator.push(
                                          //   context,
                                          //   PageRouteBuilder(
                                          //     opaque: false,
                                          //     pageBuilder: (
                                          //       _,
                                          //       __,
                                          //       ___,
                                          //     ) =>
                                          //         SongsListScreen(
                                          //       listItem: {
                                          //         'id': query == ''
                                          //             ? widget.query
                                          //             : query,
                                          //         'title': '',
                                          //         'type': 'songs',
                                          //       },
                                          //     ),
                                          //   ),
                                          // );
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              'View All',
                                              style: TextStyle(
                                                color: Colors.white70,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                            Icon(
                                              Icons.chevron_right_rounded,
                                              color: Colors.white70,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(
                              left: 5,
                              right: 10,
                            ),
                            children: [
                              ListTile(
                                contentPadding: const EdgeInsets.only(
                                  left: 15.0,
                                ),
                                title: Text(
                                  'Xin Em',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  '5 Songs',
                                  style: TextStyle(color: Colors.white70),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                isThreeLine: false,
                                leading: Card(
                                  margin: EdgeInsets.zero,
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      7.0,
                                    ),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    errorWidget: (context, _, __) => Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/album.png',
                                      ),
                                    ),
                                    imageUrl:
                                        'https://avatar-ex-swe.nixcdn.com/song/2018/11/08/2/8/3/9/1541660658234_640.jpg',
                                    placeholder: (context, url) => Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/album.png',
                                      ),
                                    ),
                                  ),
                                ),
                                trailing: AlbumDownloadButton(
                                  albumId: '',
                                  albumName: '',
                                ),
                                // Row(
                                //   mainAxisSize: MainAxisSize.min,
                                //   children: [
                                //     DownloadButton(
                                //       data: {},
                                //       icon: 'download',
                                //     ),
                                //     LikeButton(data: {}),
                                //     SongTileTrailingMenu(
                                //       data: {},
                                //     ),
                                //   ],
                                // ),
                                onLongPress: () {
                                  copyToClipboard(
                                    context: context,
                                    text: '',
                                  );
                                },
                                onTap: () {},
                              ),
                              ListTile(
                                contentPadding: const EdgeInsets.only(
                                  left: 15.0,
                                ),
                                title: Text(
                                  'Xin Em',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  '5 Songs',
                                  style: TextStyle(color: Colors.white70),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                isThreeLine: false,
                                leading: Card(
                                  margin: EdgeInsets.zero,
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      7.0,
                                    ),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    errorWidget: (context, _, __) => Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/album.png',
                                      ),
                                    ),
                                    imageUrl:
                                        'https://avatar-ex-swe.nixcdn.com/song/2018/11/08/2/8/3/9/1541660658234_640.jpg',
                                    placeholder: (context, url) => Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/album.png',
                                      ),
                                    ),
                                  ),
                                ),
                                trailing: AlbumDownloadButton(
                                  albumId: '',
                                  albumName: '',
                                ),
                                // Row(
                                //   mainAxisSize: MainAxisSize.min,
                                //   children: [
                                //     DownloadButton(
                                //       data: {},
                                //       icon: 'download',
                                //     ),
                                //     LikeButton(data: {}),
                                //     SongTileTrailingMenu(
                                //       data: {},
                                //     ),
                                //   ],
                                // ),
                                onLongPress: () {
                                  copyToClipboard(
                                    context: context,
                                    text: '',
                                  );
                                },
                                onTap: () {},
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 25, top: 10, bottom: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Songs',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 4, 192, 60),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    25,
                                    0,
                                    25,
                                    0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
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
                                                  SongsListScreen(Id: "0"),
                                            ),
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              'View All',
                                              style: TextStyle(
                                                color: Colors.white70,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                            Icon(
                                              Icons.chevron_right_rounded,
                                              color: Colors.white70,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(
                              left: 5,
                              right: 10,
                            ),
                            children: [
                              ListTile(
                                contentPadding: const EdgeInsets.only(
                                  left: 15.0,
                                ),
                                title: Text(
                                  'Xin Em',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  'Bùi Anh Tuấn',
                                  style: TextStyle(color: Colors.white70),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                isThreeLine: false,
                                leading: Card(
                                  margin: EdgeInsets.zero,
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      7.0,
                                    ),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    errorWidget: (context, _, __) => Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/album.png',
                                      ),
                                    ),
                                    imageUrl:
                                        'https://avatar-ex-swe.nixcdn.com/song/2018/11/08/2/8/3/9/1541660658234_640.jpg',
                                    placeholder: (context, url) => Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/album.png',
                                      ),
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
                                    LikeButton(data: {}),
                                    SongTileTrailingMenu(
                                      data: {},
                                    ),
                                  ],
                                ),
                                onLongPress: () {
                                  copyToClipboard(
                                    context: context,
                                    text: '',
                                  );
                                },
                                onTap: () {},
                              ),
                              ListTile(
                                contentPadding: const EdgeInsets.only(
                                  left: 15.0,
                                ),
                                title: Text(
                                  'Xin Em',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  'Bùi Anh Tuấn',
                                  style: TextStyle(color: Colors.white70),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                isThreeLine: false,
                                leading: Card(
                                  margin: EdgeInsets.zero,
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      7.0,
                                    ),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    errorWidget: (context, _, __) => Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/album.png',
                                      ),
                                    ),
                                    imageUrl:
                                        'https://avatar-ex-swe.nixcdn.com/song/2018/11/08/2/8/3/9/1541660658234_640.jpg',
                                    placeholder: (context, url) => Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/album.png',
                                      ),
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
                                    LikeButton(data: {}),
                                    SongTileTrailingMenu(
                                      data: {},
                                    ),
                                  ],
                                ),
                                onLongPress: () {
                                  copyToClipboard(
                                    context: context,
                                    text: '',
                                  );
                                },
                                onTap: () {},
                              ),
                              ListTile(
                                contentPadding: const EdgeInsets.only(
                                  left: 15.0,
                                ),
                                title: Text(
                                  'Xin Em',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  'Bùi Anh Tuấn',
                                  style: TextStyle(color: Colors.white70),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                isThreeLine: false,
                                leading: Card(
                                  margin: EdgeInsets.zero,
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      7.0,
                                    ),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    errorWidget: (context, _, __) => Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/album.png',
                                      ),
                                    ),
                                    imageUrl:
                                        'https://avatar-ex-swe.nixcdn.com/song/2018/11/08/2/8/3/9/1541660658234_640.jpg',
                                    placeholder: (context, url) => Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/album.png',
                                      ),
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
                                    LikeButton(data: {}),
                                    SongTileTrailingMenu(
                                      data: {},
                                    ),
                                  ],
                                ),
                                onLongPress: () {
                                  copyToClipboard(
                                    context: context,
                                    text: '',
                                  );
                                },
                                onTap: () {},
                              ),
                              ListTile(
                                contentPadding: const EdgeInsets.only(
                                  left: 15.0,
                                ),
                                title: Text(
                                  'Xin Em',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  'Bùi Anh Tuấn',
                                  style: TextStyle(color: Colors.white70),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                isThreeLine: false,
                                leading: Card(
                                  margin: EdgeInsets.zero,
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      7.0,
                                    ),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    errorWidget: (context, _, __) => Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/album.png',
                                      ),
                                    ),
                                    imageUrl:
                                        'https://avatar-ex-swe.nixcdn.com/song/2018/11/08/2/8/3/9/1541660658234_640.jpg',
                                    placeholder: (context, url) => Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/album.png',
                                      ),
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
                                    LikeButton(data: {}),
                                    SongTileTrailingMenu(
                                      data: {},
                                    ),
                                  ],
                                ),
                                onLongPress: () {
                                  copyToClipboard(
                                    context: context,
                                    text: '',
                                  );
                                },
                                onTap: () {},
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 25, top: 10, bottom: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Playlist',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 4, 192, 60),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    25,
                                    0,
                                    25,
                                    0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
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
                                                  SongsListScreen(Id:"0"),
                                            ),
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              'View All',
                                              style: TextStyle(
                                                color: Colors.white70,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                            Icon(
                                              Icons.chevron_right_rounded,
                                              color: Colors.white70,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(
                              left: 5,
                              right: 10,
                            ),
                            children: [
                              ListTile(
                                contentPadding: const EdgeInsets.only(
                                  left: 15.0,
                                ),
                                title: Text(
                                  'Xin Em',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  'Bùi Anh Tuấn',
                                  style: TextStyle(color: Colors.white70),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                isThreeLine: false,
                                leading: Card(
                                  margin: EdgeInsets.zero,
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      7.0,
                                    ),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    errorWidget: (context, _, __) => Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/album.png',
                                      ),
                                    ),
                                    imageUrl:
                                        'https://avatar-ex-swe.nixcdn.com/song/2018/11/08/2/8/3/9/1541660658234_640.jpg',
                                    placeholder: (context, url) => Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/album.png',
                                      ),
                                    ),
                                  ),
                                ),
                                trailing: null,
                                onLongPress: () {
                                  copyToClipboard(
                                    context: context,
                                    text: '',
                                  );
                                },
                                onTap: () {},
                              ),
                              ListTile(
                                contentPadding: const EdgeInsets.only(
                                  left: 15.0,
                                ),
                                title: Text(
                                  'Xin Em',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  'Bùi Anh Tuấn',
                                  style: TextStyle(color: Colors.white70),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                isThreeLine: false,
                                leading: Card(
                                  margin: EdgeInsets.zero,
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      7.0,
                                    ),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    errorWidget: (context, _, __) => Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/album.png',
                                      ),
                                    ),
                                    imageUrl:
                                        'https://avatar-ex-swe.nixcdn.com/song/2018/11/08/2/8/3/9/1541660658234_640.jpg',
                                    placeholder: (context, url) => Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/album.png',
                                      ),
                                    ),
                                  ),
                                ),
                                trailing: null,
                                onLongPress: () {
                                  copyToClipboard(
                                    context: context,
                                    text: '',
                                  );
                                },
                                onTap: () {},
                              ),
                              ListTile(
                                contentPadding: const EdgeInsets.only(
                                  left: 15.0,
                                ),
                                title: Text(
                                  'Xin Em',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  'Bùi Anh Tuấn',
                                  style: TextStyle(color: Colors.white70),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                isThreeLine: false,
                                leading: Card(
                                  margin: EdgeInsets.zero,
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      7.0,
                                    ),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    errorWidget: (context, _, __) => Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/album.png',
                                      ),
                                    ),
                                    imageUrl:
                                        'https://avatar-ex-swe.nixcdn.com/song/2018/11/08/2/8/3/9/1541660658234_640.jpg',
                                    placeholder: (context, url) => Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/album.png',
                                      ),
                                    ),
                                  ),
                                ),
                                trailing: null,
                                onLongPress: () {
                                  copyToClipboard(
                                    context: context,
                                    text: '',
                                  );
                                },
                                onTap: () {},
                              ),
                              ListTile(
                                contentPadding: const EdgeInsets.only(
                                  left: 15.0,
                                ),
                                title: Text(
                                  'Xin Em',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  'Bùi Anh Tuấn',
                                  style: TextStyle(color: Colors.white70),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                isThreeLine: false,
                                leading: Card(
                                  margin: EdgeInsets.zero,
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      7.0,
                                    ),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    errorWidget: (context, _, __) => Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/album.png',
                                      ),
                                    ),
                                    imageUrl:
                                        'https://avatar-ex-swe.nixcdn.com/song/2018/11/08/2/8/3/9/1541660658234_640.jpg',
                                    placeholder: (context, url) => Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/album.png',
                                      ),
                                    ),
                                  ),
                                ),
                                trailing: null,
                                onLongPress: () {
                                  copyToClipboard(
                                    context: context,
                                    text: '',
                                  );
                                },
                                onTap: () {},
                              ),
                            ],
                          )
                        ],
                      ),
                    ]),
                  ),
                  onSubmitted: (String submittedQuery) {
                    setState(
                      () {
                        fetched = false;
                        query = submittedQuery;
                        status = false;
                        fromHome = false;
                        searchedData = {};
                      },
                    );
                  },
                  onQueryCleared: () {
                    setState(() {
                      fromHome = true;
                    });
                  },
                ),
              ),
            ),
            MiniPlayer(),
          ],
        ),
      ),
    );
  }
}
