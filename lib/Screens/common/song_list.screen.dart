import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:music_app/API/AlbumAPI.api.dart';
import 'package:music_app/Widgets/bouncy_playlist_header_scroll_view.widget.dart';
import 'package:music_app/Widgets/copy_clipboard.widget.dart';
import 'package:music_app/Widgets/download_button.widget.dart';
import 'package:music_app/Widgets/gradient_container.widget.dart';
import 'package:music_app/Widgets/like_button.widget.dart';
import 'package:music_app/Widgets/miniplayer.widget.dart';
import 'package:music_app/Widgets/playlist_popupmenu.widget.dart';
import 'package:music_app/Widgets/song_tile_trailing_menu.widget.dart';
import 'package:share_plus/share_plus.dart';



class SongsListScreen extends StatefulWidget {
  // final Map listItem;
  final String Id;
  const SongsListScreen({super.key, required this.Id
      // required this.listItem,
      });

  @override
  _SongsListScreenState createState() => _SongsListScreenState();
}

class _SongsListScreenState extends State<SongsListScreen> {
  int page = 1;
  bool loading = false;
  List songList = [];
  Map albumData = {};
  bool fetched = false;
  final ScrollController _scrollController = ScrollController();

  Future<Map> getSongFromAPI() async {
    final albumId = widget.Id;
    final data = await AlbumAPI().getSongInAlbum(albumId);
    if (data['message'] == null) {
      print(data);
      return data;
    }
    return {};
  }

  Future<void> _fetchSongs() async {
    loading = true;
    albumData = await getSongFromAPI();
    songList = albumData['song'];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _fetchSongs();
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

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Column(
        children: [
          Expanded(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: songList.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 4, 192, 60),
                      ),
                    )
                  : BouncyPlaylistHeaderScrollView(
                      scrollController: _scrollController,

                      actions: [
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
                      title: albumData['name'],
                      subtitle: songList.length > 1
                          ? songList.length.toString() + " Songs"
                          : "1 Song",
                      secondarySubtitle: albumData['artist'] != null
                          ? albumData['artist']
                          : 'Playlist. 25.8K Followers',
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
                      imageUrl: albumData['image'],
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
                          ...songList.map((entry) {
                            return ListTile(
                              contentPadding: const EdgeInsets.only(left: 15.0),
                              title: Text(
                                entry['name'],
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              onLongPress: () {
                                copyToClipboard(
                                  context: context,
                                  text: entry['name'],
                                );
                              },
                              subtitle: Text(
                                // '${entry["subtitle"]}',
                                entry['artist'],
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
                                  imageUrl:entry['image'],
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
                            );
                          })
                        ]),
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
