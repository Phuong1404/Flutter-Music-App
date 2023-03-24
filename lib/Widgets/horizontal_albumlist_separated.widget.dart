import 'package:music_app/Widgets/custom_physics.widget.dart';
// import 'package:blackhole/CustomWidgets/song_tile_trailing_menu.dart';
// import 'package:blackhole/Helpers/image_resolution_modifier.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_app/Widgets/song_tile_trailing_menu.widget.dart';

class HorizontalAlbumsListSeparated extends StatelessWidget {
  // final List songsList;
  // final Function(int) onTap;
  // const HorizontalAlbumsListSeparated({
  //   super.key,
  //   required this.songsList,
  //   required this.onTap,
  // });

  // String formatString(String? text) {
  //   return text == null
  //       ? ''
  //       : text
  //           .replaceAll('&amp;', '&')
  //           .replaceAll('&#039;', "'")
  //           .replaceAll('&quot;', '"')
  //           .trim();
  // }

  // String getSubTitle(Map item) {
  //   final type = item['type'];
  //   if (type == 'charts') {
  //     return '';
  //   } else if (type == 'playlist' || type == 'radio_station') {
  //     return formatString(item['subtitle']?.toString());
  //   } else if (type == 'song') {
  //     return formatString(item['artist']?.toString());
  //   } else {
  //     if (item['subtitle'] != null) {
  //       return formatString(item['subtitle']?.toString());
  //     }
  //     final artists = item['more_info']?['artistMap']?['artists']
  //         .map((artist) => artist['name'])
  //         .toList();
  //     if (artists != null) {
  //       return formatString(artists?.join(', ')?.toString());
  //     }
  //     if (item['artist'] != null) {
  //       return formatString(item['artist']?.toString());
  //     }
  //     return '';
  //   }
  // }

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
      // height: songsList.length < 4 ? songsList.length * 74 : 74 * 4,
      height: 74 * 3,
      
      child: Align(
        alignment: Alignment.centerLeft,
        child: ListView(
          physics: PagingScrollPhysics(itemDimension: listSize),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemExtent: listSize,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(
                    'Nơi tình yêu bắt đầu',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white,fontSize: 16,height: 1.3),
                  ),
                  subtitle: Text(
                    'Bùi Anh Tuấn',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white70),
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
                      // imageUrl: getImageUrl(item['image'].toString()),
                      imageUrl: 'https://avatar-ex-swe.nixcdn.com/song/2018/11/08/2/8/3/9/1541660658234_500.jpg',
                      placeholder: (context, url) => Image(
                        fit: BoxFit.cover,
                        image: const AssetImage(
                          'assets/cover.jpg',
                        ),
                      ),
                    ),
                  ),
                  trailing: SongTileTrailingMenu(
                    data: {},
                  ),
                  // onTap: () => onTap(songsList.indexOf(item)),
                ),
                ListTile(
                  title: Text(
                    'Thương em là điều anh không thể ngờ',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white, fontSize: 16, height: 1.3),
                  ),
                  subtitle: Text(
                    'Noo Phước Thịnh',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white70),
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
                      // imageUrl: getImageUrl(item['image'].toString()),
                      imageUrl:
                          'https://c-cl.cdn.smule.com/rs-s94/arr/18/66/011b2306-b067-44b7-ba7a-d7c3717fe92a.jpg',
                      placeholder: (context, url) => Image(
                        fit: BoxFit.cover,
                        image: const AssetImage(
                          'assets/cover.jpg',
                        ),
                      ),
                    ),
                  ),
                  trailing: SongTileTrailingMenu(
                    data: {},
                  ),
                  // onTap: () => onTap(songsList.indexOf(item)),
                ),
                ListTile(
                  title: Text(
                    'Chỉ còn lại tình yêu',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white,fontSize: 16,height: 1.3),
                  ),
                  subtitle: Text(
                    'Bùi Anh Tuấn',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white70),
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
                      // imageUrl: getImageUrl(item['image'].toString()),
                      imageUrl: 'https://avatar-ex-swe.nixcdn.com/song/2018/11/08/2/8/3/9/1541660658234_500.jpg',
                      placeholder: (context, url) => Image(
                        fit: BoxFit.cover,
                        image: const AssetImage(
                          'assets/cover.jpg',
                        ),
                      ),
                    ),
                  ),
                  trailing: SongTileTrailingMenu(
                    data: {},
                  ),
                  // onTap: () => onTap(songsList.indexOf(item)),
                )
              
              ],
            ),
          ],
        ),
//============================================Code mapping==========================================
        // child: ListView.builder(
        //   // physics: PagingScrollPhysics(itemDimension: listSize),
        //   scrollDirection: Axis.horizontal,
        //   shrinkWrap: true,
        //   itemExtent: listSize,
        //   itemCount: (songsList.length / 4).ceil(),
        //   itemBuilder: (context, index) {
        //     final itemGroup = songsList.skip(index * 4).take(4);
        //     return SizedBox(
        //       height: 72 * 4,
        //       width: listSize,
        //       child: Column(
        //         mainAxisSize: MainAxisSize.min,
        //         children: itemGroup.map((item) {
        //           final subTitle = getSubTitle(item as Map);
        //           return ListTile(
        //             title: Text(
        //               formatString(item['title']?.toString()),
        //               overflow: TextOverflow.ellipsis,
        //             ),
        //             subtitle: Text(
        //               subTitle,
        //               overflow: TextOverflow.ellipsis,
        //             ),
        //             leading: Card(
        //               margin: EdgeInsets.zero,
        //               elevation: 5,
        //               shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(7.0),
        //               ),
        //               clipBehavior: Clip.antiAlias,
        //               child: CachedNetworkImage(
        //                 fit: BoxFit.cover,
        //                 errorWidget: (context, _, __) => const Image(
        //                   fit: BoxFit.cover,
        //                   image: AssetImage('assets/cover.jpg'),
        //                 ),
        //                 // imageUrl: getImageUrl(item['image'].toString()),
        //                 imageUrl: '',
        //                 placeholder: (context, url) => Image(
        //                   fit: BoxFit.cover,
        //                   image: (item['type'] == 'playlist' ||
        //                           item['type'] == 'album')
        //                       ? const AssetImage(
        //                           'assets/album.png',
        //                         )
        //                       : item['type'] == 'artist'
        //                           ? const AssetImage(
        //                               'assets/artist.png',
        //                             )
        //                           : const AssetImage(
        //                               'assets/cover.jpg',
        //                             ),
        //                 ),
        //               ),
        //             ),
        //             // trailing: SongTileTrailingMenu(
        //             //   data: item,
        //             // ),
        //             // onTap: () => onTap(songsList.indexOf(item)),
        //           );
        //         }).toList(),
        //       ),
        //     );
        //   },
        // ),
      ),
    );
  }
}
