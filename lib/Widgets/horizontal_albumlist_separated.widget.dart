import 'package:music_app/Widgets/custom_physics.widget.dart';
// import 'package:blackhole/CustomWidgets/song_tile_trailing_menu.dart';
// import 'package:blackhole/Helpers/image_resolution_modifier.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_app/Widgets/song_tile_trailing_menu.widget.dart';

class HorizontalAlbumsListSeparated extends StatelessWidget {
  final List songsList;
  final Function(int) onTap;
  const HorizontalAlbumsListSeparated({
    super.key,
    required this.songsList,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool rotated =
        MediaQuery.of(context).size.height < MediaQuery.of(context).size.width;
    // final double portion = (songsList.length <= 4) ? 1.0 : 0.875;
    final double portion = 1;
    final double listSize = rotated
        ? MediaQuery.of(context).size.width * portion / 2
        : MediaQuery.of(context).size.width * portion;
    return SizedBox(
      height: songsList.length < 4 ? songsList.length * 74 : 74 * 4,
      // height: 74 * 3,

      child: Align(
        alignment: Alignment.centerLeft,
        child: ListView.builder(
          physics: PagingScrollPhysics(itemDimension: listSize),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemExtent: listSize,
          itemCount: (songsList.length / 4).ceil(),
          itemBuilder: (context, index) {
            final itemGroup = songsList.skip(index * 4).take(4);
            return SizedBox(
              height: 72 * 4,
              width: listSize,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: itemGroup.map((item) {
                  return ListTile(
                    title: Text(
                      songsList[index]['name'],
                      style: TextStyle(
                        color: Colors.white
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      songsList[index]['artist'],
                      style: TextStyle(color: Colors.white70),
                      overflow: TextOverflow.ellipsis,
                    ),
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
                        imageUrl: songsList[index]['image'],
                        placeholder: (context, url) => Image(
                          fit: BoxFit.cover,
                          image: const AssetImage(
                            'assets/cover.jpg',
                          ),
                        ),
                      ),
                    ),
                    trailing: SongTileTrailingMenu(
                      data: item,
                    ),
                    onTap: () => onTap(songsList.indexOf(item)),
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
