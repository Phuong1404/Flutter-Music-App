import 'dart:io';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool rotated = MediaQuery.of(context).size.height < screenWidth;
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        AppBar(
          title: Text(
            'Library',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: (rotated && screenWidth < 1050)
              ? null
              : Builder(
                  builder: (BuildContext context) {
                    return Transform.rotate(
                      angle: 22 / 7 * 2,
                      child: IconButton(
                        color: Colors.white,
                        icon: const Icon(
                          Icons.horizontal_split_rounded,
                        ),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        tooltip: MaterialLocalizations.of(context)
                            .openAppDrawerTooltip,
                      ),
                    );
                  },
                ),
        ),
        LibraryTile(
          title: "Playing Now",
          icon: Icons.queue_music_rounded,
          onTap: () {
            Navigator.pushNamed(context, '/nowplaying');
          },
        ),
        LibraryTile(
          title: 'Last Session',
          icon: Icons.history_rounded,
          onTap: () {
            // Navigator.pushNamed(context, '/recent');
          },
        ),
        LibraryTile(
          title: 'Favorites',
          icon: Icons.favorite_rounded,
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => LikedSongs(
            //       playlistName: 'Favorite Songs',
            //       showName: AppLocalizations.of(context)!.favSongs,
            //     ),
            //   ),
            // );
          },
        ),
        // if (!Platform.isIOS)
          LibraryTile(
            title: 'My Music',
            icon: MdiIcons.folderMusic,
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => (Platform.isWindows || Platform.isLinux)
              //         ? const DownloadedSongsDesktop()
              //         : const DownloadedSongs(
              //             showPlaylists: true,
              //           ),
              //   ),
              // );
            },
          ),
        LibraryTile(
          title: 'Downloads',
          icon: Icons.download_done_rounded,
          onTap: () {
            // Navigator.pushNamed(context, '/downloads');
          },
        ),
        LibraryTile(
          title: 'Playlists',
          icon: Icons.playlist_play_rounded,
          onTap: () {
            // Navigator.pushNamed(context, '/playlists');
          },
        ),
      ],
    );
  }
}

class LibraryTile extends StatelessWidget {
  const LibraryTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      onTap: onTap,
    );
  }
}
