import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_app/Screens/common/song_list.screen.dart';
import 'package:music_app/Widgets/bouncy_sliver_scroll_view.widget.dart';
import 'package:music_app/Widgets/copy_clipboard.widget.dart';
import 'package:music_app/Widgets/download_button.widget.dart';
import 'package:music_app/Widgets/empty_screen.widget.dart';
import 'package:music_app/Widgets/gradient_container.widget.dart';
import 'package:music_app/Widgets/miniplayer.widget.dart';

class AlbumSearchPage extends StatefulWidget {
  final String query;
  final String type;

  const AlbumSearchPage({
    super.key,
    required this.query,
    required this.type,
  });

  @override
  _AlbumSearchPageState createState() => _AlbumSearchPageState();
}

class _AlbumSearchPageState extends State<AlbumSearchPage> {
  int page = 1;
  bool loading = false;
  List<Map>? _searchedList;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
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
//---------------------------Loading-------------------------------
              // body: const Center(child: CircularProgressIndicator(),)
//-----------------------Khong co data-----------------------------
              // body: emptyScreen(
              //   context,
              //   0,
              //   ':( ',
              //   100,
              //   'SORRY',
              //   60,
              //   'Results Not Found',
              //   20,
              // )
//----------------------------Co data------------------------------
              body: BouncyImageSliverScrollView(
                scrollController: _scrollController,
                title: widget.type,
                placeholderImage: widget.type == 'Artists'
                    ? 'assets/artist.png'
                    : 'assets/album.png',
                sliverList: SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.only(right: 7),
                      child: ListTile(
                        title: Text(
                          'Xin Em',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, color: Colors.white),
                        ),
                        onLongPress: () {
                          copyToClipboard(
                            context: context,
                            text: 'Xin Em',
                          );
                        },
                        subtitle: Text(
                          'Bùi Anh Tuấn',
                          style: const TextStyle(color: Colors.white70),
                          overflow: TextOverflow.ellipsis,
                        ),
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
                                widget.type == 'Artists'
                                    ? 'assets/artist.png'
                                    : 'assets/album.png',
                              ),
                            ),
                            imageUrl:
                                'https://avatar-ex-swe.nixcdn.com/song/2018/11/08/2/8/3/9/1541660658234_640.jpg',
                            placeholder: (context, url) => Image(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                widget.type == 'Artists'
                                    ? 'assets/artist.png'
                                    : 'assets/album.png',
                              ),
                            ),
                          ),
                        ),
                        trailing: AlbumDownloadButton(albumId: '', albumName: '',),
                        // trailing: null,
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   PageRouteBuilder(
                          //     opaque: false,
                          //     pageBuilder: (_, __, ___) =>
                          //         widget.type == 'Artists'
                          //             ? ArtistSearchPage(
                          //                 data: entry,
                          //               )
                          //             : SongsListScreen(
                          //                 // listItem: entry,
                          //               ),
                          //   ),
                          // );
                        },
                      ),
                    )
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
