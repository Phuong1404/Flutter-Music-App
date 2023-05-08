import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:music_app/API/SongAPI.api.dart';
import 'package:music_app/Screens/player/audioplayer.screen.dart';
import 'package:music_app/Services/store_token.service.dart';
import 'package:music_app/Widgets/bouncy_sliver_scroll_view.widget.dart';
import 'package:music_app/Widgets/empty_screen.widget.dart';
import 'package:music_app/Widgets/gradient_container.widget.dart';
import 'package:music_app/Widgets/miniplayer.widget.dart';

class NowPlaying extends StatefulWidget {
  @override
  _NowPlayingState createState() => _NowPlayingState();
  static const routeName = '/nowplaying';
}

class _NowPlayingState extends State<NowPlaying> {
  // final AudioPlayerHandler audioHandler = GetIt.I<AudioPlayerHandler>();
  final ScrollController _scrollController = ScrollController();
  Map dataPlaying = {};
  String image_url="";
  bool fetch = false;
  Future<void> getDataPlaying() async {
    String? userId = await StoreToken.getToken();
    if (userId != null) {
      dataPlaying = await SongApi().getPlayingSong(userId);
      image_url=dataPlaying['now_play']['image'];
      setState(() {});
    } else {
      dataPlaying = {};
    }
    fetch = true;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!fetch) {
      getDataPlaying();
    }
    return GradientContainer(
      child: Column(
        children: [
          Expanded(
              child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: dataPlaying == {}
                      ? emptyScreen(
                          context,
                          3,
                          'Nothing is ',
                          18.0,
                          'PLAYING',
                          60,
                          'Go and Play Something',
                          23.0,
                        )
                      : BouncyImageSliverScrollView(
                          scrollController: _scrollController,
                          title: 'Now Playing',
                          localImage: false,
                          imageUrl: image_url,
                          sliverList: SliverList(
                            delegate: SliverChildListDelegate(
                              [
                                // NowPlayingStream(
                                //   dataPlaying: dataPlaying,
                                // )
                              ],
                            ),
                          ),
                        ))),
          MiniPlayer(),
        ],
      ),
    );
  }
}
