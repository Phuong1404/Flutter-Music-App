import 'package:flutter/material.dart';
import 'package:music_app/Widgets/horizontal_albumlist_separated.widget.dart';
import 'package:music_app/Widgets/on_hover.widget.dart';

class HomeBodyScreen extends StatefulWidget {
  @override
  _HomeBodyScreenState createState() => _HomeBodyScreenState();
}

class _HomeBodyScreenState extends State<HomeBodyScreen> {
  @override
  Widget build(BuildContext context) {
    // super.build(context);
    // if (!fetched) {
    //   getHomePageData();
    //   fetched = true;
    // }
    double boxSize =
        MediaQuery.of(context).size.height > MediaQuery.of(context).size.width
            ? MediaQuery.of(context).size.width / 2
            : MediaQuery.of(context).size.height / 2.5;
    if (boxSize > 250) boxSize = 250;
    // if (playlistNames.length >= 3) {
    //   recentIndex = 0;
    //   playlistIndex = 1;
    // } else {
    //   recentIndex = 1;
    //   playlistIndex = 0;
    // }
    // return (data.isEmpty && recentList.isEmpty)
    // ? const Center(
    //     child: CircularProgressIndicator(),
    //   )
//===============================Không có data=======================================
    // return const Center(
    //       child: CircularProgressIndicator(
    //         color: Color.fromARGB(255, 4, 192, 60),
    //       ),
    //     );
//=====================================Có data=======================================
    return ListView(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [
        Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 0, 5),
                  child: Text(
                    'Last Session',
                    style: TextStyle(
                      color: Color.fromARGB(255, 4, 192, 60),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            HorizontalAlbumsListSeparated(),
          ],
        ),
        Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 0, 5),
                  child: Text(
                    'Your Playlists',
                    style: TextStyle(
                      color: Color.fromARGB(255, 4, 192, 60),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: boxSize + 15,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                children: [
                  GestureDetector(
                    child: SizedBox(
                      width: boxSize - 30,
                      child: HoverBox(
                        child: Card(
                          elevation: 5,
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Image.network(
                              'https://avatar-ex-swe.nixcdn.com/song/2018/11/08/2/8/3/9/1541660658234_500.jpg'),
                          // child: const Image(
                          //   // image: AssetImage(
                          //   //   'assets/cover.jpg',
                          //   // ),
                          // ),
                        ),
                        builder: (
                          BuildContext context,
                          bool isHover,
                          Widget? child,
                        ) {
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
                                SizedBox.square(
                                  dimension:
                                      isHover ? boxSize - 25 : boxSize - 30,
                                  child: child,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Xin em',
                                        textAlign: TextAlign.center,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            height: 1.3,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        'Bùi Anh Tuấn',
                                        textAlign: TextAlign.center,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.white70),
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
                    onTap: () async {
                      Navigator.popAndPushNamed(context, '/album');
                    },
                  ),
                  GestureDetector(
                    child: SizedBox(
                      width: boxSize - 30,
                      child: HoverBox(
                        child: Card(
                          elevation: 5,
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Image.network(
                              'https://i1.sndcdn.com/artworks-000272552840-vt8wlh-t500x500.jpg'),
                          // child: const Image(
                          //   // image: AssetImage(
                          //   //   'assets/cover.jpg',
                          //   // ),
                          // ),
                        ),
                        builder: (
                          BuildContext context,
                          bool isHover,
                          Widget? child,
                        ) {
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
                                SizedBox.square(
                                  dimension:
                                      isHover ? boxSize - 25 : boxSize - 30,
                                  child: child,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Chia tay',
                                        textAlign: TextAlign.center,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            height: 1.3,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        'Bùi Anh Tuấn',
                                        textAlign: TextAlign.center,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.white70),
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
                    onTap: () async {
                      Navigator.popAndPushNamed(context, '/album');
                    },
                  ),
                  GestureDetector(
                    child: SizedBox(
                      width: boxSize - 30,
                      child: HoverBox(
                        child: Card(
                          elevation: 5,
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Image.network(
                              'https://is5-ssl.mzstatic.com/image/thumb/Music128/v4/50/27/60/50276058-c602-a8d6-6276-14ac3882d64a/886447385470.jpg/1200x1200bb.jpg'),
                          // child: const Image(
                          //   // image: AssetImage(
                          //   //   'assets/cover.jpg',
                          //   // ),
                          // ),
                        ),
                        builder: (
                          BuildContext context,
                          bool isHover,
                          Widget? child,
                        ) {
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
                                SizedBox.square(
                                  dimension:
                                      isHover ? boxSize - 25 : boxSize - 30,
                                  child: child,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Những kẻ mộng mơ',
                                        textAlign: TextAlign.center,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            height: 1.3,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        'Noo Phước Thịnh',
                                        textAlign: TextAlign.center,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.white70),
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
                    onTap: () async {
                      Navigator.popAndPushNamed(context, '/album');
                    },
                  ),
                ],
              ),
            )
          ],
        ),
        Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 0, 5),
                  child: Text(
                    'Trending Now',
                    style: TextStyle(
                      color: Color.fromARGB(255, 4, 192, 60),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: boxSize + 15,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                children: [
                  GestureDetector(
                    child: SizedBox(
                      width: boxSize - 30,
                      child: HoverBox(
                        child: Card(
                          elevation: 5,
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Image.network(
                              'https://avatar-ex-swe.nixcdn.com/song/2018/11/08/2/8/3/9/1541660658234_500.jpg'),
                          // child: const Image(
                          //   // image: AssetImage(
                          //   //   'assets/cover.jpg',
                          //   // ),
                          // ),
                        ),
                        builder: (
                          BuildContext context,
                          bool isHover,
                          Widget? child,
                        ) {
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
                                SizedBox.square(
                                  dimension:
                                      isHover ? boxSize - 25 : boxSize - 30,
                                  child: child,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Xin em',
                                        textAlign: TextAlign.center,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            height: 1.3,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        'Bùi Anh Tuấn',
                                        textAlign: TextAlign.center,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.white70),
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
                    onTap: () async {
                      Navigator.popAndPushNamed(context, '/album');
                    },
                  ),
                  GestureDetector(
                    child: SizedBox(
                      width: boxSize - 30,
                      child: HoverBox(
                        child: Card(
                          elevation: 5,
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Image.network(
                              'https://i1.sndcdn.com/artworks-000272552840-vt8wlh-t500x500.jpg'),
                          // child: const Image(
                          //   // image: AssetImage(
                          //   //   'assets/cover.jpg',
                          //   // ),
                          // ),
                        ),
                        builder: (
                          BuildContext context,
                          bool isHover,
                          Widget? child,
                        ) {
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
                                SizedBox.square(
                                  dimension:
                                      isHover ? boxSize - 25 : boxSize - 30,
                                  child: child,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Chia tay',
                                        textAlign: TextAlign.center,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            height: 1.3,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        'Bùi Anh Tuấn',
                                        textAlign: TextAlign.center,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.white70),
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
                    onTap: () async {
                      Navigator.popAndPushNamed(context, '/album');
                    },
                  ),
                  GestureDetector(
                    child: SizedBox(
                      width: boxSize - 30,
                      child: HoverBox(
                        child: Card(
                          elevation: 5,
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Image.network(
                              'https://is5-ssl.mzstatic.com/image/thumb/Music128/v4/50/27/60/50276058-c602-a8d6-6276-14ac3882d64a/886447385470.jpg/1200x1200bb.jpg'),
                          // child: const Image(
                          //   // image: AssetImage(
                          //   //   'assets/cover.jpg',
                          //   // ),
                          // ),
                        ),
                        builder: (
                          BuildContext context,
                          bool isHover,
                          Widget? child,
                        ) {
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
                                SizedBox.square(
                                  dimension:
                                      isHover ? boxSize - 25 : boxSize - 30,
                                  child: child,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Những kẻ mộng mơ',
                                        textAlign: TextAlign.center,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            height: 1.3,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        'Noo Phước Thịnh',
                                        textAlign: TextAlign.center,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.white70),
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
                    onTap: () async {
                      Navigator.popAndPushNamed(context, '/album');
                    },
                  ),
                ],
              ),
            )
          ],
        ),
        Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 0, 5),
                  child: Text(
                    'New Releases',
                    style: TextStyle(
                      color: Color.fromARGB(255, 4, 192, 60),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: boxSize + 15,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                children: [
                  GestureDetector(
                    child: SizedBox(
                      width: boxSize - 30,
                      child: HoverBox(
                        child: Card(
                          elevation: 5,
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Image.network(
                              'https://avatar-ex-swe.nixcdn.com/song/2018/11/08/2/8/3/9/1541660658234_500.jpg'),
                          // child: const Image(
                          //   // image: AssetImage(
                          //   //   'assets/cover.jpg',
                          //   // ),
                          // ),
                        ),
                        builder: (
                          BuildContext context,
                          bool isHover,
                          Widget? child,
                        ) {
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
                                SizedBox.square(
                                  dimension:
                                      isHover ? boxSize - 25 : boxSize - 30,
                                  child: child,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Xin em',
                                        textAlign: TextAlign.center,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            height: 1.3,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        'Bùi Anh Tuấn',
                                        textAlign: TextAlign.center,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.white70),
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
                    onTap: () async {
                      Navigator.popAndPushNamed(context, '/album');
                    },
                  ),
                  GestureDetector(
                    child: SizedBox(
                      width: boxSize - 30,
                      child: HoverBox(
                        child: Card(
                          elevation: 5,
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Image.network(
                              'https://i1.sndcdn.com/artworks-000272552840-vt8wlh-t500x500.jpg'),
                          // child: const Image(
                          //   // image: AssetImage(
                          //   //   'assets/cover.jpg',
                          //   // ),
                          // ),
                        ),
                        builder: (
                          BuildContext context,
                          bool isHover,
                          Widget? child,
                        ) {
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
                                SizedBox.square(
                                  dimension:
                                      isHover ? boxSize - 25 : boxSize - 30,
                                  child: child,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Chia tay',
                                        textAlign: TextAlign.center,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            height: 1.3,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        'Bùi Anh Tuấn',
                                        textAlign: TextAlign.center,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.white70),
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
                    onTap: () async {
                      Navigator.popAndPushNamed(context, '/album');
                    },
                  ),
                  GestureDetector(
                    child: SizedBox(
                      width: boxSize - 30,
                      child: HoverBox(
                        child: Card(
                          elevation: 5,
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Image.network(
                              'https://is5-ssl.mzstatic.com/image/thumb/Music128/v4/50/27/60/50276058-c602-a8d6-6276-14ac3882d64a/886447385470.jpg/1200x1200bb.jpg'),
                          // child: const Image(
                          //   // image: AssetImage(
                          //   //   'assets/cover.jpg',
                          //   // ),
                          // ),
                        ),
                        builder: (
                          BuildContext context,
                          bool isHover,
                          Widget? child,
                        ) {
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
                                SizedBox.square(
                                  dimension:
                                      isHover ? boxSize - 25 : boxSize - 30,
                                  child: child,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Những kẻ mộng mơ',
                                        textAlign: TextAlign.center,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            height: 1.3,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        'Noo Phước Thịnh',
                                        textAlign: TextAlign.center,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.white70),
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
                    onTap: () async {
                      Navigator.popAndPushNamed(context, '/album');
                    },
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
