import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/Screens/player/audioplayer.screen.dart';

import 'gradient_container.widget.dart';

class MiniPlayer extends StatefulWidget {
  static const MiniPlayer _instance = MiniPlayer._internal();

  factory MiniPlayer() {
    return _instance;
  }

  const MiniPlayer._internal();

  @override
  _MiniPlayerState createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  AudioPlayerHandler audioHandler = GetIt.I<AudioPlayerHandler>();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool rotated = MediaQuery.of(context).size.height < screenWidth;
    final bool useDense = false;
    final List preferredMiniButtons =['Like', 'Play/Pause', 'Next'] as List;
    return StreamBuilder<PlaybackState>(
      stream: audioHandler.playbackState,
      builder: (context, snapshot) {
        final playbackState = snapshot.data;
        final processingState = playbackState?.processingState;
        if (processingState == AudioProcessingState.idle) {
          return const SizedBox();
        }
        return StreamBuilder<MediaItem?>(
          stream: audioHandler.mediaItem,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.active) {
              return const SizedBox();
            }
            final mediaItem = snapshot.data;
            if (mediaItem == null) return const SizedBox();
            return Dismissible(
              key: const Key('miniplayer'),
              direction: DismissDirection.down,
              onDismissed: (_) {
                Feedback.forLongPress(context);
                audioHandler.stop();
              },
              child: Dismissible(
                key: Key(mediaItem.id),
                confirmDismiss: (DismissDirection direction) {
                  // if (direction == DismissDirection.startToEnd) {
                  //   audioHandler.skipToPrevious();
                  // } else {
                  //   audioHandler.skipToNext();
                  // }
                  return Future.value(false);
                },
                child: Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 2.0,
                        vertical: 1.0,
                      ),
                      elevation: 0,
                      child: SizedBox(
                        height: 72.0,
                        child: GradientContainer(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                dense: useDense,
                                onTap: () {
                                  Navigator.pushNamed(context, '/player');
                                },
                                title: Text(
                                  mediaItem.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(mediaItem.artist ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white70)),
                                leading: Hero(
                                  tag: 'currentArtwork',
                                  child: Card(
                                    elevation: 8,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: SizedBox.square(
                                      dimension: 50.0,
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        errorWidget: (
                                          BuildContext context,
                                          _,
                                          __,
                                        ) =>
                                            const Image(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                            'assets/cover.jpg',
                                          ),
                                        ),
                                        placeholder: (
                                          BuildContext context,
                                          _,
                                        ) =>
                                            const Image(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                            'assets/cover.jpg',
                                          ),
                                        ),
                                        imageUrl: mediaItem.extras!['image'],
                                      ),
                                    ),
                                  ),
                                ),
                                trailing: ControlButtons(
                                  audioHandler,
                                  miniplayer: true,
                                  buttons: ['Like', 'Play/Pause', 'Next']
                                      
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
               ),
            );
          },
        );
      },
    );
  }
}
