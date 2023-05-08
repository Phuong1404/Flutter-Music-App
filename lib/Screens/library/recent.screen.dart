import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:music_app/API/SongAPI.api.dart';
import 'package:music_app/Services/store_token.service.dart';
import 'package:music_app/Widgets/empty_screen.widget.dart';
import 'package:music_app/Widgets/gradient_container.widget.dart';
import 'package:music_app/Widgets/like_button.widget.dart';
import 'package:music_app/Widgets/miniplayer.widget.dart';
import 'package:music_app/Widgets/download_button.widget.dart';

class RecentlyPlayed extends StatefulWidget {
  @override
  _RecentlyPlayedState createState() => _RecentlyPlayedState();
  static const routeName = '/recent';
}

class _RecentlyPlayedState extends State<RecentlyPlayed> {
  List _songs = [];
  bool added = false;

  Future<void> getSongs() async {
    String? userId = await StoreToken.getToken();
    if (userId != null) {
      final data = await SongApi().getHistorySong(userId);
      _songs = data;
    } else {
      _songs = [];
    }
    added = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!added) {
      getSongs();
    }

    return GradientContainer(
      child: Column(
        children: [
          Expanded(
            child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  title: Text('Last Session'),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: [
                    IconButton(
                      onPressed: () {},
                      tooltip: 'Clear All',
                      icon: const Icon(Icons.clear_all_rounded),
                    ),
                  ],
                ),
                body: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  itemCount: _songs.length,
                  shrinkWrap: true,
                  itemExtent: 70.0,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      key: Key(index.toString()),
                      direction: DismissDirection.endToStart,
                      background: ColoredBox(
                        color: Colors.redAccent,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Icon(Icons.delete_outline_rounded),
                            ],
                          ),
                        ),
                      ),
                      onDismissed: (direction) {},
                      child: ListTile(
                        leading: Card(
                          margin: EdgeInsets.zero,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            errorWidget: (context, _, __) => const Image(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/cover.jpg'),
                            ),
                            imageUrl:_songs[index]['image'],
                            placeholder: (context, url) => const Image(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/cover.jpg'),
                            ),
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            DownloadButton(
                              data: {},
                              icon: 'download',
                            ),
                            LikeButton(
                                // mediaItem: null,
                                // data: _songs[index] as Map,
                                ),
                          ],
                        ),
                        title: Text(
                          _songs[index]['name'],
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          _songs[index]['artist'],
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white70),
                        ),
                        onTap: () {
                          
                        },
                      ),
                    );
                  },
                )),
          ),
          MiniPlayer(),
        ],
      ),
    );
  }
}
