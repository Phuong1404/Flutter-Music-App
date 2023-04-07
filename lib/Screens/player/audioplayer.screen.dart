import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:music_app/Screens/common/song_list.screen.dart';
import 'package:music_app/Screens/search/albums.dart';
import 'package:music_app/Widgets/animated_text.widget.dart';
import 'package:music_app/Widgets/copy_clipboard.widget.dart';
import 'package:music_app/Widgets/download_button.widget.dart';
import 'package:music_app/Widgets/empty_screen.widget.dart';
import 'package:music_app/Widgets/like_button.widget.dart';
import 'package:music_app/Widgets/seek_bar.widget.dart';
import 'package:music_app/Widgets/snackbar.widget.dart';
import 'package:music_app/Widgets/textinput_dialog.widget.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});
  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  final String gradientType = "124";
  final bool getLyricsOnline = true;
  final ValueNotifier<List<Color?>?> gradientColor =
      ValueNotifier<List<Color?>?>(
    [
      Colors.grey[850]!,
      Colors.grey[900]!,
      Colors.black,
    ],
  );
  final PanelController _panelController = PanelController();
  // final AudioPlayerHandler audioHandler = AudioPlayerHandler();
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  late Duration _time;
  @override
  Widget build(BuildContext context) {
    BuildContext? scaffoldContext;
    return Dismissible(
      direction: DismissDirection.down,
      background: const ColoredBox(color: Colors.transparent),
      key: const Key('playScreen'),
      onDismissed: (direction) {
        Navigator.pop(context);
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
// ---------------------------------------------------------------
          backgroundColor: Colors.black,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.expand_more_rounded),
              tooltip: 'Back',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.lyrics_rounded),
                tooltip: 'Lyrics',
                onPressed: () => {},
              ),
              //--------------------------------------------------------------------------------------------------------
              IconButton(
                icon: const Icon(Icons.share_rounded),
                tooltip: 'Share',
                onPressed: () {
                  Share.share(
                    "0000000000000000000000000",
                  );
                },
              ),
              //--------------------------------------------------------------------------------------------
              PopupMenuButton(
                color: Color.fromARGB(255, 22, 22, 23),
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: Colors.white,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                onSelected: (int? value) {},
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 5,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.album_rounded,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                          'View Album',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 0,
                    child: Row(
                      children: [
                        Icon(
                          Icons.playlist_add_rounded,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                          'Add to Playlist',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.timer,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                          'Sleep Timer',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 4,
                    child: Row(
                      children: [
                        Icon(
                          Icons.equalizer_rounded,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                          'Equalizer',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 10,
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_rounded,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                          'Song Info',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          body: LayoutBuilder(
            builder: (
              BuildContext context,
              BoxConstraints constraints,
            ) {
              // print(constraints.maxWidth);
              // if (constraints.maxWidth > constraints.maxHeight) {
              //   return Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       // Artwork
              //       // ArtWorkWidget(
              //       //   cardKey: cardKey,
              //       //   mediaItem: mediaItem,
              //       //   width: min(
              //       //     constraints.maxHeight / 0.9,
              //       //     constraints.maxWidth / 1.8,
              //       //   ),
              //       //   audioHandler: audioHandler,
              //       //   offline: true,
              //       //   // offline: offline,
              //       //   getLyricsOnline: getLyricsOnline,
              //       // ),

              //       // title and controls
              //       // NameNControls(
              //       //   mediaItem: mediaItem,
              //       //   offline: true,
              //       //   // offline: offline,
              //       //   width: constraints.maxWidth / 2,
              //       //   height: constraints.maxHeight,
              //       //   panelController: _panelController,
              //       //   audioHandler: audioHandler,
              //       // ),
              //     ],
              //   );
              // }
              return Column(
                children: [
                  // Artwork
                  ArtWorkWidget(
                    // mediaItem: mediaItem,
                    width: constraints.maxWidth,
                  ),

                  // title and controls
                  NameNControls(
                    // mediaItem: mediaItem,
                    offline: true,
                    // offline: offline,
                    width: constraints.maxWidth,
                    height:
                        constraints.maxHeight - (constraints.maxWidth * 0.85),
                    panelController: _panelController,
                    // audioHandler: audioHandler,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class MediaState {
  final MediaItem? mediaItem;
  final Duration position;

  MediaState(this.mediaItem, this.position);
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}

class QueueState {
  static const QueueState empty =
      QueueState([], 0, [], AudioServiceRepeatMode.none);

  final List<MediaItem> queue;
  final int? queueIndex;
  final List<int>? shuffleIndices;
  final AudioServiceRepeatMode repeatMode;

  const QueueState(
    this.queue,
    this.queueIndex,
    this.shuffleIndices,
    this.repeatMode,
  );

  bool get hasPrevious =>
      repeatMode != AudioServiceRepeatMode.none || (queueIndex ?? 0) > 0;
  bool get hasNext =>
      repeatMode != AudioServiceRepeatMode.none ||
      (queueIndex ?? 0) + 1 < queue.length;

  List<int> get indices =>
      shuffleIndices ?? List.generate(queue.length, (i) => i);
}

class ControlButtons extends StatelessWidget {
  // final AudioPlayerHandler audioHandler;
  final bool shuffle;
  final bool miniplayer;
  final List buttons;
  final Color? dominantColor;

  const ControlButtons(
      // this.audioHandler,
      {
    this.shuffle = false,
    this.miniplayer = false,
    this.buttons = const ['Previous', 'Play/Pause', 'Next'],
    this.dominantColor,
  });

  @override
  Widget build(BuildContext context) {
    // final MediaItem mediaItem = audioHandler.mediaItem.value!;
    final bool online = true;
    // final bool online = mediaItem.extras!['url'].toString().startsWith('http');
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (miniplayer)
            LikeButton(
              // mediaItem: mediaItem,
              size: 22.0,
            ),
          if (!miniplayer)
            IconButton(
              icon: const Icon(Icons.skip_previous_rounded),
              iconSize: miniplayer ? 24.0 : 45.0,
              tooltip: 'Skip Previous',
              color: Colors.white,
              onPressed: () => {},
              // onPressed: queueState?.hasPrevious ?? true
              //     ? audioHandler.skipToPrevious
              //     : null,
            ),
          SizedBox(
            height: miniplayer ? 40.0 : 65.0,
            width: miniplayer ? 40.0 : 65.0,
            child: StreamBuilder<PlaybackState>(
              // stream: audioHandler.playbackState,
              builder: (context, snapshot) {
                final playbackState = snapshot.data;
                final processingState = playbackState?.processingState;
                final playing = playbackState?.playing ?? true;
                return Stack(
                  children: [
                    if (processingState == AudioProcessingState.loading ||
                        processingState == AudioProcessingState.buffering)
                      Center(
                        child: SizedBox(
                          height: miniplayer ? 40.0 : 65.0,
                          width: miniplayer ? 40.0 : 65.0,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        ),
                      ),
                    if (miniplayer)
                      Center(
                        child: playing
                            ? IconButton(
                                tooltip: "Pause",
                                // onPressed: audioHandler.pause,
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.pause_rounded,
                                ),
                                color: Colors.white,
                              )
                            : IconButton(
                                tooltip: "Play",
                                // onPressed: audioHandler.play,
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.play_arrow_rounded,
                                ),
                                color: Colors.white,
                              ),
                      )
                    else
                      Center(
                        child: SizedBox(
                          height: 59,
                          width: 59,
                          child: Center(
                            child: playing
                                ? FloatingActionButton(
                                    elevation: 10,
                                    tooltip: "Pause",
                                    backgroundColor: Colors.white,
                                    // onPressed: audioHandler.pause,
                                    onPressed: () {},
                                    child: const Icon(
                                      Icons.pause_rounded,
                                      size: 40.0,
                                      color: Colors.black,
                                    ),
                                  )
                                : FloatingActionButton(
                                    elevation: 10,
                                    tooltip: "Play",
                                    backgroundColor: Colors.white,
                                    // onPressed: audioHandler.play,
                                    onPressed: () {},
                                    child: const Icon(
                                      Icons.play_arrow_rounded,
                                      size: 40.0,
                                      color: Colors.black,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.skip_next_rounded),
            iconSize: miniplayer ? 24.0 : 45.0,
            tooltip: 'Skip Next',
            color: Colors.white,
            onPressed: () => {},
            // onPressed: queueState?.hasNext ?? true
            //     ? audioHandler.skipToNext
            //     : null,
          ),
          // DownloadButton(
          //   size: 20.0,
          //   icon: 'download',
          //   data: {},
          //   // data: MediaItemConverter.mediaItemToMap(mediaItem),
          // )
        ]);
  }
}

abstract class AudioPlayerHandler implements AudioHandler {
  Stream<QueueState> get queueState;
  Future<void> moveQueueItem(int currentIndex, int newIndex);
  ValueStream<double> get volume;
  Future<void> setVolume(double volume);
  ValueStream<double> get speed;
}

class NowPlayingStream extends StatelessWidget {
  // final AudioPlayerHandler audioHandler;
  final ScrollController? scrollController;
  final PanelController? panelController;
  final bool head;
  final double headHeight;

  const NowPlayingStream({
    // required this.audioHandler,
    this.scrollController,
    this.panelController,
    this.head = false,
    this.headHeight = 50,
  });

  void _updateScrollController(
    ScrollController? controller,
    int itemIndex,
    int queuePosition,
    int queueLength,
  ) {
    if (panelController != null && !panelController!.isPanelOpen) {
      if (queuePosition > 3) {
        controller?.animateTo(
          itemIndex * 72 + 12,
          curve: Curves.linear,
          duration: const Duration(
            milliseconds: 350,
          ),
        );
      } else if (queuePosition < 4 && queueLength > 4) {
        controller?.animateTo(
          (queueLength - 4) * 72 + 12,
          curve: Curves.linear,
          duration: const Duration(
            milliseconds: 350,
          ),
        );
      }
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QueueState>(
      // stream: audioHandler.queueState,
      builder: (context, snapshot) {
        final queueState = snapshot.data ?? QueueState.empty;
        final queue = queueState.queue;
        final int queueStateIndex = 1;
        // final int queueStateIndex = queueState.queueIndex ?? 0;
        // final num queuePosition = queue.length - queueStateIndex;
        final num queuePosition = 10 - queueStateIndex;
        // WidgetsBinding.instance.addPostFrameCallback(
        //   (_) => _updateScrollController(
        //     scrollController,
        //     queueState.queueIndex ?? 0,
        //     queuePosition.toInt(),
        //     queue.length,
        //   ),
        // );
        return Theme(
            data: ThemeData(canvasColor: Colors.black),
            child: ReorderableListView(
              buildDefaultDragHandles: false,
              header: SizedBox(
                height: head ? headHeight : 0,
              ),
              onReorder: (int oldIndex, int newIndex) {},
              scrollController: scrollController,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 10),
              shrinkWrap: true,
              children: <Widget>[
                Dismissible(
                  key: const ValueKey(0),
                  direction: DismissDirection.horizontal,
                  onDismissed: (dir) {
                    // audioHandler.removeQueueItemAt(index);
                  },
                  child: ListTileTheme(
                    selectedColor: Colors.transparent,
                    child: ListTile(
                      contentPadding:
                          const EdgeInsets.only(left: 16.0, right: 10.0),
                      selected: false,
                      trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          // children: (index == queueState.queueIndex)
                          //     ? [
                          //         IconButton(
                          //           icon: const Icon(
                          //             Icons.bar_chart_rounded,
                          //           ),
                          //           tooltip: 'Playing',
                          //           onPressed: () {},
                          //         )
                          //       ]
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.bar_chart_rounded,
                              ),
                              color: Color.fromARGB(255, 4, 192, 60),
                              tooltip: 'Playing',
                              onPressed: () {},
                            )
                          ]),
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: SizedBox.square(
                              dimension: 50,
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                errorWidget: (BuildContext context, _, __) =>
                                    const Image(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'assets/cover.jpg',
                                  ),
                                ),
                                placeholder: (BuildContext context, _) =>
                                    const Image(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'assets/cover.jpg',
                                  ),
                                ),
                                imageUrl:
                                    'https://avatar-ex-swe.nixcdn.com/song/2018/11/08/2/8/3/9/1541660658234_640.jpg',
                              ),
                            ),
                          ),
                        ],
                      ),
                      title: Text(
                        'Xin em',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                      subtitle: Text(
                        'Bùi Anh Tuấn',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white70),
                      ),
                      onTap: () {},
                    ),
                  ),
                ),
                Dismissible(
                  key: const ValueKey(1),
                  direction: DismissDirection.horizontal,
                  onDismissed: (dir) {
                    // audioHandler.removeQueueItemAt(index);
                  },
                  child: ListTileTheme(
                    selectedColor: Colors.transparent,
                    child: ListTile(
                      contentPadding:
                          const EdgeInsets.only(left: 16.0, right: 10.0),
                      selected: false,
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          LikeButton(
                              // mediaItem: queue[index],
                              ),
                          DownloadButton(
                              icon: 'download', size: 25.0, data: {}),
                          ReorderableDragStartListener(
                            key: Key('1'),
                            index: 1,
                            enabled: true,
                            child: const Icon(
                              Icons.drag_handle_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: SizedBox.square(
                              dimension: 50,
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                errorWidget: (BuildContext context, _, __) =>
                                    const Image(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'assets/cover.jpg',
                                  ),
                                ),
                                placeholder: (BuildContext context, _) =>
                                    const Image(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'assets/cover.jpg',
                                  ),
                                ),
                                imageUrl:
                                    'https://c-cl.cdn.smule.com/rs-s94/arr/18/66/011b2306-b067-44b7-ba7a-d7c3717fe92a.jpg',
                              ),
                            ),
                          ),
                        ],
                      ),
                      title: Text(
                        'Thương em là điều anh không thể ngờ',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                      subtitle: Text(
                        'Noo Phước Thịnh',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white70),
                      ),
                      onTap: () {},
                    ),
                  ),
                ),
                Dismissible(
                  key: const ValueKey(2),
                  direction: DismissDirection.horizontal,
                  onDismissed: (dir) {
                    // audioHandler.removeQueueItemAt(index);
                  },
                  child: ListTileTheme(
                    selectedColor: Colors.transparent,
                    child: ListTile(
                      contentPadding:
                          const EdgeInsets.only(left: 16.0, right: 10.0),
                      selected: false,
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          LikeButton(
                              // mediaItem: queue[index],
                              ),
                          DownloadButton(
                              icon: 'download', size: 25.0, data: {}),
                          ReorderableDragStartListener(
                            key: Key('2'),
                            index: 1,
                            enabled: true,
                            child: const Icon(
                              Icons.drag_handle_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: SizedBox.square(
                              dimension: 50,
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                errorWidget: (BuildContext context, _, __) =>
                                    const Image(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'assets/cover.jpg',
                                  ),
                                ),
                                placeholder: (BuildContext context, _) =>
                                    const Image(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'assets/cover.jpg',
                                  ),
                                ),
                                imageUrl:
                                    'https://avatar-ex-swe.nixcdn.com/song/2020/06/15/b/0/f/a/1592231470406_640.jpg',
                              ),
                            ),
                          ),
                        ],
                      ),
                      title: Text(
                        'Cưới nhau đi(Yes I Do)',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                      subtitle: Text(
                        'Bùi Anh Tuấn, Hiền Hồ',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                  ),
                )
              ],
            ));
        // return ReorderableListView.builder(
        //   header: SizedBox(
        //     height: head ? headHeight : 0,
        //   ),
        //   onReorder: (int oldIndex, int newIndex) {
        //     if (oldIndex < newIndex) {
        //       newIndex--;
        //     }
        //     // audioHandler.moveQueueItem(oldIndex, newIndex);
        //   },
        //   scrollController: scrollController,
        //   physics: const BouncingScrollPhysics(),
        //   padding: const EdgeInsets.only(bottom: 10),
        //   shrinkWrap: true,
        //   itemCount: queue.length,
        //   itemBuilder: (context, index) {
        //     return Dismissible(
        //       key: ValueKey(queue[index].id),
        //       direction: index == queueState.queueIndex
        //           ? DismissDirection.none
        //           : DismissDirection.horizontal,
        //       onDismissed: (dir) {
        //         // audioHandler.removeQueueItemAt(index);
        //       },
        //       child: ListTileTheme(
        //         selectedColor: Theme.of(context).colorScheme.secondary,
        //         child: ListTile(
        //           contentPadding:
        //               const EdgeInsets.only(left: 16.0, right: 10.0),
        //           selected: index == queueState.queueIndex,
        //           trailing: Row(
        //             mainAxisSize: MainAxisSize.min,
        //             children: (index == queueState.queueIndex)
        //                 ? [
        //                     IconButton(
        //                       icon: const Icon(
        //                         Icons.bar_chart_rounded,
        //                       ),
        //                       tooltip: 'Playing',
        //                       onPressed: () {},
        //                     )
        //                   ]
        //                 : [
        //                     if (queue[index]
        //                         .extras!['url']
        //                         .toString()
        //                         .startsWith('http')) ...[
        //                       // LikeButton(
        //                       //   mediaItem: queue[index],
        //                       // ),
        //                       // DownloadButton(
        //                       //   icon: 'download',
        //                       //   size: 25.0,
        //                       //   data: {
        //                       //     'id': queue[index].id,
        //                       //     'artist': queue[index].artist.toString(),
        //                       //     'album': queue[index].album.toString(),
        //                       //     'image': queue[index].artUri.toString(),
        //                       //     'duration': queue[index]
        //                       //         .duration!
        //                       //         .inSeconds
        //                       //         .toString(),
        //                       //     'title': queue[index].title,
        //                       //     'url': queue[index].extras?['url'].toString(),
        //                       //     'year':
        //                       //         queue[index].extras?['year'].toString(),
        //                       //     'language': queue[index]
        //                       //         .extras?['language']
        //                       //         .toString(),
        //                       //     'genre': queue[index].genre?.toString(),
        //                       //     '320kbps': queue[index].extras?['320kbps'],
        //                       //     'has_lyrics':
        //                       //         queue[index].extras?['has_lyrics'],
        //                       //     'release_date':
        //                       //         queue[index].extras?['release_date'],
        //                       //     'album_id': queue[index].extras?['album_id'],
        //                       //     'subtitle': queue[index].extras?['subtitle'],
        //                       //     'perma_url':
        //                       //         queue[index].extras?['perma_url'],
        //                       //   },
        //                       // )
        //                     ],
        //                     ReorderableDragStartListener(
        //                       key: Key(queue[index].id),
        //                       index: index,
        //                       enabled: index != queueState.queueIndex,
        //                       child: const Icon(Icons.drag_handle_rounded),
        //                     ),
        //                   ],
        //           ),
        //           leading: Row(
        //             mainAxisSize: MainAxisSize.min,
        //             crossAxisAlignment: CrossAxisAlignment.end,
        //             children: [
        //               if (queue[index].extras?['addedByAutoplay'] as bool? ??
        //                   false)
        //                 Column(
        //                   mainAxisAlignment: MainAxisAlignment.end,
        //                   children: [
        //                     Row(
        //                       crossAxisAlignment: CrossAxisAlignment.end,
        //                       children: [
        //                         RotatedBox(
        //                           quarterTurns: 3,
        //                           child: Text(
        //                             'Added By',
        //                             textAlign: TextAlign.start,
        //                             style: const TextStyle(
        //                               fontSize: 5.0,
        //                             ),
        //                           ),
        //                         ),
        //                         RotatedBox(
        //                           quarterTurns: 3,
        //                           child: Text(
        //                             'Autoplay',
        //                             textAlign: TextAlign.start,
        //                             style: TextStyle(
        //                               fontSize: 8.0,
        //                               color: Theme.of(context)
        //                                   .colorScheme
        //                                   .secondary,
        //                               fontWeight: FontWeight.w600,
        //                             ),
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                     const SizedBox(
        //                       height: 5.0,
        //                     ),
        //                   ],
        //                 ),
        //               Card(
        //                 elevation: 5,
        //                 shape: RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.circular(7.0),
        //                 ),
        //                 clipBehavior: Clip.antiAlias,
        //                 child: (queue[index].artUri == null)
        //                     ? const SizedBox.square(
        //                         dimension: 50,
        //                         child: Image(
        //                           image: AssetImage('assets/cover.jpg'),
        //                         ),
        //                       )
        //                     : SizedBox.square(
        //                         dimension: 50,
        //                         child: queue[index]
        //                                 .artUri
        //                                 .toString()
        //                                 .startsWith('file:')
        //                             ? Image(
        //                                 fit: BoxFit.cover,
        //                                 image: FileImage(
        //                                   File(
        //                                     queue[index].artUri!.toFilePath(),
        //                                   ),
        //                                 ),
        //                               )
        //                             : CachedNetworkImage(
        //                                 fit: BoxFit.cover,
        //                                 errorWidget:
        //                                     (BuildContext context, _, __) =>
        //                                         const Image(
        //                                   fit: BoxFit.cover,
        //                                   image: AssetImage(
        //                                     'assets/cover.jpg',
        //                                   ),
        //                                 ),
        //                                 placeholder:
        //                                     (BuildContext context, _) =>
        //                                         const Image(
        //                                   fit: BoxFit.cover,
        //                                   image: AssetImage(
        //                                     'assets/cover.jpg',
        //                                   ),
        //                                 ),
        //                                 imageUrl:
        //                                     queue[index].artUri.toString(),
        //                               ),
        //                       ),
        //               ),
        //             ],
        //           ),
        //           title: Text(
        //             queue[index].title,
        //             overflow: TextOverflow.ellipsis,
        //             style: TextStyle(
        //               fontWeight: index == queueState.queueIndex
        //                   ? FontWeight.w600
        //                   : FontWeight.normal,
        //             ),
        //           ),
        //           subtitle: Text(
        //             queue[index].artist!,
        //             overflow: TextOverflow.ellipsis,
        //           ),
        //           onTap: () {
        //             // audioHandler.skipToQueueItem(index);
        //           },
        //         ),
        //       ),
        //     );
        //   },
        // );
      },
    );
  }
}

class ArtWorkWidget extends StatefulWidget {
  // final MediaItem mediaItem;
  final double width;

  const ArtWorkWidget({
    // required this.mediaItem,
    required this.width,
  });

  @override
  _ArtWorkWidgetState createState() => _ArtWorkWidgetState();
}

class _ArtWorkWidgetState extends State<ArtWorkWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: widget.width * 0.85,
        child: Center(
          child: Card(
            elevation: 10.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            clipBehavior: Clip.antiAlias,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              errorWidget: (BuildContext context, _, __) => const Image(
                fit: BoxFit.cover,
                image: AssetImage('assets/cover.jpg'),
              ),
              placeholder: (BuildContext context, _) => const Image(
                fit: BoxFit.cover,
                image: AssetImage('assets/cover.jpg'),
              ),
              imageUrl:
                  'https://c-cl.cdn.smule.com/rs-s94/arr/18/66/011b2306-b067-44b7-ba7a-d7c3717fe92a.jpg',
              width: widget.width * 0.85,
            ),
          ),
        ));
  }
}

