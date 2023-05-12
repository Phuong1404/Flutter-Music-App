import 'package:flutter/material.dart';
import 'package:music_app/Services/player_service.dart';

class PlaylistHead extends StatelessWidget {
  final List songsList;
  final bool offline;
  final bool fromDownloads;
  const PlaylistHead({
    super.key,
    required this.songsList,
    required this.fromDownloads,
    required this.offline,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 20.0, right: 10.0),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            songsList.length > 1
                ? songsList.length.toString() + " Songs"
                : songsList.length.toString() + " Song",
            style: const TextStyle(
                fontWeight: FontWeight.w600, color: Colors.white),
          ),
          const Spacer(),
          TextButton.icon(
            onPressed: () {
              PlayerInvoke.init(
                songsList: songsList,
                index: 0,
                isOffline: offline,
                fromDownloads: fromDownloads,
                recommend: false,
                shuffle: true,
              );
            },
            icon: const Icon(
              Icons.shuffle_rounded,
              color: Colors.white,
            ),
            label: Text(
              'Shuffle',
              style: const TextStyle(
                  fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),
          IconButton(
            onPressed: () {
              PlayerInvoke.init(
                songsList: songsList,
                index: 0,
                isOffline: offline,
                fromDownloads: fromDownloads,
                recommend: false,
              );
            },
            tooltip: 'Shuffle',
            icon: const Icon(
              Icons.play_arrow_rounded,
              color: Colors.white,
            ),
            iconSize: 30.0,
          ),
        ],
      ),
    );
  }
}
