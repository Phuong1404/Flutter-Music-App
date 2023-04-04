import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';
import 'package:music_app/Widgets/collage.widget.dart';
import 'package:music_app/Widgets/custom_physics.widget.dart';
import 'package:music_app/Widgets/download_button.widget.dart';
import 'package:music_app/Widgets/empty_screen.widget.dart';
import 'package:music_app/Widgets/gradient_container.widget.dart';
import 'package:music_app/Widgets/like_button.widget.dart';
import 'package:music_app/Widgets/miniplayer.widget.dart';
import 'package:music_app/Widgets/playlist_head.widget.dart';
import 'package:music_app/Widgets/song_tile_trailing_menu.widget.dart';

class LikedSongs extends StatefulWidget {
  final String playlistName;
  final String? showName;
  final bool fromPlaylist;
  final List? songs;
  const LikedSongs({
    super.key,
    required this.playlistName,
    this.showName,
    this.fromPlaylist = false,
    this.songs,
  });
  @override
  _LikedSongsState createState() => _LikedSongsState();
  static const routeName = '/favorite';
}

class _LikedSongsState extends State<LikedSongs>
    with SingleTickerProviderStateMixin {
  Box? likedBox;
  bool added = false;
  // String? tempPath = Hive.box('settings').get('tempDirPath')?.toString();
  List _songs = [];
  final Map<String, List<Map>> _albums = {};
  final Map<String, List<Map>> _artists = {};
  final Map<String, List<Map>> _genres = {};
  List _sortedAlbumKeysList = [];
  List _sortedArtistKeysList = [];
  List _sortedGenreKeysList = [];
  TabController? _tcontroller;
  // int currentIndex = 0;
  // int sortValue = Hive.box('settings').get('sortValue', defaultValue: 1) as int;
  // int orderValue =
  //     Hive.box('settings').get('orderValue', defaultValue: 1) as int;
  // int albumSortValue =
  //     Hive.box('settings').get('albumSortValue', defaultValue: 2) as int;
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _showShuffle = ValueNotifier<bool>(true);

  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
  }

  @override
  void initState() {
    _tcontroller = TabController(length: 4, vsync: this);
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        _showShuffle.value = false;
      } else {
        _showShuffle.value = true;
      }
    });
    // if (tempPath == null) {
    //   getTemporaryDirectory().then((value) {
    //     Hive.box('settings').put('tempDirPath', value.path);
    //   });
    // }
    // _tcontroller!.addListener(changeTitle);
    // getLiked();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tcontroller!.dispose();
    _scrollController.dispose();
  }

  // void changeTitle() {
  //   setState(() {
  //     currentIndex = _tcontroller!.index;
  //   });
  // }

  // void getLiked() {
  //   likedBox = Hive.box(widget.playlistName);
  //   if (widget.fromPlaylist) {
  //     _songs = widget.songs!;
  //   } else {
  //     _songs = likedBox?.values.toList() ?? [];
  //     songs_count.addSongsCount(
  //       widget.playlistName,
  //       _songs.length,
  //       _songs.length >= 4
  //           ? _songs.sublist(0, 4)
  //           : _songs.sublist(0, _songs.length),
  //     );
  //   }
  //   setArtistAlbum();
  // }

  // void setArtistAlbum() {
  //   for (final element in _songs) {
  //     if (_albums.containsKey(element['album'])) {
  //       final List<Map> tempAlbum = _albums[element['album']]!;
  //       tempAlbum.add(element as Map);
  //       _albums.addEntries([MapEntry(element['album'].toString(), tempAlbum)]);
  //     } else {
  //       _albums.addEntries([
  //         MapEntry(element['album'].toString(), [element as Map])
  //       ]);
  //     }

  //     element['artist'].toString().split(', ').forEach((singleArtist) {
  //       if (_artists.containsKey(singleArtist)) {
  //         final List<Map> tempArtist = _artists[singleArtist]!;
  //         tempArtist.add(element);
  //         _artists.addEntries([MapEntry(singleArtist, tempArtist)]);
  //       } else {
  //         _artists.addEntries([
  //           MapEntry(singleArtist, [element])
  //         ]);
  //       }
  //     });

  //     if (_genres.containsKey(element['genre'])) {
  //       final List<Map> tempGenre = _genres[element['genre']]!;
  //       tempGenre.add(element);
  //       _genres.addEntries([MapEntry(element['genre'].toString(), tempGenre)]);
  //     } else {
  //       _genres.addEntries([
  //         MapEntry(element['genre'].toString(), [element])
  //       ]);
  //     }
  //   }

  //   sortSongs(sortVal: sortValue, order: orderValue);

  //   _sortedAlbumKeysList = _albums.keys.toList();
  //   _sortedArtistKeysList = _artists.keys.toList();
  //   _sortedGenreKeysList = _genres.keys.toList();

  //   sortAlbums();

  //   added = true;
  //   setState(() {});
  // }

  // void sortSongs({required int sortVal, required int order}) {
  //   switch (sortVal) {
  //     case 0:
  //       _songs.sort(
  //         (a, b) => a['title']
  //             .toString()
  //             .toUpperCase()
  //             .compareTo(b['title'].toString().toUpperCase()),
  //       );
  //       break;
  //     case 1:
  //       _songs.sort(
  //         (a, b) => a['dateAdded']
  //             .toString()
  //             .toUpperCase()
  //             .compareTo(b['dateAdded'].toString().toUpperCase()),
  //       );
  //       break;
  //     case 2:
  //       _songs.sort(
  //         (a, b) => a['album']
  //             .toString()
  //             .toUpperCase()
  //             .compareTo(b['album'].toString().toUpperCase()),
  //       );
  //       break;
  //     case 3:
  //       _songs.sort(
  //         (a, b) => a['artist']
  //             .toString()
  //             .toUpperCase()
  //             .compareTo(b['artist'].toString().toUpperCase()),
  //       );
  //       break;
  //     case 4:
  //       _songs.sort(
  //         (a, b) => a['duration']
  //             .toString()
  //             .toUpperCase()
  //             .compareTo(b['duration'].toString().toUpperCase()),
  //       );
  //       break;
  //     default:
  //       _songs.sort(
  //         (b, a) => a['dateAdded']
  //             .toString()
  //             .toUpperCase()
  //             .compareTo(b['dateAdded'].toString().toUpperCase()),
  //       );
  //       break;
  //   }

  //   if (order == 1) {
  //     _songs = _songs.reversed.toList();
  //   }
  // }

  // void sortAlbums() {
  //   if (albumSortValue == 0) {
  //     _sortedAlbumKeysList.sort(
  //       (a, b) =>
  //           a.toString().toUpperCase().compareTo(b.toString().toUpperCase()),
  //     );
  //     _sortedArtistKeysList.sort(
  //       (a, b) =>
  //           a.toString().toUpperCase().compareTo(b.toString().toUpperCase()),
  //     );
  //     _sortedGenreKeysList.sort(
  //       (a, b) =>
  //           a.toString().toUpperCase().compareTo(b.toString().toUpperCase()),
  //     );
  //   }
  //   if (albumSortValue == 1) {
  //     _sortedAlbumKeysList.sort(
  //       (b, a) =>
  //           a.toString().toUpperCase().compareTo(b.toString().toUpperCase()),
  //     );
  //     _sortedArtistKeysList.sort(
  //       (b, a) =>
  //           a.toString().toUpperCase().compareTo(b.toString().toUpperCase()),
  //     );
  //     _sortedGenreKeysList.sort(
  //       (b, a) =>
  //           a.toString().toUpperCase().compareTo(b.toString().toUpperCase()),
  //     );
  //   }
  //   if (albumSortValue == 2) {
  //     _sortedAlbumKeysList
  //         .sort((b, a) => _albums[a]!.length.compareTo(_albums[b]!.length));
  //     _sortedArtistKeysList
  //         .sort((b, a) => _artists[a]!.length.compareTo(_artists[b]!.length));
  //     _sortedGenreKeysList
  //         .sort((b, a) => _genres[a]!.length.compareTo(_genres[b]!.length));
  //   }
  //   if (albumSortValue == 3) {
  //     _sortedAlbumKeysList
  //         .sort((a, b) => _albums[a]!.length.compareTo(_albums[b]!.length));
  //     _sortedArtistKeysList
  //         .sort((a, b) => _artists[a]!.length.compareTo(_artists[b]!.length));
  //     _sortedGenreKeysList
  //         .sort((a, b) => _genres[a]!.length.compareTo(_genres[b]!.length));
  //   }
  //   if (albumSortValue == 4) {
  //     _sortedAlbumKeysList.shuffle();
  //     _sortedArtistKeysList.shuffle();
  //     _sortedGenreKeysList.shuffle();
  //   }
  // }

  // void deleteLiked(Map song) {
  //   setState(() {
  //     likedBox!.delete(song['id']);
  //     if (_albums[song['album']]!.length == 1) {
  //       _sortedAlbumKeysList.remove(song['album']);
  //     }
  //     _albums[song['album']]!.remove(song);

  //     song['artist'].toString().split(', ').forEach((singleArtist) {
  //       if (_artists[singleArtist]!.length == 1) {
  //         _sortedArtistKeysList.remove(singleArtist);
  //       }
  //       _artists[singleArtist]!.remove(song);
  //     });

  //     if (_genres[song['genre']]!.length == 1) {
  //       _sortedGenreKeysList.remove(song['genre']);
  //     }
  //     _genres[song['genre']]!.remove(song);

  //     _songs.remove(song);
  //     songs_count.addSongsCount(
  //       widget.playlistName,
  //       _songs.length,
  //       _songs.length >= 4
  //           ? _songs.sublist(0, 4)
  //           : _songs.sublist(0, _songs.length),
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Column(
        children: [
          Expanded(
            child: DefaultTabController(
              length: 4,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  title: Text(
                    'Favorite Songs',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  bottom: TabBar(
                    controller: _tcontroller,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: Colors.white,
                    indicatorColor: Color.fromARGB(255, 42, 215, 94),
                    tabs: [
                      Tab(
                        text: "Songs",
                      ),
                      Tab(
                        text: "Albums",
                      ),
                      Tab(
                        text: "Artists",
                      ),
                      Tab(
                        text: "Genres",
                      ),
                    ],
                  ),
                  actions: [
                    DownloadButton(
                      data: {},
                      icon: 'download',
                    ),
                    IconButton(
                      icon: const Icon(CupertinoIcons.search),
                      tooltip: 'Search',
                      onPressed: () {
                        // showSearch(
                        //   context: context,
                        //   delegate: DownloadsSearch(data: _songs),
                        // );
                      },
                    ),
                    PopupMenuButton(
                      color: Color.fromARGB(255, 22, 22, 23),
                      icon: const Icon(
                        Icons.sort_rounded,
                        color: Colors.white,
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      onSelected:
                          // (currentIndex == 0) ?
                          (int value) {
                        // if (value < 5) {
                        //   sortValue = value;
                        //   Hive.box('settings').put('sortValue', value);
                        // } else {
                        //   orderValue = value - 5;
                        //   Hive.box('settings').put('orderValue', orderValue);
                        // }
                        // sortSongs(sortVal: sortValue, order: orderValue);
                        // setState(() {});
                      },
                      // : (int value) {
                      //     albumSortValue = value;
                      //     Hive.box('settings').put('albumSortValue', value);
                      //     sortAlbums();
                      //     setState(() {});
                      //   },
                      itemBuilder:
                          // (currentIndex == 0)
                          // ?
                          (context) {
                        final List<String> sortTypes = [
                          'Display Name',
                          'Date Added',
                          'Album',
                          'Artist',
                          'Duration',
                        ];
                        final List<String> orderTypes = [
                          'Increasing',
                          'Decreasing',
                        ];
                        final menuList = <PopupMenuEntry<int>>[];
                        menuList.addAll(
                          sortTypes
                              .map(
                                (e) => PopupMenuItem(
                                  value: sortTypes.indexOf(e),
                                  child: Row(
                                    children: [
                                      // if (sortValue == sortTypes.indexOf(e))
                                      if (1 == sortTypes.indexOf(e))
                                        Icon(
                                          Icons.check_rounded,
                                          color: Colors.white,
                                        )
                                      else
                                        const SizedBox(),
                                      const SizedBox(width: 10),
                                      Text(
                                        e,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        );
                        menuList.add(
                          const PopupMenuDivider(
                            height: 10,
                          ),
                        );
                        menuList.addAll(
                          orderTypes
                              .map(
                                (e) => PopupMenuItem(
                                  value:
                                      sortTypes.length + orderTypes.indexOf(e),
                                  child: Row(
                                    children: [
                                      // if (orderValue == orderTypes.indexOf(e))s
                                      if (0 == orderTypes.indexOf(e))
                                        Icon(Icons.check_rounded,
                                            color: Colors.white)
                                      else
                                        const SizedBox(),
                                      const SizedBox(width: 10),
                                      Text(
                                        e,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        );
                        return menuList;
                      },
                    ),
                  ],
                ),
                // body: const Center(
                //         child: CircularProgressIndicator(),
                //       ),
                //     :
                body: TabBarView(
                  physics: const CustomPhysics(),
                  controller: _tcontroller,
                  children: [
                    SongsTab(
                      songs: _songs,
                      onDelete: (Map item) {
                        // deleteLiked(item);
                      },
                      playlistName: widget.playlistName,
                      scrollController: _scrollController,
                    ),
                    AlbumsTab(
                      albums: _albums,
                      type: 'album',
                      offline: false,
                      playlistName: widget.playlistName,
                      sortedAlbumKeysList: _sortedAlbumKeysList,
                    ),
                    AlbumsTab(
                      albums: _artists,
                      type: 'artist',
                      offline: false,
                      playlistName: widget.playlistName,
                      sortedAlbumKeysList: _sortedArtistKeysList,
                    ),
                    AlbumsTab(
                      albums: _genres,
                      type: 'genre',
                      offline: false,
                      playlistName: widget.playlistName,
                      sortedAlbumKeysList: _sortedGenreKeysList,
                    ),
                  ],
                ),
                floatingActionButton: ValueListenableBuilder(
                  valueListenable: _showShuffle,
                  child: FloatingActionButton(
                    backgroundColor: Color.fromARGB(255, 79, 78, 75),
                    child: Icon(
                      Icons.shuffle_rounded,
                      color: Colors.white,
                      // ? Colors.white
                      // : Colors.black,
                      size: 24.0,
                    ),
                    onPressed: () {
                      // if (_songs.isNotEmpty) {
                      //   PlayerInvoke.init(
                      //     songsList: _songs,
                      //     index: 0,
                      //     isOffline: false,
                      //     recommend: false,
                      //     shuffle: true,
                      //   );
                      // }
                    },
                  ),
                  builder: (
                    BuildContext context,
                    bool showShuffle,
                    Widget? child,
                  ) {
                    return AnimatedSlide(
                      duration: const Duration(milliseconds: 300),
                      offset: showShuffle ? Offset.zero : const Offset(0, 2),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: showShuffle ? 1 : 0,
                        child: child,
                      ),
                    );
                  },
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

class SongsTab extends StatefulWidget {
  final List songs;
  final String playlistName;
  final Function(Map item) onDelete;
  final ScrollController scrollController;
  const SongsTab({
    super.key,
    required this.songs,
    required this.onDelete,
    required this.playlistName,
    required this.scrollController,
  });

  @override
  State<SongsTab> createState() => _SongsTabState();
}

class _SongsTabState extends State<SongsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // return emptyScreen(
    //   context,
    //   3,
    //   'Nothing to ',
    //   15,
    //   'Show Here',
    //   50.0,
    //   'Go and Play Something',
    //   23.0,
    // );
    return Column(
      children: [
        PlaylistHead(
          songsList: widget.songs,
          offline: false,
          fromDownloads: false,
        ),
        Expanded(
            child: ListView(
          controller: widget.scrollController,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 10),
          shrinkWrap: true,
          itemExtent: 70.0,
          children: [
            ListTile(
              leading: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),
                ),
                clipBehavior: Clip.antiAlias,
                child: SizedBox.square(
                  dimension: 50,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    errorWidget: (context, _, __) => const Image(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/cover.jpg',
                      ),
                    ),
                    imageUrl:
                        'https://avatar-ex-swe.nixcdn.com/song/2018/11/08/2/8/3/9/1541660658234_640.jpg',
                    placeholder: (context, url) => const Image(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/cover.jpg',
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () {},
              title: Text(
                'Xin em',
                style: TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                'Bùi Anh Tuấn',
                style: TextStyle(color: Colors.white70),
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // if (widget.playlistName != 'Favorite Songs')
                  LikeButton(
                      // mediaItem: null,
                      // data: widget.songs[index] as Map,
                      ),
                  DownloadButton(
                    // data: widget.songs[index] as Map,
                    data: {},
                    icon: 'download',
                  ),
                  SongTileTrailingMenu(
                    data: {},
                    // data: widget.songs[index] as Map,
                    // isPlaylist: true,
                    // deleteLiked: widget.onDelete,
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),
                ),
                clipBehavior: Clip.antiAlias,
                child: SizedBox.square(
                  dimension: 50,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    errorWidget: (context, _, __) => const Image(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/cover.jpg',
                      ),
                    ),
                    imageUrl:
                        'https://avatar-ex-swe.nixcdn.com/song/2018/11/08/2/8/3/9/1541660658234_640.jpg',
                    placeholder: (context, url) => const Image(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/cover.jpg',
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () {},
              title: Text(
                'Xin em',
                style: TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                'Bùi Anh Tuấn',
                style: TextStyle(color: Colors.white70),
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // if (widget.playlistName != 'Favorite Songs')
                  LikeButton(
                      // mediaItem: null,
                      // data: widget.songs[index] as Map,
                      ),
                  DownloadButton(
                    // data: widget.songs[index] as Map,
                    data: {},
                    icon: 'download',
                  ),
                  SongTileTrailingMenu(
                    data: {},
                    // data: widget.songs[index] as Map,
                    // isPlaylist: true,
                    // deleteLiked: widget.onDelete,
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),
                ),
                clipBehavior: Clip.antiAlias,
                child: SizedBox.square(
                  dimension: 50,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    errorWidget: (context, _, __) => const Image(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/cover.jpg',
                      ),
                    ),
                    imageUrl:
                        'https://avatar-ex-swe.nixcdn.com/song/2018/11/08/2/8/3/9/1541660658234_640.jpg',
                    placeholder: (context, url) => const Image(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/cover.jpg',
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () {},
              title: Text(
                'Xin em',
                style: TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                'Bùi Anh Tuấn',
                style: TextStyle(color: Colors.white70),
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // if (widget.playlistName != 'Favorite Songs')
                  LikeButton(
                      // mediaItem: null,
                      // data: widget.songs[index] as Map,
                      ),
                  DownloadButton(
                    // data: widget.songs[index] as Map,
                    data: {},
                    icon: 'download',
                  ),
                  SongTileTrailingMenu(
                    data: {},
                    // data: widget.songs[index] as Map,
                    // isPlaylist: true,
                    // deleteLiked: widget.onDelete,
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),
                ),
                clipBehavior: Clip.antiAlias,
                child: SizedBox.square(
                  dimension: 50,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    errorWidget: (context, _, __) => const Image(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/cover.jpg',
                      ),
                    ),
                    imageUrl:
                        'https://avatar-ex-swe.nixcdn.com/song/2018/11/08/2/8/3/9/1541660658234_640.jpg',
                    placeholder: (context, url) => const Image(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/cover.jpg',
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () {},
              title: Text(
                'Xin em',
                style: TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                'Bùi Anh Tuấn',
                style: TextStyle(color: Colors.white70),
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // if (widget.playlistName != 'Favorite Songs')
                  LikeButton(
                      // mediaItem: null,
                      // data: widget.songs[index] as Map,
                      ),
                  DownloadButton(
                    // data: widget.songs[index] as Map,
                    data: {},
                    icon: 'download',
                  ),
                  SongTileTrailingMenu(
                    data: {},
                    // data: widget.songs[index] as Map,
                    // isPlaylist: true,
                    // deleteLiked: widget.onDelete,
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),
                ),
                clipBehavior: Clip.antiAlias,
                child: SizedBox.square(
                  dimension: 50,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    errorWidget: (context, _, __) => const Image(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/cover.jpg',
                      ),
                    ),
                    imageUrl:
                        'https://avatar-ex-swe.nixcdn.com/song/2018/11/08/2/8/3/9/1541660658234_640.jpg',
                    placeholder: (context, url) => const Image(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/cover.jpg',
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () {},
              title: Text(
                'Xin em',
                style: TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                'Bùi Anh Tuấn',
                style: TextStyle(color: Colors.white70),
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // if (widget.playlistName != 'Favorite Songs')
                  LikeButton(
                      // mediaItem: null,
                      // data: widget.songs[index] as Map,
                      ),
                  DownloadButton(
                    // data: widget.songs[index] as Map,
                    data: {},
                    icon: 'download',
                  ),
                  SongTileTrailingMenu(
                    data: {},
                    // data: widget.songs[index] as Map,
                    // isPlaylist: true,
                    // deleteLiked: widget.onDelete,
                  ),
                ],
              ),
            ),
          ],
        )),
      ],
    );
  }
}

class AlbumsTab extends StatefulWidget {
  final Map<String, List> albums;
  final List sortedAlbumKeysList;
  // final String? tempPath;
  final String type;
  final bool offline;
  final String? playlistName;
  const AlbumsTab({
    super.key,
    required this.albums,
    required this.offline,
    required this.sortedAlbumKeysList,
    required this.type,
    this.playlistName,
    // this.tempPath,
  });

  @override
  State<AlbumsTab> createState() => _AlbumsTabState();
}

class _AlbumsTabState extends State<AlbumsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // return emptyScreen(
    //   context,
    //   3,
    //   'Nothing to ',
    //   15,
    //   'Show Here',
    //   50.0,
    //   'Go and Play Something',
    //   23.0,
    // );
    return ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 10.0),
        shrinkWrap: true,
        itemExtent: 70.0,
        children: [
          ListTile(
            leading: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),
                ),
                clipBehavior: Clip.antiAlias,
                child: SizedBox.square(
                  dimension: 50,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    errorWidget: (context, _, __) => const Image(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/cover.jpg',
                      ),
                    ),
                    imageUrl:
                        'https://avatar-ex-swe.nixcdn.com/song/2018/11/08/2/8/3/9/1541660658234_640.jpg',
                    placeholder: (context, url) => const Image(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/cover.jpg',
                      ),
                    ),
                  ),
                ),
              ),
              
            title: Text(
                'Xin em',
                style: TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                'Bùi Anh Tuấn',
                style: TextStyle(color: Colors.white70),
                overflow: TextOverflow.ellipsis,
              ),
            onTap: () {
              // Navigator.of(context).push(
              //   PageRouteBuilder(
              //     opaque: false,
              //     pageBuilder: (_, __, ___) => widget.offline
              //         ? SongsList(
              //             data: widget
              //                 .albums[widget.sortedAlbumKeysList[index]]!,
              //             offline: widget.offline,
              //           )
              //         : LikedSongs(
              //             playlistName: widget.playlistName!,
              //             fromPlaylist: true,
              //             showName:
              //                 widget.sortedAlbumKeysList[index].toString(),
              //             songs: widget
              //                 .albums[widget.sortedAlbumKeysList[index]],
              //           ),
              //   ),
              // );
            },
          )
        ]);
  }
}
