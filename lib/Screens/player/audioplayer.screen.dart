import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:music_app/Helpers/mediaitem_converter.dart';
import 'package:music_app/Widgets/animated_text.widget.dart';
import 'package:music_app/Widgets/download_button.widget.dart';
import 'package:music_app/Widgets/like_button.widget.dart';
import 'package:music_app/Widgets/seek_bar.widget.dart';
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
  final AudioPlayerHandler audioHandler = GetIt.I<AudioPlayerHandler>();
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  late Duration _time;

  // void sleepTimer(int time) {
  //   audioHandler.customAction('sleepTimer', {'time': time});
  // }

  // void sleepCounter(int count) {
  //   audioHandler.customAction('sleepCounter', {'count': count});
  // }

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
        child: StreamBuilder<MediaItem?>(
          stream: audioHandler.mediaItem,
          builder: (context, snapshot) {
            final MediaItem? mediaItem = snapshot.data;
            print(mediaItem);
            if (mediaItem == null) return const SizedBox();
            return SafeArea(
              child: Scaffold(
                resizeToAvoidBottomInset: false,
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
                      ],
                    )
                  ],
                ),
                body: LayoutBuilder(
                  builder: (
                    BuildContext context,
                    BoxConstraints constraints,
                  ) {
                    return Column(
                      children: [
                        // Artwork
                        ArtWorkWidget(
                          cardKey: cardKey,
                          mediaItem: mediaItem,
                          width: constraints.maxWidth,
                          audioHandler: audioHandler,
                          offline: false,
                          getLyricsOnline: getLyricsOnline,
                        ),

                        // title and controls
                        NameNControls(
                          mediaItem: mediaItem,
                          offline: false,
                          width: constraints.maxWidth,
                          height: constraints.maxHeight -
                              (constraints.maxWidth * 0.85),
                          panelController: _panelController,
                          audioHandler: audioHandler,
                        ),
                      ],
                    );
                  },
                ),
                // }
              ),
            );
          },
        )
        // );

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
  final AudioPlayerHandler audioHandler;
  final bool shuffle;
  final bool miniplayer;
  final List buttons;
  final Color? dominantColor;

  const ControlButtons(
    this.audioHandler, {
    this.shuffle = false,
    this.miniplayer = false,
    this.buttons = const ['Previous', 'Play/Pause', 'Next'],
    this.dominantColor,
  });

  @override
  Widget build(BuildContext context) {
    final MediaItem mediaItem = audioHandler.mediaItem.value!;
    final bool online = true;
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: buttons.map((e) {
          switch (e) {
            case 'Like':
              return LikeButton(
                // mediaItem: mediaItem,
                size: 22.0,
              );
            case 'Previous':
              return StreamBuilder<QueueState>(
                stream: audioHandler.queueState,
                builder: (context, snapshot) {
                  final queueState = snapshot.data;
                  return IconButton(
                    icon: const Icon(Icons.skip_previous_rounded),
                    iconSize: miniplayer ? 24.0 : 45.0,
                    tooltip: 'Skip Previous',
                    color: Colors.white,
                    onPressed: queueState?.hasPrevious ?? true
                        ? audioHandler.skipToPrevious
                        : null,
                  );
                },
              );
            case 'Play/Pause':
              return SizedBox(
                height: miniplayer ? 40.0 : 65.0,
                width: miniplayer ? 40.0 : 65.0,
                child: StreamBuilder<PlaybackState>(
                  stream: audioHandler.playbackState,
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
                                    onPressed: audioHandler.pause,
                                    icon: const Icon(
                                      Icons.pause_rounded,
                                    ),
                                    color: Colors.white,
                                  )
                                : IconButton(
                                    tooltip: "Play",
                                    onPressed: audioHandler.play,
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
                                        onPressed: audioHandler.pause,
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
                                        onPressed: audioHandler.play,
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
              );
            case 'Next':
              return StreamBuilder<QueueState>(
                stream: audioHandler.queueState,
                builder: (context, snapshot) {
                  final queueState = snapshot.data;
                  return IconButton(
                    icon: const Icon(Icons.skip_next_rounded),
                    iconSize: miniplayer ? 24.0 : 45.0,
                    tooltip: 'Skip Next',
                    color: Colors.white,
                    onPressed: queueState?.hasNext ?? true
                        ? audioHandler.skipToNext
                        : null,
                  );
                },
              );
            case 'Download':
              return DownloadButton(
                size: 20.0,
                icon: 'download',
                data: MediaItemConverter.mediaItemToMap(mediaItem),
              );
            default:
              break;
          }
          return const SizedBox();
        }).toList());
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
  final AudioPlayerHandler audioHandler;
  final ScrollController? scrollController;
  final PanelController? panelController;
  final bool head;
  final double headHeight;

  const NowPlayingStream({
    required this.audioHandler,
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
      stream: audioHandler.queueState,
      builder: (context, snapshot) {
        final queueState = snapshot.data ?? QueueState.empty;
        final queue = queueState.queue;
        final int queueStateIndex = queueState.queueIndex ?? 0;
        final num queuePosition = queue.length - queueStateIndex;
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => _updateScrollController(
            scrollController,
            queueState.queueIndex ?? 0,
            queuePosition.toInt(),
            queue.length,
          ),
        );

        return Theme(
            data: ThemeData(canvasColor: Colors.black),
            child : ReorderableListView.builder(
          header: SizedBox(
            height: head ? headHeight : 0,
          ),
          onReorder: (int oldIndex, int newIndex) {
            // neu bai hat tren
            if (oldIndex < newIndex) {
              newIndex--;
            }
            audioHandler.moveQueueItem(oldIndex, newIndex);
          },
          scrollController: scrollController,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 10),
          shrinkWrap: true,
          itemCount: queue.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: ValueKey(queue[index].id),
              direction: index == queueState.queueIndex
                  ? DismissDirection.none
                  : DismissDirection.horizontal,
              onDismissed: (dir) {
                audioHandler.removeQueueItemAt(index);
              },
              child: ListTileTheme(
                selectedColor: Colors.transparent,
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.only(left: 16.0, right: 10.0),
                  selected: index == queueState.queueIndex,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: (index == queueState.queueIndex)
                        ? [
                            IconButton(
                              icon: const Icon(
                                Icons.bar_chart_rounded,
                              ),
                              color: Color.fromARGB(255, 4, 192, 60),
                              tooltip: 'Playing',
                              onPressed: () {},
                            )
                          ]
                        : [
                            LikeButton(
                                // mediaItem: queue[index],
                                ),
                            DownloadButton(
                              icon: 'download',
                              size: 25.0,
                              data: {},
                            ),
                            ReorderableDragStartListener(
                              key: Key(queue[index].id),
                              index: index,
                              enabled: index != queueState.queueIndex,
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
                        child: (queue[index].extras!['image'] == null)
                            ? const SizedBox.square(
                                dimension: 50,
                                child: Image(
                                  image: AssetImage('assets/cover.jpg'),
                                ),
                              )
                            : SizedBox.square(
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
                                      queue[index].extras!['image'].toString(),
                                ),
                              ),
                      ),
                    ],
                  ),
                  title: Text(
                    queue[index].title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: index == queueState.queueIndex
                            ? FontWeight.w600
                            : FontWeight.normal,
                        color: Colors.white),
                  ),
                  subtitle: Text(
                    queue[index].artist!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white70),
                  ),
                  onTap: () {
                    audioHandler.skipToQueueItem(index);
                  },
                ),
              ),
            );
          },
        )
        );
      },
    );
  }
}

