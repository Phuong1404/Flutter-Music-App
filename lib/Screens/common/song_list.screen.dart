import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:music_app/Widgets/bouncy_playlist_header_scroll_view.widget.dart';
import 'package:music_app/Widgets/download_button.widget.dart';
import 'package:music_app/Widgets/gradient_container.widget.dart';
import 'package:music_app/Widgets/like_button.widget.dart';
import 'package:music_app/Widgets/miniplayer.widget.dart';
import 'package:music_app/Widgets/playlist_popupmenu.widget.dart';
import 'package:music_app/Widgets/song_tile_trailing_menu.widget.dart';
import 'package:share_plus/share_plus.dart';

import '../../Widgets/copy_clipboard.widget.dart';

class SongsListScreen extends StatefulWidget {
  // final Map listItem;
  
  const SongsListScreen({
    super.key,
    // required this.listItem,
  });

  @override
  _SongsListScreenState createState() => _SongsListScreenState();
  static const routeName = '/album';
}

class _SongsListScreenState extends State<SongsListScreen> {
  int page = 1;
  bool loading = false;
  List songList = [];
  bool fetched = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // _fetchSongs();
    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels >=
    //           _scrollController.position.maxScrollExtent &&
    //       widget.listItem['type'].toString() == 'songs' &&
    //       !loading) {
    //     page += 1;
    //     _fetchSongs();
    //   }
    // });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  // void _fetchSongs() {
  //   loading = true;
  //   try {
  //     switch (widget.listItem['type'].toString()) {
  //       case 'songs':
  //         SaavnAPI()
  //             .fetchSongSearchResults(
  //           searchQuery: widget.listItem['id'].toString(),
  //           page: page,
  //         )
  //             .then((value) {
  //           setState(() {
  //             songList.addAll(value['songs'] as List);
  //             fetched = true;
  //             loading = false;
  //           });
  //           if (value['error'].toString() != '') {
  //             ShowSnackBar().showSnackBar(
  //               context,
  //               'Error: ${value["error"]}',
  //               duration: const Duration(seconds: 3),
  //             );
  //           }
  //         });
  //         break;
  //       case 'album':
  //         SaavnAPI()
  //             .fetchAlbumSongs(widget.listItem['id'].toString())
  //             .then((value) {
  //           setState(() {
  //             songList = value['songs'] as List;
  //             fetched = true;
  //             loading = false;
  //           });
  //           if (value['error'].toString() != '') {
  //             ShowSnackBar().showSnackBar(
  //               context,
  //               'Error: ${value["error"]}',
  //               duration: const Duration(seconds: 3),
  //             );
  //           }
  //         });
  //         break;
  //       case 'playlist':
  //         SaavnAPI()
  //             .fetchPlaylistSongs(widget.listItem['id'].toString())
  //             .then((value) {
  //           setState(() {
  //             songList = value['songs'] as List;
  //             fetched = true;
  //             loading = false;
  //           });
  //           if (value['error'] != null && value['error'].toString() != '') {
  //             ShowSnackBar().showSnackBar(
  //               context,
  //               'Error: ${value["error"]}',
  //               duration: const Duration(seconds: 3),
  //             );
  //           }
  //         });
  //         break;
  //       case 'mix':
  //         SaavnAPI()
  //             .getSongFromToken(
  //           widget.listItem['perma_url'].toString().split('/').last,
  //           'mix',
  //         )
  //             .then((value) {
  //           setState(() {
  //             songList = value['songs'] as List;
  //             fetched = true;
  //             loading = false;
  //           });

  //           if (value['error'] != null && value['error'].toString() != '') {
  //             ShowSnackBar().showSnackBar(
  //               context,
  //               'Error: ${value["error"]}',
  //               duration: const Duration(seconds: 3),
  //             );
  //           }
  //         });
  //         break;
  //       case 'show':
  //         SaavnAPI()
  //             .getSongFromToken(
  //           widget.listItem['perma_url'].toString().split('/').last,
  //           'show',
  //         )
  //             .then((value) {
  //           setState(() {
  //             songList = value['songs'] as List;
  //             fetched = true;
  //             loading = false;
  //           });

