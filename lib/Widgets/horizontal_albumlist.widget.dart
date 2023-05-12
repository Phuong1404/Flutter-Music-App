import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_app/Widgets/like_button.widget.dart';
import 'package:music_app/Widgets/on_hover.widget.dart';

import 'song_tile_trailing_menu.widget.dart';

class HorizontalAlbumsList extends StatelessWidget {
  final List songsList;
  final Function(int) onTap;
  const HorizontalAlbumsList({
    super.key,
    required this.songsList,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double boxSize =
        MediaQuery.of(context).size.height > MediaQuery.of(context).size.width
            ? MediaQuery.of(context).size.width / 2
            : MediaQuery.of(context).size.height / 2.5;
    if (boxSize > 250) boxSize = 250;
    return SizedBox(
      height: boxSize + 15,
      child:ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          GestureDetector(
            onLongPress: () {
              Feedback.forLongPress(context);
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    backgroundColor: Colors.transparent,
                    contentPadding: EdgeInsets.zero,
                    content: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1000.0,
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        errorWidget: (context, _, __) => const Image(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/cover.jpg'),
                        ),
                        imageUrl: 'https://avatar-ex-swe.nixcdn.com/song/2018/11/08/2/8/3/9/1541660658234_640.jpg',
                        placeholder: (context, url) => Image(
                          fit: BoxFit.cover,
                          image: const AssetImage(
                                      'assets/cover.jpg',
                                    ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            onTap: () {
              // onTap(index);
            },
            child: SizedBox(
              width: boxSize - 30,
              child: HoverBox(
                child: Card(
                  elevation: 5,
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1000.0),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    errorWidget: (context, _, __) => const Image(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/cover.jpg'),
                    ),
                    imageUrl: 'https://avatar-ex-swe.nixcdn.com/song/2018/11/08/2/8/3/9/1541660658234_640.jpg',
                    placeholder: (context, url) => Image(
                      fit: BoxFit.cover,
                      image: const AssetImage(
                                  'assets/cover.jpg',
                                ),
                    ),
                  ),
                ),
                builder: (BuildContext context, bool isHover, Widget? child) {
                  return Card(
                    color: isHover ? null : Colors.transparent,
                    elevation: 0,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            SizedBox.square(
                              dimension: isHover ? boxSize - 25 : boxSize - 30,
                              child: child,
                            ),
                              Positioned.fill(
                                child: Container(
                                  margin: const EdgeInsets.all(
                                    4.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(1000.0
                                    ),
                                  ),
                                  child: Center(
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Colors.black87,
                                        borderRadius:
                                            BorderRadius.circular(1000.0),
                                      ),
                                      child: const Icon(
                                        Icons.play_arrow_rounded,
                                        size: 50.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    LikeButton(
                                      mediaItem: null,
                                      data: {},
                                    ),
                                    SongTileTrailingMenu(
                                      data: {},
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Xin em',
                                textAlign: TextAlign.center,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                                Text(
                                  'Bùi Anh Tuấn',
                                  textAlign: TextAlign.center,
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .color,
                                  ),
                                )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        
        ],),
    );
  }
}