class ArtWorkWidget extends StatefulWidget {
  final GlobalKey<FlipCardState> cardKey;
  final MediaItem mediaItem;
  final bool offline;
  final bool getLyricsOnline;
  final double width;
  final AudioPlayerHandler audioHandler;

  const ArtWorkWidget({
    required this.cardKey,
    required this.mediaItem,
    required this.width,
    this.offline = false,
    required this.getLyricsOnline,
    required this.audioHandler,
  });

  @override
  _ArtWorkWidgetState createState() => _ArtWorkWidgetState();
}

class _ArtWorkWidgetState extends State<ArtWorkWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.width * 0.85,
      width: widget.width * 0.85,
      child: Center(
        child: Card(
          child: StreamBuilder<QueueState>(
            stream: widget.audioHandler.queueState,
            builder: (context, snapshot) {
              final queueState = snapshot.data ?? QueueState.empty;
              return GestureDetector(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Card(
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: CachedNetworkImage(
                        fit: BoxFit.contain,
                        errorWidget: (BuildContext context, _, __) =>
                            const Image(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/cover.jpg'),
                        ),
                        placeholder: (BuildContext context, _) => const Image(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/cover.jpg'),
                        ),
                        imageUrl: widget.mediaItem.extras!['image'].toString(),
                        width: widget.width * 0.85,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class NameNControls extends StatelessWidget {
  final MediaItem mediaItem;
  final bool offline;
  final double width;
  final double height;
  // final List<Color?>? gradientColor;
  final PanelController panelController;
  final AudioPlayerHandler audioHandler;

  const NameNControls({
    required this.width,
    required this.height,
    required this.mediaItem,
    // required this.gradientColor,
    required this.audioHandler,
    required this.panelController,
    this.offline = false,
  });

  Stream<Duration> get _bufferedPositionStream => audioHandler.playbackState
      .map((state) => state.bufferedPosition)
      .distinct();
  Stream<Duration?> get _durationStream =>
      audioHandler.mediaItem.map((item) => item?.duration).distinct();
  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        AudioService.position,
        _bufferedPositionStream,
        _durationStream,
        (position, bufferedPosition, duration) =>
            PositionData(position, bufferedPosition, duration ?? Duration.zero),
      );

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
    final bool useFullScreenGradient = true;
    final List<String> artists = mediaItem.artist.toString().split(', ');
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
                          text: mediaItem.title,
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
                          text: (mediaItem.album ?? '').isEmpty
                              ? '${(mediaItem.artist ?? "").isEmpty ? "Unknown" : mediaItem.artist}'
                              : '${(mediaItem.artist ?? "").isEmpty ? "Unknown" : mediaItem.artist} • ${mediaItem.album}',
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
              SizedBox(
                height: seekBoxHeight,
                width: width * 0.95,
                child: StreamBuilder<PositionData>(
                  stream: _positionDataStream,
                  builder: (context, snapshot) {
                    final positionData = snapshot.data ??
                        PositionData(
                          Duration.zero,
                          Duration.zero,
                          mediaItem.duration ?? Duration.zero,
                        );
                    return SeekBar(
                      // width: width,
                      // height: height,
                      duration: positionData.duration,
                      position: positionData.position,
                      bufferedPosition: positionData.bufferedPosition,
                      offline: offline,
                      onChangeEnd: (newPosition) {
                        audioHandler.seek(newPosition);
                      },
                      audioHandler: audioHandler,
                    );
                  },
                ),
              ),

              /// Final row starts from here
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
                              const SizedBox(height: 4.5),
                              StreamBuilder<bool>(
                                stream: audioHandler.playbackState
                                    .map(
                                      (state) =>
                                          state.shuffleMode ==
                                          AudioServiceShuffleMode.all,
                                    )
                                    .distinct(),
                                builder: (context, snapshot) {
                                  final shuffleModeEnabled =
                                      snapshot.data ?? false;
                                  return IconButton(
                                    icon: shuffleModeEnabled
                                        ? const Icon(
                                            Icons.shuffle_rounded,
                                            color:
                                                Colors.white,
                                          )
                                        : Icon(
                                            Icons.shuffle_rounded,
                                            color:
                                                Colors.white,
                                          ),
                                    tooltip: 'Shuffle',
                                    onPressed: () async {
                                      final enable = !shuffleModeEnabled;
                                      await audioHandler.setShuffleMode(
                                        enable
                                            ? AudioServiceShuffleMode.all
                                            : AudioServiceShuffleMode.none,
                                      );
                                    },
                                  );
                                },
                              ),
                              LikeButton(size: 25.0)
                              // LikeButton(mediaItem: mediaItem, size: 25.0)
                            ],
                          ),
                          ControlButtons(
                            audioHandler,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 2.0),
                              StreamBuilder<AudioServiceRepeatMode>(
                                stream: audioHandler.playbackState
                                    .map((state) => state.repeatMode)
                                    .distinct(),
                                builder: (context, snapshot) {
                                  final repeatMode = snapshot.data ??
                                      AudioServiceRepeatMode.none;
                                  const texts = ['None', 'All', 'One'];
                                  final icons = [
                                    Icon(
                                      Icons.repeat_rounded,
                                      color: Colors.white,
                                    ),
                                    const Icon(
                                      Icons.repeat_rounded,
                                    ),
                                    const Icon(
                                      Icons.repeat_one_rounded,
                                    ),
                                  ];
                                  const cycleModes = [
                                    AudioServiceRepeatMode.none,
                                    AudioServiceRepeatMode.all,
                                    AudioServiceRepeatMode.one,
                                  ];
                                  final index = cycleModes.indexOf(repeatMode);
                                  return IconButton(
                                    icon: icons[index],
                                    onPressed: () async {
                                      // await Hive.box('settings').put(
                                      //   'repeatMode',
                                      //   texts[(index + 1) % texts.length],
                                      // );
                                      // await audioHandler.setRepeatMode(
                                      //   cycleModes[
                                      //       (cycleModes.indexOf(repeatMode) +
                                      //               1) %
                                      //           cycleModes.length],
                                      // );
                                    },
                                  );
                                },
                              ),
                              DownloadButton(
                                size: 25.0,
                                data: MediaItemConverter.mediaItemToMap(
                                  mediaItem,
                                ),
                              )
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
                      audioHandler: audioHandler,
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
                            color: Colors.white
                          ),
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
