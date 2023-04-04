import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logging/logging.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:music_app/Widgets/gradient_container.widget.dart';
import 'package:music_app/Widgets/miniplayer.widget.dart';
import 'package:music_app/Widgets/snackbar.widget.dart';
import 'package:music_app/Widgets/textinput_dialog.widget.dart';

import 'liked.screen.dart';

class PlaylistScreen extends StatefulWidget {
  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
  static const routeName = '/playlist';
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  // final Box settingsBox = Hive.box('');
  // final List playlistNames =
  //     Hive.box('settings').get('playlistNames')?.toList() as List? ??
  //         ['Favorite Songs'];
  // Map playlistDetails =
  //     Hive.box('settings').get('playlistDetails', defaultValue: {}) as Map;
  @override
  Widget build(BuildContext context) {
    // if (!playlistNames.contains('Favorite Songs')) {
    //   playlistNames.insert(0, 'Favorite Songs');
    //   settingsBox.put('playlistNames', playlistNames);
    // }

    return GradientContainer(
      child: Column(
        children: [
          Expanded(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: Text(
                  'Playlists',
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 5),
                    ListTile(
                      title: Text(
                        'Create Playlist',
                        style: TextStyle(color: Colors.white),
                      ),
                      leading: SizedBox.square(
                        dimension: 50,
                        child: Center(
                          child: Icon(
                            Icons.add_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onTap: () async {
                        await showTextInputDialog(
                          context: context,
                          title: 'Create New Playlist',
                          initialText: '',
                          keyboardType: TextInputType.name,
                          onSubmitted: (String value) async {
                            // final RegExp avoid = RegExp(r'[\.\\\*\:\"\?#/;\|]');
                            // value.replaceAll(avoid, '').replaceAll('  ', ' ');
                            // if (value.trim() == '') {
                            //   value = 'Playlist ${playlistNames.length}';
                            // }
                            // while (playlistNames.contains(value) ||
                            //     await Hive.boxExists(value)) {
                            //   // ignore: use_string_buffers
                            //   value = '$value (1)';
                            // }
                            // playlistNames.add(value);
                            // settingsBox.put('playlistNames', playlistNames);
                            // Navigator.pop(context);
                          },
                        );
                      },
                    ),
                    ListTile(
                      title: Text(
                        'Merge Playlists',
                        style: TextStyle(color: Colors.white),
                      ),
                      leading: SizedBox.square(
                        dimension: 50,
                        child: Center(
                          child: Icon(
                            Icons.merge_type_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onTap: () async {
                        final List<int> checked = [];
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                              builder: (
                                BuildContext context,
                                StateSetter setStt,
                              ) {
                                return AlertDialog(
                                  backgroundColor:
                                      Color.fromARGB(255, 43, 43, 43),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      10.0,
                                    ),
                                  ),
                                  content: SizedBox(
                                    width: 500,
                                    child: ListView(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      padding: const EdgeInsets.fromLTRB(
                                        0,
                                        30,
                                        0,
                                        10,
                                      ),
                                      children: [
                                        CheckboxListTile(
                                            activeColor:
                                                Color.fromARGB(255, 4, 192, 60),
                                            checkColor: Colors.white,
                                            side:
                                                BorderSide(color: Colors.white),
                                            value: checked.contains(0),
                                            onChanged: (value) {
                                              if (value ?? false) {
                                                checked.add(0);
                                              } else {
                                                checked.remove(0);
                                              }
                                              setStt(() {});
                                            },
                                            title: Text(
                                              'Xin em',
                                              style: TextStyle(
                                                  color: Colors.white),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            subtitle: Text(
                                              '5 Songs',
                                              style: TextStyle(
                                                  color: Colors.white70),
                                            ),
                                            secondary: Card(
                                              elevation: 5,
                                              color: Colors.transparent,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  7.0,
                                                ),
                                              ),
                                              clipBehavior: Clip.antiAlias,
                                              child: SizedBox(
                                                  height: 50,
                                                  width: 50,
                                                  child: const Image(
                                                    image: AssetImage(
                                                      'assets/cover.jpg',
                                                    ),
                                                  )),
                                            )),
                                        CheckboxListTile(
                                            activeColor:
                                                Color.fromARGB(255, 4, 192, 60),
                                            checkColor: Colors.white,
                                            side:
                                                BorderSide(color: Colors.white),
                                            value: checked.contains(1),
                                            onChanged: (value) {
                                              if (value ?? false) {
                                                checked.add(1);
                                              } else {
                                                checked.remove(1);
                                              }
                                              setStt(() {});
                                            },
                                            title: Text(
                                              'Xin em',
                                              style: TextStyle(
                                                  color: Colors.white),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            subtitle: Text(
                                              '5 Songs',
                                              style: TextStyle(
                                                  color: Colors.white70),
                                            ),
                                            secondary: Card(
                                              elevation: 5,
                                              color: Colors.transparent,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  7.0,
                                                ),
                                              ),
                                              clipBehavior: Clip.antiAlias,
                                              child: SizedBox(
                                                  height: 50,
                                                  width: 50,
                                                  child: const Image(
                                                    image: AssetImage(
                                                      'assets/cover.jpg',
                                                    ),
                                                  )),
                                            )),
                                        CheckboxListTile(
                                            activeColor:
                                                Color.fromARGB(255, 4, 192, 60),
                                            checkColor: Colors.white,
                                            side:
                                                BorderSide(color: Colors.white),
                                            value: checked.contains(2),
                                            onChanged: (value) {
                                              if (value ?? false) {
                                                checked.add(2);
                                              } else {
                                                checked.remove(2);
                                              }
                                              setStt(() {});
                                            },
                                            title: Text(
                                              'Xin em',
                                              style: TextStyle(
                                                  color: Colors.white),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            subtitle: Text(
                                              '5 Songs',
                                              style: TextStyle(
                                                  color: Colors.white70),
                                            ),
                                            secondary: Card(
                                              elevation: 5,
                                              color: Colors.transparent,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  7.0,
                                                ),
                                              ),
                                              clipBehavior: Clip.antiAlias,
                                              child: SizedBox(
                                                  height: 50,
                                                  width: 50,
                                                  child: const Image(
                                                    image: AssetImage(
                                                      'assets/cover.jpg',
                                                    ),
                                                  )),
                                            )),
                                        CheckboxListTile(
                                            activeColor:
                                                Color.fromARGB(255, 4, 192, 60),
                                            checkColor: Colors.white,
                                            side:
                                                BorderSide(color: Colors.white),
                                            value: checked.contains(3),
                                            onChanged: (value) {
                                              if (value ?? false) {
                                                checked.add(3);
                                              } else {
                                                checked.remove(3);
                                              }
                                              setStt(() {});
                                            },
                                            title: Text(
                                              'Xin em',
                                              style: TextStyle(
                                                  color: Colors.white),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            subtitle: Text(
                                              '5 Songs',
                                              style: TextStyle(
                                                  color: Colors.white70),
                                            ),
                                            secondary: Card(
                                              elevation: 5,
                                              color: Colors.transparent,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  7.0,
                                                ),
                                              ),
                                              clipBehavior: Clip.antiAlias,
                                              child: SizedBox(
                                                  height: 50,
                                                  width: 50,
                                                  child: const Image(
                                                    image: AssetImage(
                                                      'assets/cover.jpg',
                                                    ),
                                                  )),
                                            )),
                                        CheckboxListTile(
                                            activeColor:
                                                Color.fromARGB(255, 4, 192, 60),
                                            checkColor: Colors.white,
                                            side:
                                                BorderSide(color: Colors.white),
                                            value: checked.contains(4),
                                            onChanged: (value) {
                                              if (value ?? false) {
                                                checked.add(4);
                                              } else {
                                                checked.remove(4);
                                              }
                                              setStt(() {});
                                            },
                                            title: Text(
                                              'Xin em',
                                              style: TextStyle(
                                                  color: Colors.white),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            subtitle: Text(
                                              '5 Songs',
                                              style: TextStyle(
                                                  color: Colors.white70),
                                            ),
                                            secondary: Card(
                                              elevation: 5,
                                              color: Colors.transparent,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  7.0,
                                                ),
                                              ),
                                              clipBehavior: Clip.antiAlias,
                                              child: SizedBox(
                                                  height: 50,
                                                  width: 50,
                                                  child: const Image(
                                                    image: AssetImage(
                                                      'assets/cover.jpg',
                                                    ),
                                                  )),
                                            )),
                                      ],
                                    ),
                                    // ListView.builder(
                                    //   shrinkWrap: true,
                                    //   physics: const BouncingScrollPhysics(),
                                    //   padding: const EdgeInsets.fromLTRB(
                                    //     0,
                                    //     30,
                                    //     0,
                                    //     10,
                                    //   ),
                                    //   itemCount: playlistNames.length,
                                    //   itemBuilder: (context, index) {
                                    //     final String name =
                                    //         playlistNames[index].toString();
                                    //     final String showName =
                                    //         playlistDetails.containsKey(name)
                                    //             ? playlistDetails[name]['name']
                                    //                     ?.toString() ??
                                    //                 name
                                    //             : name;
                                    //     return CheckboxListTile(
                                    //       activeColor: Theme.of(context)
                                    //           .colorScheme
                                    //           .secondary,
                                    //       checkColor: Theme.of(context)
                                    //                   .colorScheme
                                    //                   .secondary ==
                                    //               Colors.white
                                    //           ? Colors.black
                                    //           : null,
                                    //       value: checked.contains(index),
                                    //       onChanged: (value) {
                                    //         if (value ?? false) {
                                    //           checked.add(index);
                                    //         } else {
                                    //           checked.remove(index);
                                    //         }
                                    //         setStt(() {});
                                    //       },
                                    //       title: Text(
                                    //         showName,
                                    //         overflow: TextOverflow.ellipsis,
                                    //       ),
                                    //       subtitle:
                                    //           playlistDetails[name] == null ||
                                    //                   playlistDetails[name]
                                    //                           ['count'] ==
                                    //                       null ||
                                    //                   playlistDetails[name]
                                    //                           ['count'] ==
                                    //                       0
                                    //               ? null
                                    //               : Text(
                                    //                   '${playlistDetails[name]['count']} ${AppLocalizations.of(context)!.songs}',
                                    //                 ),
                                    //       secondary: (playlistDetails[name] ==
                                    //                   null ||
                                    //               playlistDetails[name]
                                    //                       ['imagesList'] ==
                                    //                   null ||
                                    //               (playlistDetails[name]
                                    //                           ['imagesList']
                                    //                       as List)
                                    //                   .isEmpty)
                                    //           ? Card(
                                    //               elevation: 5,
                                    //               color: Colors.transparent,
                                    //               shape: RoundedRectangleBorder(
                                    //                 borderRadius:
                                    //                     BorderRadius.circular(
                                    //                   7.0,
                                    //                 ),
                                    //               ),
                                    //               clipBehavior: Clip.antiAlias,
                                    //               child: SizedBox(
                                    //                 height: 50,
                                    //                 width: 50,
                                    //                 child: name ==
                                    //                         'Favorite Songs'
                                    //                     ? const Image(
                                    //                         image: AssetImage(
                                    //                           'assets/cover.jpg',
                                    //                         ),
                                    //                       )
                                    //                     : const Image(
                                    //                         image: AssetImage(
                                    //                           'assets/album.png',
                                    //                         ),
                                    //                       ),
                                    //               ),
                                    //             )
                                    //           : Collage(
                                    //               imageList:
                                    //                   playlistDetails[name]
                                    //                           ['imagesList']
                                    //                       as List,
                                    //               showGrid: true,
                                    //               placeholderImage:
                                    //                   'assets/cover.jpg',
                                    //             ),
                                    //     );
                                    //   },
                                    // ),
                                  ),
                                  actions: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.white,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                          foregroundColor: null,
                                          backgroundColor:
                                              Color.fromARGB(255, 4, 192, 60)),
                                      onPressed: () async {
                                        // try {
                                        //   final List<String> playlistsToMerge =
                                        //       checked
                                        //           .map(
                                        //             (int e) => playlistNames[e]
                                        //                 .toString(),
                                        //           )
                                        //           .toList();
                                        //   if (playlistsToMerge
                                        //       .contains('Favorite Songs')) {
                                        //     playlistsToMerge
                                        //         .remove('Favorite Songs');
                                        //     playlistsToMerge.insert(
                                        //       0,
                                        //       'Favorite Songs',
                                        //     );
                                        //   }
                                        //   if (playlistsToMerge.length > 1) {
                                        //     final finalMap = {};
                                        //     for (final String playlistName
                                        //         in playlistsToMerge
                                        //             .sublist(1)) {
                                        //       try {
                                        //         final Box playlistBox =
                                        //             await Hive.openBox(
                                        //           playlistName,
                                        //         );
                                        //         final Map songsMap =
                                        //             playlistBox.toMap();
                                        //         finalMap.addAll(songsMap);
                                        //         await playlistDetails
                                        //             .remove(playlistName);
                                        //         playlistNames
                                        //             .remove(playlistName);
                                        //         await playlistBox
                                        //             .deleteFromDisk();
                                        //       } catch (e) {
                                        //         Logger.root.severe(
                                        //           'Error merging $playlistName: $e',
                                        //         );
                                        //         ShowSnackBar().showSnackBar(
                                        //           context,
                                        //           'Error merging $playlistName: $e',
                                        //         );
                                        //       }
                                        //     }
                                        //     final Box finalPlaylistBox =
                                        //         await Hive.openBox(
                                        //       playlistsToMerge.first,
                                        //     );
                                        //     finalPlaylistBox.putAll(finalMap);

                                        //     await settingsBox.put(
                                        //       'playlistDetails',
                                        //       playlistDetails,
                                        //     );

                                        //     await settingsBox.put(
                                        //       'playlistNames',
                                        //       playlistNames,
                                        //     );
                                        //   }
                                        // } catch (e) {
                                        //   Logger.root.severe(
                                        //     'Error merging playlists: $e',
                                        //   );
                                        //   ShowSnackBar().showSnackBar(
                                        //     context,
                                        //     'Error: $e',
                                        //   );
                                        // }
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'OK',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                    // ValueListenableBuilder(
                    //   valueListenable: settingsBox.listenable(),
                    //   builder: (
                    //     BuildContext context,
                    //     Box box,
                    //     Widget? child,
                    //   ) {
                    //     // final List playlistNamesValue = box.get(
                    //     //       'playlistNames',
                    //     //       defaultValue: ['Favorite Songs'],
                    //     //     )?.toList() as List? ??
                    //     //     ['Favorite Songs'];
                    //     return
                    ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        ListTile(
                          leading: Card(
                            elevation: 5,
                            color: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: SizedBox(
                                height: 50,
                                width: 50,
                                child: const Image(
                                  image: AssetImage(
                                    'assets/cover.jpg',
                                  ),
                                )),
                          ),
                          title: Text(
                            'Xin em',
                            style: TextStyle(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            '5 Songs',
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: PopupMenuButton(
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
                            onSelected: (int? value) async {
                              if (value == 0) {
                                ShowSnackBar().showSnackBar(
                                  context,
                                  'Deleted Xin em',
                                );
                              }
                              if (value == 3) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    final controller = TextEditingController(
                                      text: 'Xin em',
                                    );
                                    return AlertDialog(
                                      backgroundColor: Color.fromARGB(255, 43, 43, 43),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Rename',
                                                style: TextStyle(
                                                  color: Color.fromARGB(255, 4, 192, 60),
                                                ),
                                              ),
                                            ],
                                          ),
                                          TextField(
                                            autofocus: true,
                                            textAlignVertical:
                                                TextAlignVertical.bottom,
                                            controller: controller,
                                            style: TextStyle(color: Colors.white),
                                            cursorColor:Color.fromARGB(255, 4, 192, 60),
                                            decoration: InputDecoration(
                                              hintText: 'Playlist Name',
                                                hintStyle: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white70,
                                                ),
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Color.fromARGB(255, 4, 192, 60)),
                                              ),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Color.fromARGB(255, 4, 192, 60)),
                                              ),
                                              border: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Color.fromARGB(255, 4, 192, 60)),
                                              ),
                                            ),
                                            onSubmitted: (value) async {
                                              Navigator.pop(context);
                                              // playlistDetails[name] == null
                                              //     ? playlistDetails.addAll({
                                              //         name: {
                                              //           'name': value.trim()
                                              //         }
                                              //       })
                                              //     : playlistDetails[name]
                                              //         .addAll({
                                              //         'name': value.trim()
                                              //       });

                                              // await settingsBox.put(
                                              //   'playlistDetails',
                                              //   playlistDetails,
                                              // );
                                            },
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.white,
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Cancel',
                                          ),
                                        ),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.black,
                                            backgroundColor: Color.fromARGB(255, 4, 192, 60),
                                          ),
                                          onPressed: () async {
                                            Navigator.pop(context);
                                            // playlistDetails[name] == null
                                            //     ? playlistDetails.addAll({
                                            //         name: {
                                            //           'name': controller
                                            //               .text
                                            //               .trim()
                                            //         }
                                            //       })
                                            //     : playlistDetails[name]
                                            //         .addAll({
                                            //         'name': controller.text
                                            //             .trim()
                                            //       });

                                            // await settingsBox.put(
                                            //   'playlistDetails',
                                            //   playlistDetails,
                                            // );
                                          },
                                          child: Text(
                                            'OK',
                                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            itemBuilder: (context) => [
                              // if (name != 'Favorite Songs')
                              PopupMenuItem(
                                value: 3,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.edit_rounded,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 10.0),
                                    Text(
                                      'Rename',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              // if (name != 'Favorite Songs')
                              PopupMenuItem(
                                value: 0,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.delete_rounded,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 10.0),
                                    Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              // PopupMenuItem(
                              //   value: 1,
                              //   child: Row(
                              //     children: [
                              //       const Icon(MdiIcons.export),
                              //       const SizedBox(width: 10.0),
                              //       Text(
                              //         AppLocalizations.of(context)!.export,
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              PopupMenuItem(
                                value: 2,
                                child: Row(
                                  children: [
                                    const Icon(MdiIcons.share,
                                        color: Colors.white),
                                    const SizedBox(width: 10.0),
                                    Text('Share',
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          onTap: () async {
                            // await Hive.openBox(name);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LikedSongs(
                                  playlistName: '',
                                  showName: '',
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    )
                    //   },
                    // )
                  ],
                ),
              ),
            ),
          ),
          MiniPlayer(),
        ],
      ),
    );
  }
}
