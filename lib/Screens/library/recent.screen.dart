import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:music_app/Widgets/empty_screen.widget.dart';
import 'package:music_app/Widgets/gradient_container.widget.dart';
import 'package:music_app/Widgets/like_button.widget.dart';
import 'package:music_app/Widgets/miniplayer.widget.dart';

class RecentlyPlayed extends StatefulWidget {
  @override
  _RecentlyPlayedState createState() => _RecentlyPlayedState();
  static const routeName = '/recent';
}

class _RecentlyPlayedState extends State<RecentlyPlayed> {
  List _songs = [];
  bool added = false;

  // Future<void> getSongs() async {
  //   _songs = Hive.box('cache').get('recentSongs', defaultValue: []) as List;
  //   added = true;
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    // if (!added) {
    //   getSongs();
    // }

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
                    onPressed: () {
                      // Hive.box('cache').put('recentSongs', []);
                      // setState(() {
                      //   _songs = [];
                      // });
                    },
                    tooltip: 'Clear All',
                    icon: const Icon(Icons.clear_all_rounded),
                  ),
                ],
              ),
              body:ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      shrinkWrap: true,
                      itemExtent: 70.0,
                      children: <Widget>[
                        Dismissible(
                                key: Key("0"),
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
                                onDismissed: (direction) {
                                  // _songs.removeAt(index);
                                  // setState(() {});
                                  // Hive.box('cache').put('recentSongs', _songs);
                                },
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
                                      errorWidget: (context, _, __) =>
                                          const Image(
                                        fit: BoxFit.cover,
                                        image: AssetImage('assets/cover.jpg'),
                                      ),
                                      imageUrl:  'https://avatar-ex-swe.nixcdn.com/song/2018/11/08/2/8/3/9/1541660658234_640.jpg',
                                      placeholder: (context, url) =>
                                          const Image(
                                        fit: BoxFit.cover,
                                        image: AssetImage('assets/cover.jpg'),
                                      ),
                                    ),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // DownloadButton(
                                      //   data: _songs[index] as Map,
                                      //   icon: 'download',
                                      // ),
                                      LikeButton(
                                        // mediaItem: null,
                                        // data: _songs[index] as Map,
                                      ),
                                    ],
                                  ),
                                  title: Text(
                                    'Xin em',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    'Bùi Anh Tuấn',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  onTap: () {
                                    // PlayerInvoke.init(
                                    //   songsList: _songs,
                                    //   index: index,
                                    //   isOffline: false,
                                    // );
                                    // Navigator.pushNamed(context, '/player');
                                  },
                                ),
                              ),
                              Dismissible(
                                key: Key("1"),
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
                                onDismissed: (direction) {
                                  // _songs.removeAt(index);
                                  // setState(() {});
                                  // Hive.box('cache').put('recentSongs', _songs);
                                },
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
                                      errorWidget: (context, _, __) =>
                                          const Image(
                                        fit: BoxFit.cover,
                                        image: AssetImage('assets/cover.jpg'),
                                      ),
                                      imageUrl:  'https://avatar-ex-swe.nixcdn.com/song/2018/11/08/2/8/3/9/1541660658234_640.jpg',
                                      placeholder: (context, url) =>
                                          const Image(
                                        fit: BoxFit.cover,
                                        image: AssetImage('assets/cover.jpg'),
                                      ),
                                    ),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // DownloadButton(
                                      //   data: _songs[index] as Map,
                                      //   icon: 'download',
                                      // ),
                                      LikeButton(
                                        // mediaItem: null,
                                        // data: _songs[index] as Map,
                                      ),
                                    ],
                                  ),
                                  title: Text(
                                    'Xin em',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    'Bùi Anh Tuấn',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  onTap: () {
                                    // PlayerInvoke.init(
                                    //   songsList: _songs,
                                    //   index: index,
                                    //   isOffline: false,
                                    // );
                                    // Navigator.pushNamed(context, '/player');
                                  },
                                ),
                              ),
                      
                      Dismissible(
                                key: Key("2"),
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
                                onDismissed: (direction) {
                                  // _songs.removeAt(index);
                                  // setState(() {});
                                  // Hive.box('cache').put('recentSongs', _songs);
                                },
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
                                      errorWidget: (context, _, __) =>
                                          const Image(
                                        fit: BoxFit.cover,
                                        image: AssetImage('assets/cover.jpg'),
                                      ),
                                      imageUrl:  'https://avatar-ex-swe.nixcdn.com/song/2018/11/08/2/8/3/9/1541660658234_640.jpg',
                                      placeholder: (context, url) =>
                                          const Image(
                                        fit: BoxFit.cover,
                                        image: AssetImage('assets/cover.jpg'),
                                      ),
                                    ),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // DownloadButton(
                                      //   data: _songs[index] as Map,
                                      //   icon: 'download',
                                      // ),
                                      LikeButton(
                                        // mediaItem: null,
                                        // data: _songs[index] as Map,
                                      ),
                                    ],
                                  ),
                                  title: Text(
                                    'Xin em',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    'Bùi Anh Tuấn',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  onTap: () {
                                    // PlayerInvoke.init(
                                    //   songsList: _songs,
                                    //   index: index,
                                    //   isOffline: false,
                                    // );
                                    // Navigator.pushNamed(context, '/player');
                                  },
                                ),
                              ),
                      
                      Dismissible(
                                key: Key("3"),
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
                                onDismissed: (direction) {
                                  // _songs.removeAt(index);
                                  // setState(() {});
                                  // Hive.box('cache').put('recentSongs', _songs);
                                },
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
                                      errorWidget: (context, _, __) =>
                                          const Image(
                                        fit: BoxFit.cover,
                                        image: AssetImage('assets/cover.jpg'),
                                      ),
                                      imageUrl:  'https://avatar-ex-swe.nixcdn.com/song/2018/11/08/2/8/3/9/1541660658234_640.jpg',
                                      placeholder: (context, url) =>
                                          const Image(
                                        fit: BoxFit.cover,
                                        image: AssetImage('assets/cover.jpg'),
                                      ),
                                    ),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // DownloadButton(
                                      //   data: _songs[index] as Map,
                                      //   icon: 'download',
                                      // ),
                                      LikeButton(
                                        // mediaItem: null,
                                        // data: _songs[index] as Map,
                                      ),
                                    ],
                                  ),
                                  title: Text(
                                    'Xin em',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    'Bùi Anh Tuấn',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  onTap: () {
                                    // PlayerInvoke.init(
                                    //   songsList: _songs,
                                    //   index: index,
                                    //   isOffline: false,
                                    // );
                                    // Navigator.pushNamed(context, '/player');
                                  },
                                ),
                              )
                      ],
                    ),
            // body: _songs.isEmpty
            //     ? emptyScreen(
            //         context,
            //         3,
            //         'Nothing to ',
            //         15,
            //         'Show Here',
            //         50.0,
            //         'Go and Play Something',
            //         23.0,
            //       )
            //     : ListView.builder(
            //         physics: const BouncingScrollPhysics(),
            //         padding: const EdgeInsets.only(top: 10, bottom: 10),
            //         shrinkWrap: true,
            //         itemCount: _songs.length,
            //         itemExtent: 70.0,
            //         itemBuilder: (context, index) {
            //           return _songs.isEmpty
            //               ? const SizedBox()
            //               : Dismissible(
            //                   key: Key(_songs[index]['id'].toString()),
            //                   direction: DismissDirection.endToStart,
            //                   background: ColoredBox(
            //                     color: Colors.redAccent,
            //                     child: Padding(
            //                       padding: const EdgeInsets.symmetric(
            //                         horizontal: 15.0,
            //                       ),
            //                       child: Row(
            //                         mainAxisAlignment: MainAxisAlignment.end,
            //                         children: const [
            //                           Icon(Icons.delete_outline_rounded),
            //                         ],
            //                       ),
            //                     ),
            //                   ),
            //                   onDismissed: (direction) {
            //                     // _songs.removeAt(index);
            //                     // setState(() {});
            //                     // Hive.box('cache').put('recentSongs', _songs);
            //                   },
            //                   child: ListTile(
            //                     leading: Card(
            //                       margin: EdgeInsets.zero,
            //                       elevation: 5,
            //                       shape: RoundedRectangleBorder(
            //                         borderRadius: BorderRadius.circular(7.0),
            //                       ),
            //                       clipBehavior: Clip.antiAlias,
            //                       child: CachedNetworkImage(
            //                         fit: BoxFit.cover,
            //                         errorWidget: (context, _, __) =>
            //                             const Image(
            //                           fit: BoxFit.cover,
            //                           image: AssetImage('assets/cover.jpg'),
            //                         ),
            //                         imageUrl: _songs[index]['image']
            //                             .toString()
            //                             .replaceAll('http:', 'https:'),
            //                         placeholder: (context, url) =>
            //                             const Image(
            //                           fit: BoxFit.cover,
            //                           image: AssetImage('assets/cover.jpg'),
            //                         ),
            //                       ),
            //                     ),
            //                     trailing: Row(
            //                       mainAxisSize: MainAxisSize.min,
            //                       children: [
            //                         // DownloadButton(
            //                         //   data: _songs[index] as Map,
            //                         //   icon: 'download',
            //                         // ),
            //                         LikeButton(
            //                           // mediaItem: null,
            //                           // data: _songs[index] as Map,
            //                         ),
            //                       ],
            //                     ),
            //                     title: Text(
            //                       '${_songs[index]["title"]}',
            //                       overflow: TextOverflow.ellipsis,
            //                     ),
            //                     subtitle: Text(
            //                       '${_songs[index]["artist"]}',
            //                       overflow: TextOverflow.ellipsis,
            //                     ),
            //                     onTap: () {
            //                       // PlayerInvoke.init(
            //                       //   songsList: _songs,
            //                       //   index: index,
            //                       //   isOffline: false,
            //                       // );
            //                       // Navigator.pushNamed(context, '/player');
            //                     },
            //                   ),
            //                 );
            //         },
            //       ),
              // body: emptyScreen(
              //   context,
              //   3,
              //   'Nothing to ',
              //   15,
              //   'Show Here',
              //   50.0,
              //   'Go and Play Something',
              //   23.0,
              // ),
            ),
          ),
          MiniPlayer(),
        ],
      ),
    );
  }
}