class NameNControls extends StatelessWidget {
  // final MediaItem mediaItem;
  final bool offline;
  final double width;
  final double height;
  final PanelController panelController;
  // final AudioPlayerHandler audioHandler;

  const NameNControls({
    required this.width,
    required this.height,
    // required this.mediaItem,
    // required this.audioHandler,
    required this.panelController,
    this.offline = false,
  });

  @override
  Widget build(BuildContext context) {
    final double titleBoxHeight = height * 0.25;
    final double seekBoxHeight = height > 500 ? height * 0.15 : height * 0.2;
    final double controlBoxHeight = offline
        ? height > 500
            ? height * 0.2
            : height * 0.25
        : (height < 350
            ? height * 0.4
            : height > 500
                ? height * 0.2
                : height * 0.3);
    final double nowplayingBoxHeight = min(70, height * 0.15);
    // height > 500 ? height * 0.4 : height * 0.15;
    // final double minNowplayingBoxHeight = height * 0.15;
    final bool useFullScreenGradient = true as bool;
    final List<String> artists = ['Bùi Anh Tuấn'];
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              /// Title and subtitle
              SizedBox(
                height: titleBoxHeight,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: titleBoxHeight / 10,
                        ),

                        /// Title container
                        AnimatedText(
                          text: 'Thương em là điều anh không thể ngờ',
                          pauseAfterRound: const Duration(seconds: 3),
                          showFadingOnlyWhenScrolling: false,
                          fadingEdgeEndFraction: 0.1,
                          fadingEdgeStartFraction: 0.1,
                          startAfter: const Duration(seconds: 2),
                          style: TextStyle(
                            fontSize: titleBoxHeight / 4.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        SizedBox(
                          height: titleBoxHeight / 40,
                        ),

                        /// Subtitle container
                        AnimatedText(
                          text: 'Noo Phước Thịnh' + '',
                          // ' • ' +
                          // 'Thương em là điều anh không thể ngờ',
                          pauseAfterRound: const Duration(seconds: 3),
                          showFadingOnlyWhenScrolling: false,
                          fadingEdgeEndFraction: 0.1,
                          fadingEdgeStartFraction: 0.1,
                          startAfter: const Duration(seconds: 2),
                          style: TextStyle(
                            fontSize: titleBoxHeight / 7.75,
                            fontWeight: FontWeight.w400,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              /// Seekbar starts from here
              // SizedBox(
              //   height: seekBoxHeight,
              //   width: width * 0.95,
              //   child: StreamBuilder<PositionData>(
              //     stream: _positionDataStream,
              //     builder: (context, snapshot) {
              //       final positionData = snapshot.data ??
              //           PositionData(
              //             Duration.zero,
              //             Duration.zero,
              //             mediaItem.duration ?? Duration.zero,
              //           );
              //       return SeekBar(
              //         // width: width,
              //         // height: height,
              //         duration: positionData.duration,
              //         position: positionData.position,
              //         bufferedPosition: positionData.bufferedPosition,
              //         offline: offline,
              //         onChangeEnd: (newPosition) {
              //           audioHandler.seek(newPosition);
              //         },
              //         audioHandler: audioHandler,
              //       );
              //     },
              //   ),
              // ),

              SizedBox(
                  height: seekBoxHeight,
                  width: width * 0.95,
                  child: SeekBar(
                    // width: width,
                    // height: height,
                    duration: Duration(minutes: 4, seconds: 2),
                    position: Duration(minutes: 1, seconds: 50),
                    bufferedPosition: Duration(minutes: 2, seconds: 30),
                    offline: offline,
                    onChangeEnd: (newPosition) {
                      // audioHandler.seek(newPosition);
                    },
                    // audioHandler: audioHandler,
                  )),

              // /// Final row starts from here
              SizedBox(
                height: controlBoxHeight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Center(
                    child: SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 6.0),
                              // StreamBuilder<bool>(s
                              //   stream: audioHandler.playbackState
                              //       .map(
                              //         (state) =>
                              //             state.shuffleMode ==
                              //             AudioServiceShuffleMode.all,
                              //       )
                              //       .distinct(),
                              //   builder: (context, snapshot) {
                              //     final shuffleModeEnabled =
                              //         snapshot.data ?? false;
                              //     return IconButton(
                              //       icon: shuffleModeEnabled
                              //           ? const Icon(
                              //               Icons.shuffle_rounded,
                              //             )
                              //           : Icon(
                              //               Icons.shuffle_rounded,
                              //               color:
                              //                   Theme.of(context).disabledColor,
                              //             ),
                              //       tooltip:
                              //           AppLocalizations.of(context)!.shuffle,
                              //       onPressed: () async {
                              //         // final enable = !shuffleModeEnabled;
                              //         // await audioHandler.setShuffleMode(
                              //         //   enable
                              //         //       ? AudioServiceShuffleMode.all
                              //         //       : AudioServiceShuffleMode.none,
                              //         // );
                              //       },
                              //     );
                              //   },
                              // ),
                              IconButton(
                                icon: const Icon(Icons.shuffle_rounded,
                                    color: Colors.white),
                                tooltip: 'Shuffle',
                                onPressed: () async {},
                              ),
                              LikeButton(size: 25.0)
                            ],
                          ),
                          ControlButtons(
                              // audioHandler,
                              ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 6.0),
                              // StreamBuilder<AudioServiceRepeatMode>(
                              //   stream: audioHandler.playbackState
                              //       .map((state) => state.repeatMode)
                              //       .distinct(),
                              //   builder: (context, snapshot) {
                              //     final repeatMode = snapshot.data ??
                              //         AudioServiceRepeatMode.none;
                              //     const texts = ['None', 'All', 'One'];
                              //     final icons = [
                              //       Icon(
                              //         Icons.repeat_rounded,
                              //         color: Theme.of(context).disabledColor,
                              //       ),
                              //       const Icon(
                              //         Icons.repeat_rounded,
                              //       ),
                              //       const Icon(
                              //         Icons.repeat_one_rounded,
                              //       ),
                              //     ];
                              //     const cycleModes = [
                              //       AudioServiceRepeatMode.none,
                              //       AudioServiceRepeatMode.all,
                              //       AudioServiceRepeatMode.one,
                              //     ];
                              //     final index = cycleModes.indexOf(repeatMode);
                              //     return IconButton(
                              //       icon: icons[index],
                              //       tooltip:
                              //           'Repeat ${texts[(index + 1) % texts.length]}',
                              //       onPressed: () async {},
                              //     );
                              //   },
                              // ),
                              IconButton(
                                icon: Icon(
                                  Icons.repeat_rounded,
                                  color: Colors.white,
                                ),
                                tooltip: 'Repeat All',
                                onPressed: () async {},
                              ),
                              DownloadButton(size: 25.0, data: {})
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: nowplayingBoxHeight,
              ),
            ],
          ),

          // Up Next with blur background
          SlidingUpPanel(
            minHeight: nowplayingBoxHeight,
            maxHeight: 350,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            boxShadow: const [],
            color: const Color.fromRGBO(0, 0, 0, 0.7),
            controller: panelController,
            panelBuilder: (ScrollController scrollController) {
              return ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(
                    sigmaX: 8.0,
                    sigmaY: 8.0,
                  ),
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return const LinearGradient(
                        end: Alignment.topCenter,
                        begin: Alignment.center,
                        colors: [
                          Colors.black,
                          Colors.black,
                          Colors.black,
                          Colors.transparent,
                          Colors.transparent,
                        ],
                      ).createShader(
                        Rect.fromLTRB(
                          0,
                          0,
                          rect.width,
                          rect.height,
                        ),
                      );
                    },
                    blendMode: BlendMode.dstIn,
                    child: NowPlayingStream(
                      head: true,
                      headHeight: nowplayingBoxHeight,
                      // audioHandler: audioHandler,
                      scrollController: scrollController,
                      panelController: panelController,
                    ),
                  ),
                ),
              );
            },
            header: GestureDetector(
              onTap: () {
                if (panelController.isPanelOpen) {
                  panelController.close();
                } else {
                  if (panelController.panelPosition > 0.9) {
                    panelController.close();
                  } else {
                    panelController.open();
                  }
                }
              },
              onVerticalDragUpdate: (DragUpdateDetails details) {
                if (details.delta.dy > 0.0) {
                  panelController.animatePanelToPosition(0.0);
                }
              },
              child: Container(
                height: nowplayingBoxHeight,
                width: width,
                color: Colors.transparent,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Container(
                        width: 30,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Up Next',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