  //           if (value['error'] != null && value['error'].toString() != '') {
  //             ShowSnackBar().showSnackBar(
  //               context,
  //               'Error: ${value["error"]}',
  //               duration: const Duration(seconds: 3),
  //             );
  //           }
  //         });
  //         break;
  //       default:
  //         setState(() {
  //           fetched = true;
  //           loading = false;
  //         });
  //         ShowSnackBar().showSnackBar(
  //           context,
  //           'Error: Unsupported Type ${widget.listItem['type']}',
  //           duration: const Duration(seconds: 3),
  //         );
  //         break;
  //     }
  //   } catch (e) {
  //     setState(() {
  //       fetched = true;
  //       loading = false;
  //     });
  //     Logger.root.severe(
  //       'Error in song_list with type ${widget.listItem["type"]}: $e',
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Column(
        children: [
          Expanded(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              // -------------Không có data---------------------------
              // body: const Center(
              //         child: CircularProgressIndicator(),
              //       )
              //---------------------------Có data-----------------------------
              body: BouncyPlaylistHeaderScrollView(
                scrollController: _scrollController,
                actions: [
                  // if (songList.isNotEmpty)
                  //   MultiDownloadButton(
                  //     data: songList,
                  //     playlistName:
                  //         widget.listItem['title']?.toString() ?? 'Songs',
                  //   ),
                  DownloadButton(
                    data: {},
                    icon: 'download',
                  ),
                  IconButton(
                    icon: const Icon(Icons.share_rounded),
                    tooltip: 'Share',
                    onPressed: () {
                      Share.share(
                        'https://c-cl.cdn.smule.com/rs-s94/arr/18/66/011b2306-b067-44b7-ba7a-d7c',
                      );
                    },
                  ),
                  PlaylistPopupMenu(
                    data: songList,
                    title: 'Thương em là điều anh không thể ngờ',
                    // title: widget.listItem['title']?.toString() ?? 'Songs',
                  ),
                ],
                title: 'Thương em là điều anh không thể ngờ',
                subtitle: '1 Song',
                secondarySubtitle: 'Playlist. 25.8K Followers',
                // onPlayTap: () => PlayerInvoke.init(
                //   songsList: songList,
                //   index: 0,
                //   isOffline: false,
                // ),
                // onShuffleTap: () => PlayerInvoke.init(
                //   songsList: songList,
                //   index: 0,
                //   isOffline: false,
                //   shuffle: true,
                // ),
                onPlayTap: () => {},
                onShuffleTap: () => {},
                placeholderImage: 'assets/album.png',
                imageUrl:
                    'https://c-cl.cdn.smule.com/rs-s94/arr/18/66/011b2306-b067-44b7-ba7a-d7c3717fe92a.jpg',
                sliverList: SliverList(
                  delegate: SliverChildListDelegate([
                    // if (songList.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        top: 5.0,
                        bottom: 5.0,
                      ),
                      child: Text(
                        'Songs',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Color.fromARGB(255, 42, 215, 94),
                        ),
                      ),
                    ),
                    // ...songList.map((entry) {
                    // return ListTile(
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 15.0),
                      title: Text(
                        // text: '${entry["title"]}',
                        'Thương em là điều anh không thể ngờ',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                      onLongPress: () {
                        copyToClipboard(
                          context: context,
                          text: 'Thường em là điều anh không thể ngờ',
                          // text: '${entry["title"]}',
                        );
                      },
                      subtitle: Text(
                        // '${entry["subtitle"]}',
                        'Noo Phước Thịnh',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white70),
                      ),
                      leading: Card(
                        margin: EdgeInsets.zero,
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          errorWidget: (context, _, __) => const Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/cover.jpg',
                            ),
                          ),
                          imageUrl:
                              'https://c-cl.cdn.smule.com/rs-s94/arr/18/66/011b2306-b067-44b7-ba7a-d7c3717fe92a.jpg',
                          // '${entry["image"].replaceAll('http:', 'https:')}',
                          placeholder: (context, url) => const Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/cover.jpg',
                            ),
                          ),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DownloadButton(
                            data: {},
                            icon: 'download',
                          ),
                          LikeButton(
                            // mediaItem: null,
                            data: {},
                          ),
                          // SongTileTrailingMenu(data: entry),
                          SongTileTrailingMenu(
                            data: {},
                          )
                        ],
                      ),
                      // onTap: () {
                      //   PlayerInvoke.init(
                      //     songsList: songList,
                      //     index: songList.indexWhere(
                      //       (element) => element == entry,
                      //     ),
                      //     isOffline: false,
                      //   );
                      // },
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 15.0),
                      title: Text(
                        // text: '${entry["title"]}',
                        'Thương em là điều anh không thể ngờ',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                      onLongPress: () {
                        copyToClipboard(
                          context: context,
                          text: 'Thường em là điều anh không thể ngờ',
                          // text: '${entry["title"]}',
                        );
                      },
                      subtitle: Text(
                        // '${entry["subtitle"]}',
                        'Noo Phước Thịnh',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white70),
                      ),
                      leading: Card(
                        margin: EdgeInsets.zero,
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          errorWidget: (context, _, __) => const Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/cover.jpg',
                            ),
                          ),
                          imageUrl:
                              'https://c-cl.cdn.smule.com/rs-s94/arr/18/66/011b2306-b067-44b7-ba7a-d7c3717fe92a.jpg',
                          // '${entry["image"].replaceAll('http:', 'https:')}',
                          placeholder: (context, url) => const Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/cover.jpg',
                            ),
                          ),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DownloadButton(
                            data: {},
                            icon: 'download',
                          ),
                          LikeButton(
                           // mediaItem: null,
                            data: {},
                          ),
                          // SongTileTrailingMenu(data: entry),
                          SongTileTrailingMenu(
                            data: {},
                          )
                        ],
                      ),
                      // onTap: () {
                      //   PlayerInvoke.init(
                      //     songsList: songList,
                      //     index: songList.indexWhere(
                      //       (element) => element == entry,
                      //     ),
                      //     isOffline: false,
                      //   );
                      // },
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 15.0),
                      title: Text(
                        // text: '${entry["title"]}',
                        'Thương em là điều anh không thể ngờ',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                      onLongPress: () {
                        copyToClipboard(
                          context: context,
                          text: 'Thường em là điều anh không thể ngờ',
                          // text: '${entry["title"]}',
                        );
                      },
                      subtitle: Text(
                        // '${entry["subtitle"]}',
                        'Noo Phước Thịnh',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white70),
                      ),
                      leading: Card(
                        margin: EdgeInsets.zero,
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          errorWidget: (context, _, __) => const Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/cover.jpg',
                            ),
                          ),
                          imageUrl:
                              'https://c-cl.cdn.smule.com/rs-s94/arr/18/66/011b2306-b067-44b7-ba7a-d7c3717fe92a.jpg',
                          // '${entry["image"].replaceAll('http:', 'https:')}',
                          placeholder: (context, url) => const Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/cover.jpg',
                            ),
                          ),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DownloadButton(
                            data: {},
                            icon: 'download',
                          ),
                          LikeButton(
                            // mediaItem: null,
                            data: {},
                          ),
                          // SongTileTrailingMenu(data: entry),
                          SongTileTrailingMenu(
                            data: {},
                          )
                        ],
                      ),
                      // onTap: () {
                      //   PlayerInvoke.init(
                      //     songsList: songList,
                      //     index: songList.indexWhere(
                      //       (element) => element == entry,
                      //     ),
                      //     isOffline: false,
                      //   );
                      // },
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 15.0),
                      title: Text(
                        // text: '${entry["title"]}',
                        'Thương em là điều anh không thể ngờ',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                      onLongPress: () {
                        copyToClipboard(
                          context: context,
                          text: 'Thường em là điều anh không thể ngờ',
                          // text: '${entry["title"]}',
                        );
                      },
                      subtitle: Text(
                        // '${entry["subtitle"]}',
                        'Noo Phước Thịnh',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white70),
                      ),
                      leading: Card(
                        margin: EdgeInsets.zero,
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          errorWidget: (context, _, __) => const Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/cover.jpg',
                            ),
                          ),
                          imageUrl:
                              'https://c-cl.cdn.smule.com/rs-s94/arr/18/66/011b2306-b067-44b7-ba7a-d7c3717fe92a.jpg',
                          // '${entry["image"].replaceAll('http:', 'https:')}',
                          placeholder: (context, url) => const Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/cover.jpg',
                            ),
                          ),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DownloadButton(
                            data: {},
                            icon: 'download',
                          ),
                          LikeButton(
                            // mediaItem: null,
                            data: {},
                          ),
                          // SongTileTrailingMenu(data: entry),
                          SongTileTrailingMenu(
                            data: {},
                          )
                        ],
                      ),
                      // onTap: () {
                      //   PlayerInvoke.init(
                      //     songsList: songList,
                      //     index: songList.indexWhere(
                      //       (element) => element == entry,
                      //     ),
                      //     isOffline: false,
                      //   );
                      // },
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 15.0),
                      title: Text(
                        // text: '${entry["title"]}',
                        'Thương em là điều anh không thể ngờ',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                      onLongPress: () {
                        copyToClipboard(
                          context: context,
                          text: 'Thường em là điều anh không thể ngờ',
                          // text: '${entry["title"]}',
                        );
                      },
                      subtitle: Text(
                        // '${entry["subtitle"]}',
                        'Noo Phước Thịnh',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white70),
                      ),
                      leading: Card(
                        margin: EdgeInsets.zero,
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          errorWidget: (context, _, __) => const Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/cover.jpg',
                            ),
                          ),
                          imageUrl:
                              'https://c-cl.cdn.smule.com/rs-s94/arr/18/66/011b2306-b067-44b7-ba7a-d7c3717fe92a.jpg',
                          // '${entry["image"].replaceAll('http:', 'https:')}',
                          placeholder: (context, url) => const Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/cover.jpg',
                            ),
                          ),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DownloadButton(
                            data: {},
                            icon: 'download',
                          ),
                          LikeButton(
                            // mediaItem: null,
                            data: {},
                          ),
                          // SongTileTrailingMenu(data: entry),
                          SongTileTrailingMenu(
                            data: {},
                          )
                        ],
                      ),
                      // onTap: () {
                      //   PlayerInvoke.init(
                      //     songsList: songList,
                      //     index: songList.indexWhere(
                      //       (element) => element == entry,
                      //     ),
                      //     isOffline: false,
                      //   );
                      // },
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 15.0),
                      title: Text(
                        // text: '${entry["title"]}',
                        'Thương em là điều anh không thể ngờ',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                      onLongPress: () {
                        copyToClipboard(
                          context: context,
                          text: 'Thường em là điều anh không thể ngờ',
                          // text: '${entry["title"]}',
                        );
                      },
                      subtitle: Text(
                        // '${entry["subtitle"]}',
                        'Noo Phước Thịnh',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white70),
                      ),
                      leading: Card(
                        margin: EdgeInsets.zero,
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          errorWidget: (context, _, __) => const Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/cover.jpg',
                            ),
                          ),
                          imageUrl:
                              'https://c-cl.cdn.smule.com/rs-s94/arr/18/66/011b2306-b067-44b7-ba7a-d7c3717fe92a.jpg',
                          // '${entry["image"].replaceAll('http:', 'https:')}',
                          placeholder: (context, url) => const Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/cover.jpg',
                            ),
                          ),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DownloadButton(
                            data: {},
                            icon: 'download',
                          ),
                          LikeButton(
                            // mediaItem: null,
                            data: {},
                          ),
                          // SongTileTrailingMenu(data: entry),
                          SongTileTrailingMenu(
                            data: {},
                          )
                        ],
                      ),
                      // onTap: () {
                      //   PlayerInvoke.init(
                      //     songsList: songList,
                      //     index: songList.indexWhere(
                      //       (element) => element == entry,
                      //     ),
                      //     isOffline: false,
                      //   );
                      // },
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 15.0),
                      title: Text(
                        // text: '${entry["title"]}',
                        'Thương em là điều anh không thể ngờ',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                      onLongPress: () {
                        copyToClipboard(
                          context: context,
                          text: 'Thường em là điều anh không thể ngờ',
                          // text: '${entry["title"]}',
                        );
                      },
                      subtitle: Text(
                        // '${entry["subtitle"]}',
                        'Noo Phước Thịnh',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white70),
                      ),
                      leading: Card(
                        margin: EdgeInsets.zero,
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          errorWidget: (context, _, __) => const Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/cover.jpg',
                            ),
                          ),
                          imageUrl:
                              'https://c-cl.cdn.smule.com/rs-s94/arr/18/66/011b2306-b067-44b7-ba7a-d7c3717fe92a.jpg',
                          // '${entry["image"].replaceAll('http:', 'https:')}',
                          placeholder: (context, url) => const Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/cover.jpg',
                            ),
                          ),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DownloadButton(
                            data: {},
                            icon: 'download',
                          ),
                          LikeButton(
                            // mediaItem: null,
                            data: {},
                          ),
                          // SongTileTrailingMenu(data: entry),
                          SongTileTrailingMenu(
                            data: {},
                          )
                        ],
                      ),
                      // onTap: () {
                      //   PlayerInvoke.init(
                      //     songsList: songList,
                      //     index: songList.indexWhere(
                      //       (element) => element == entry,
                      //     ),
                      //     isOffline: false,
                      //   );
                      // },
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 15.0),
                      title: Text(
                        // text: '${entry["title"]}',
                        'Thương em là điều anh không thể ngờ',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                      onLongPress: () {
                        copyToClipboard(
                          context: context,
                          text: 'Thường em là điều anh không thể ngờ',
                          // text: '${entry["title"]}',
                        );
                      },
                      subtitle: Text(
                        // '${entry["subtitle"]}',
                        'Noo Phước Thịnh',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white70),
                      ),
                      leading: Card(
                        margin: EdgeInsets.zero,
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          errorWidget: (context, _, __) => const Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/cover.jpg',
                            ),
                          ),
                          imageUrl:
                              'https://c-cl.cdn.smule.com/rs-s94/arr/18/66/011b2306-b067-44b7-ba7a-d7c3717fe92a.jpg',
                          // '${entry["image"].replaceAll('http:', 'https:')}',
                          placeholder: (context, url) => const Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/cover.jpg',
                            ),
                          ),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DownloadButton(
                            data: {},
                            icon: 'download',
                          ),
                          LikeButton(
                            // mediaItem: null,
                            data: {},
                          ),
                          // SongTileTrailingMenu(data: entry),
                          SongTileTrailingMenu(
                            data: {},
                          )
                        ],
                      ),
                      // onTap: () {
                      //   PlayerInvoke.init(
                      //     songsList: songList,
                      //     index: songList.indexWhere(
                      //       (element) => element == entry,
                      //     ),
                      //     isOffline: false,
                      //   );
                      // },
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 15.0),
                      title: Text(
                        // text: '${entry["title"]}',
                        'Thương em là điều anh không thể ngờ',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                      onLongPress: () {
                        copyToClipboard(
                          context: context,
                          text: 'Thường em là điều anh không thể ngờ',
                          // text: '${entry["title"]}',
                        );
                      },
                      subtitle: Text(
                        // '${entry["subtitle"]}',
                        'Noo Phước Thịnh',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white70),
                      ),
                      leading: Card(
                        margin: EdgeInsets.zero,
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          errorWidget: (context, _, __) => const Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/cover.jpg',
                            ),
                          ),
                          imageUrl:
                              'https://c-cl.cdn.smule.com/rs-s94/arr/18/66/011b2306-b067-44b7-ba7a-d7c3717fe92a.jpg',
                          // '${entry["image"].replaceAll('http:', 'https:')}',
                          placeholder: (context, url) => const Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/cover.jpg',
                            ),
                          ),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DownloadButton(
                            data: {},
                            icon: 'download',
                          ),
                          LikeButton(
                            // mediaItem: null,
                            data: {},
                          ),
                          // SongTileTrailingMenu(data: entry),
                          SongTileTrailingMenu(
                            data: {},
                          )
                        ],
                      ),
                      // onTap: () {
                      //   PlayerInvoke.init(
                      //     songsList: songList,
                      //     index: songList.indexWhere(
                      //       (element) => element == entry,
                      //     ),
                      //     isOffline: false,
                      //   );
                      // },
                    ),
                    
                    // })
                  ]),
                ),
              ),

              // !fetched
              //     ? const Center(
              //         child: CircularProgressIndicator(),
              //       )
              //     : BouncyPlaylistHeaderScrollView(
              //         scrollController: _scrollController,
              //         actions: [
              //           if (songList.isNotEmpty)
              //             MultiDownloadButton(
              //               data: songList,
              //               playlistName:
              //                   widget.listItem['title']?.toString() ?? 'Songs',
              //             ),
              //           IconButton(
              //             icon: const Icon(Icons.share_rounded),
              //             tooltip: AppLocalizations.of(context)!.share,
              //             onPressed: () {
              //               Share.share(
              //                 widget.listItem['perma_url'].toString(),
              //               );
              //             },
              //           ),
              //           PlaylistPopupMenu(
              //             data: songList,
              //             title:
              //                 widget.listItem['title']?.toString() ?? 'Songs',
              //           ),
              //         ],
              //         title: widget.listItem['title']?.toString().unescape() ??
              //             'Songs',
              //         subtitle: '${songList.length} Songs',
              //         secondarySubtitle:
              //             widget.listItem['subTitle']?.toString() ??
              //                 widget.listItem['subtitle']?.toString(),
              //         onPlayTap: () => PlayerInvoke.init(
              //           songsList: songList,
              //           index: 0,
              //           isOffline: false,
              //         ),
              //         onShuffleTap: () => PlayerInvoke.init(
              //           songsList: songList,
              //           index: 0,
              //           isOffline: false,
              //           shuffle: true,
              //         ),
              //         placeholderImage: 'assets/album.png',
              //         imageUrl:
              //             getImageUrl(widget.listItem['image']?.toString()),
              //         sliverList: SliverList(
              //           delegate: SliverChildListDelegate([
              //             if (songList.isNotEmpty)
              //               Padding(
              //                 padding: const EdgeInsets.only(
              //                   left: 20.0,
              //                   top: 5.0,
              //                   bottom: 5.0,
              //                 ),
              //                 child: Text(
              //                   AppLocalizations.of(context)!.songs,
              //                   style: TextStyle(
              //                     fontWeight: FontWeight.bold,
              //                     fontSize: 18.0,
              //                     color:
              //                         Theme.of(context).colorScheme.secondary,
              //                   ),
              //                 ),
              //               ),
              //             ...songList.map((entry) {
              //               return ListTile(
              //                 contentPadding: const EdgeInsets.only(left: 15.0),
              //                 title: Text(
              //                   '${entry["title"]}',
              //                   overflow: TextOverflow.ellipsis,
              //                   style: const TextStyle(
              //                     fontWeight: FontWeight.w500,
              //                   ),
              //                 ),
              //                 onLongPress: () {
              //                   copyToClipboard(
              //                     context: context,
              //                     text: '${entry["title"]}',
              //                   );
              //                 },
              //                 subtitle: Text(
              //                   '${entry["subtitle"]}',
              //                   overflow: TextOverflow.ellipsis,
              //                 ),
              //                 leading: Card(
              //                   margin: EdgeInsets.zero,
              //                   elevation: 8,
              //                   shape: RoundedRectangleBorder(
              //                     borderRadius: BorderRadius.circular(7.0),
              //                   ),
              //                   clipBehavior: Clip.antiAlias,
              //                   child: CachedNetworkImage(
              //                     fit: BoxFit.cover,
              //                     errorWidget: (context, _, __) => const Image(
              //                       fit: BoxFit.cover,
              //                       image: AssetImage(
              //                         'assets/cover.jpg',
              //                       ),
              //                     ),
              //                     imageUrl:
              //                         '${entry["image"].replaceAll('http:', 'https:')}',
              //                     placeholder: (context, url) => const Image(
              //                       fit: BoxFit.cover,
              //                       image: AssetImage(
              //                         'assets/cover.jpg',
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //                 trailing: Row(
              //                   mainAxisSize: MainAxisSize.min,
              //                   children: [
              //                     DownloadButton(
              //                       data: entry as Map,
              //                       icon: 'download',
              //                     ),
              //                     LikeButton(
              //                       // mediaItem: null,
              //                       data: entry,
              //                     ),
              //                     SongTileTrailingMenu(data: entry),
              //                   ],
              //                 ),
              //                 onTap: () {
              //                   PlayerInvoke.init(
              //                     songsList: songList,
              //                     index: songList.indexWhere(
              //                       (element) => element == entry,
              //                     ),
              //                     isOffline: false,
              //                   );
              //                 },
              //               );
              //             })
              //           ]),
              //         ),
              //       ),
            ),
          ),
          MiniPlayer(),
        ],
      ),
    );
  }
}
