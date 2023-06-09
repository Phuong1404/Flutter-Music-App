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
  final AudioPlayerHandler audioHandler = GetIt.I<AudioPlayerHandler>();
  final ScrollController _scrollController = ScrollController();
  Map dataPlaying = {};
  bool fetch = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Column(
        children: [
          Expanded(
              child: StreamBuilder<PlaybackState>(
                  stream: audioHandler.playbackState,
                  builder: (context, snapshot) {
                    final playbackState = snapshot.data;
                    final processingState = playbackState?.processingState;
                    return Scaffold(
                      backgroundColor: Colors.transparent,
                      appBar: processingState != AudioProcessingState.idle
                          ? null
                          : AppBar(
                              title: Text('Now Playing'),
                              centerTitle: true,
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            ),
                      body: processingState == AudioProcessingState.idle
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
                          : StreamBuilder<MediaItem?>(
                              stream: audioHandler.mediaItem,
                              builder: (context, snapshot) {
                                final mediaItem = snapshot.data;
                                return mediaItem == null
                                    ? const SizedBox()
                                    : BouncyImageSliverScrollView(
                                        scrollController: _scrollController,
                                        title: 'Now Playing',
                                        localImage: false,
                                        imageUrl: mediaItem.extras!['image']
                                            .toString(),
                                        sliverList: SliverList(
                                          delegate: SliverChildListDelegate(
                                            [
                                              NowPlayingStream(
                                                audioHandler: audioHandler,
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                              },
                            ),
                    );
                  })),
          MiniPlayer(),
        ],
      ),
    );
  }
}
