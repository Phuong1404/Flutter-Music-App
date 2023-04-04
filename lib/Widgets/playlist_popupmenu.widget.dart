import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class PlaylistPopupMenu extends StatefulWidget {
  final List data;
  final String title;
  const PlaylistPopupMenu({
    super.key,
    required this.data,
    required this.title,
  });

  @override
  _PlaylistPopupMenuState createState() => _PlaylistPopupMenuState();
}

class _PlaylistPopupMenuState extends State<PlaylistPopupMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: Color.fromARGB(255, 22, 22, 23),
      icon: const Icon(
        Icons.more_vert_rounded,
        color: Colors.white,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 0,
          child: Row(
            children: [
              Icon(
                Icons.queue_music_rounded,
                color: Colors.white,
              ),
              const SizedBox(width: 10.0),
              Text(
                'Add to Queue',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              Icon(
                Icons.favorite_border_rounded,
                color: Colors.white,
              ),
              const SizedBox(width: 10.0),
              Text(
                'Save Playlist',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
      onSelected: (int? value) {},
    );
  }
}
