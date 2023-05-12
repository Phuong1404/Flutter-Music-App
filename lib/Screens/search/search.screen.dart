import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:music_app/API/SearchAPI.api.dart';
import 'package:music_app/Screens/common/song_list.screen.dart';
import 'package:music_app/Screens/search/albums.dart';
import 'package:music_app/Screens/search/artists.dart';
import 'package:music_app/Services/player_service.dart';
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
  List search = Hive.box('settings').get(
    'search',
    defaultValue: [],
  ) as List;
  bool showHistory =
      Hive.box('settings').get('showHistory', defaultValue: true) as bool;
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

  Future<void> fetchResults() async {
    // this fetches top 5 songs results
    final Map result =
        await SearchAPI().getSongSearch(query == '' ? widget.query : query);
    final List songResults = result['songs'] as List;
    if (songResults.isNotEmpty) {
      searchedData['Songs'] = songResults;
    } else {
      searchedData['Songs'] = [];
    }

    fetched = true;
    // this fetches albums, playlists, artists, etc
    final List<Map> value =
        await SearchAPI().getAllSearch(query == '' ? widget.query : query);

    searchedData.addEntries(value[0].entries);
    albumFetched = true;
    setState(
      () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    fromHome ??= widget.fromHome;
    if (!status) {
      status = true;
      fetchResults();
    }
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
                  body: (fromHome!)
                      ? SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 76,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Wrap(
                                  children: List<Widget>.generate(search.length,
                                      (int index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0,
                                      ),
                                      child: GestureDetector(
                                        child: Chip(
                                          elevation: 0,
                                          shape: StadiumBorder(
                                              side: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 77, 77, 77))),
                                          backgroundColor:
                                              Color.fromARGB(255, 77, 77, 77),
                                          label: Text(
                                            search[index].toString(),
                                          ),
                                          labelStyle: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          deleteIconColor: Colors.white,
                                          onDeleted: () {
                                            setState(() {
                                              search.removeAt(index);
                                              Hive.box('settings').put(
                                                'search',
                                                search,
                                              );
                                            });
                                          },
                                        ),
                                        onTap: () {
                                          setState(
                                            () {
                                              fetched = false;
                                              query = search[index]
                                                  .toString()
                                                  .trim();
                                              controller.text = query;
                                              status = false;
                                              fromHome = false;
                                              searchedData = {};
                                            },
                                          );
                                        },
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                        )
                      : !fetched
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Color.fromARGB(255, 4, 192, 60)
                              ),
                            )
                          : (searchedData.isEmpty)
                              ? nothingFound(context)
                              : SingleChildScrollView(
                                  padding: const EdgeInsets.only(
                                    top: 70,
                                  ),
                                  physics: const BouncingScrollPhysics(),
                                  child: Column(children: [
                                    if (searchedData['artist'].length > 0)
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 25, top: 10, bottom: 7),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Artists',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 4, 192, 60),
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                    25,
                                                    0,
                                                    25,
                                                    0,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
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
                                                                query: query ==
                                                                        ''
                                                                    ? widget
                                                                        .query
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
                                                                color: Colors
                                                                    .white70,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                              ),
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .chevron_right_rounded,
                                                              color: Colors
                                                                  .white70,
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
                                          ListView.builder(
                                              itemCount:
                                                  searchedData['artist'].length,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              padding: const EdgeInsets.only(
                                                left: 5,
                                                right: 10,
                                              ),
                                              itemBuilder: (context, index) {
                                                final int count =
                                                    searchedData['artist']
                                                                    [index]
                                                                ['song_list']
                                                            .length as int? ??
                                                        0;
                                                String countText = "";
                                                count > 1
                                                    ? countText = '$count Songs'
                                                    : countText = '$count Song';
                                                return ListTile(
                                                  contentPadding:
                                                      const EdgeInsets.only(
                                                    left: 15.0,
                                                  ),
                                                  title: Text(
                                                    searchedData['artist']
                                                            [index]['name']
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  subtitle: Text(
                                                    countText,
                                                    style: TextStyle(
                                                        color: Colors.white70),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  isThreeLine: false,
                                                  leading: Card(
                                                    margin: EdgeInsets.zero,
                                                    elevation: 8,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        50.0,
                                                      ),
                                                    ),
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      errorWidget:
                                                          (context, _, __) =>
                                                              Image(
                                                        fit: BoxFit.cover,
                                                        image: AssetImage(
                                                          'assets/album.png',
                                                        ),
                                                      ),
                                                      imageUrl:
                                                          searchedData['artist']
                                                              [index]['avatar'],
                                                      placeholder:
                                                          (context, url) =>
                                                              Image(
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
                                                      text:
                                                          searchedData['artist']
                                                                      [index]
                                                                  ['name']
                                                              .toString(),
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
                                                                data: searchedData[
                                                                        'artist']
                                                                    [
                                                                    index] as Map),
                                                      ),
                                                    );
                                                  },
                                                );
                                              }),
                                        ],
                                      ),
                                    if (searchedData['album'].length > 0)
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 25, top: 10, bottom: 7),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Albums',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 4, 192, 60),
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                    25,
                                                    0,
                                                    25,
                                                    0,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
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
                                                                query: query ==
                                                                        ''
                                                                    ? widget
                                                                        .query
                                                                    : query,
                                                                type: 'Albums',
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'View All',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white70,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                              ),
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .chevron_right_rounded,
                                                              color: Colors
                                                                  .white70,
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
                                          ListView.builder(
                                              itemCount:
                                                  searchedData['album'].length,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              padding: const EdgeInsets.only(
                                                left: 5,
                                                right: 10,
                                              ),
                                              itemBuilder: (context, index) {
                                                final int count =
                                                    searchedData['album'][index]
                                                                ['song_list']
                                                            .length as int? ??
                                                        0;
                                                String countText = "";
                                                count > 1
                                                    ? countText = '$count Songs'
                                                    : countText = '$count Song';
                                                return ListTile(
                                                  contentPadding:
                                                      const EdgeInsets.only(
                                                    left: 15.0,
                                                  ),
                                                  title: Text(
                                                    searchedData['album'][index]
                                                        ['name'],
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  subtitle: Text(
                                                    countText,
                                                    style: TextStyle(
                                                        color: Colors.white70),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  isThreeLine: false,
                                                  leading: Card(
                                                    margin: EdgeInsets.zero,
                                                    elevation: 8,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        7.0,
                                                      ),
                                                    ),
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      errorWidget:
                                                          (context, _, __) =>
                                                              Image(
                                                        fit: BoxFit.cover,
                                                        image: AssetImage(
                                                          'assets/album.png',
                                                        ),
                                                      ),
                                                      imageUrl:
                                                          searchedData['album']
                                                              [index]['image'],
                                                      placeholder:
                                                          (context, url) =>
                                                              Image(
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
                                                  onLongPress: () {
                                                    copyToClipboard(
                                                      context: context,
                                                      text:
                                                          searchedData['album']
                                                              [index]['name'],
                                                    );
                                                  },
                                                  onTap: () {},
                                                );
                                              }),
                                        ],
                                      ),
                                    if (searchedData['Songs'].length > 0)
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 25, top: 10, bottom: 7),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Songs',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 4, 192, 60),
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                    25,
                                                    0,
                                                    25,
                                                    0,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
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
                                                                  SongsListScreen(
                                                                listItem: {
                                                                  "id": "",
                                                                  "name": "",
                                                                  "image": "",
                                                                  "release_date":
                                                                      "",
                                                                  "topic": "",
                                                                  "artist": "",
                                                                  "song_count":
                                                                      searchedData[
                                                                              'Songs']
                                                                          .length,
                                                                  "song_list":
                                                                      searchedData[
                                                                          'Songs']
                                                                },
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'View All',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white70,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                              ),
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .chevron_right_rounded,
                                                              color: Colors
                                                                  .white70,
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
                                          ListView.builder(
                                              itemCount:
                                                  searchedData['Songs'].length,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              padding: const EdgeInsets.only(
                                                left: 5,
                                                right: 10,
                                              ),
                                              itemBuilder: (context, index) {
                                                return ListTile(
                                                  contentPadding:
                                                      const EdgeInsets.only(
                                                    left: 15.0,
                                                  ),
                                                  title: Text(
                                                    searchedData['Songs'][index]
                                                        ['name'],
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  subtitle: Text(
                                                    searchedData['Songs'][index]
                                                        ['artist'],
                                                    style: TextStyle(
                                                        color: Colors.white70),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  isThreeLine: false,
                                                  leading: Card(
                                                    margin: EdgeInsets.zero,
                                                    elevation: 8,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        7.0,
                                                      ),
                                                    ),
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      errorWidget:
                                                          (context, _, __) =>
                                                              Image(
                                                        fit: BoxFit.cover,
                                                        image: AssetImage(
                                                          'assets/album.png',
                                                        ),
                                                      ),
                                                      imageUrl:
                                                          searchedData['Songs']
                                                              [index]['image'],
                                                      placeholder:
                                                          (context, url) =>
                                                              Image(
                                                        fit: BoxFit.cover,
                                                        image: AssetImage(
                                                          'assets/album.png',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  trailing: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
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
                                                      text:
                                                          searchedData['Songs']
                                                              [index]['name'],
                                                    );
                                                  },
                                                  onTap: () {
                                                    PlayerInvoke.init(
                                                      songsList: [
                                                        searchedData['Songs']
                                                            [index]
                                                      ],
                                                      index: 0,
                                                      isOffline: false,
                                                    );
                                                    Navigator.pushNamed(
                                                      context,
                                                      '/player',
                                                    );
                                                  },
                                                );
                                              })
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
