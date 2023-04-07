import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ArtistScreen extends StatefulWidget {
  final PageController pageController;
  const ArtistScreen({super.key, required this.pageController});

  @override
  _ArtistScreenState createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen>
    with AutomaticKeepAliveClientMixin<ArtistScreen> {

  @override
  Widget build(BuildContext cntxt) {
    // TODO: implement build
    super.build(context);
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool rotated = MediaQuery.of(context).size.height < screenWidth;

    return DefaultTabController(
        length: 3,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(
                "Artists",
                style: TextStyle(
                    fontSize: 18.5,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
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
                              Scaffold.of(cntxt).openDrawer();
                            },
                            tooltip: MaterialLocalizations.of(cntxt)
                                .openAppDrawerTooltip,
                          ),
                        );
                      },
                    ),
              actions: [
                Container(
                  padding: EdgeInsets.only(right: 7),
                  child: IconButton(
                    color: Colors.white,
                    icon: const Icon(
                      Icons.search,
                    ),
                    onPressed: () {
                      Scaffold.of(cntxt).openDrawer();
                    },
                    tooltip:
                        MaterialLocalizations.of(cntxt).openAppDrawerTooltip,
                  ),
                ),
              ],
            ),
            body: SizedBox(
              child: Container(
                  margin: EdgeInsets.only(left: 11, right: 11,top: 10),
                  child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 170,
                      childAspectRatio: 2 / 2,
                      mainAxisSpacing: 9,
                      crossAxisSpacing: 0,
                    ),
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 97.2,
                            child: ClipRRect(
                            borderRadius: BorderRadius.circular(10000.0),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              // imageUrl: showList[index]['image_url_small']
                              //     .toString(),
                              imageUrl:
                                  'https://avatar-ex-swe.nixcdn.com/song/2020/06/15/b/0/f/a/1592231470406_640.jpg',
                              errorWidget: (context, _, __) => const Image(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/cover.jpg'),
                              ),
                              placeholder: (context, url) => const Image(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/cover.jpg'),
                              ),
                            ),
                          ),
                          ),
                          Text('Bùi Anh Tuấn',style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.5,
                            height: 2
                          ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 97.2,
                            child: ClipRRect(
                            borderRadius: BorderRadius.circular(10000.0),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              // imageUrl: showList[index]['image_url_small']
                              //     .toString(),
                              imageUrl:
                                  'https://avatar-ex-swe.nixcdn.com/song/2020/06/15/b/0/f/a/1592231470406_640.jpg',
                              errorWidget: (context, _, __) => const Image(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/cover.jpg'),
                              ),
                              placeholder: (context, url) => const Image(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/cover.jpg'),
                              ),
                            ),
                          ),
                          ),
                          Text('Bùi Anh Tuấn',style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.5,
                            height: 2
                          ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 97.2,
                            child: ClipRRect(
                            borderRadius: BorderRadius.circular(10000.0),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              // imageUrl: showList[index]['image_url_small']
                              //     .toString(),
                              imageUrl:
                                  'https://avatar-ex-swe.nixcdn.com/song/2020/06/15/b/0/f/a/1592231470406_640.jpg',
                              errorWidget: (context, _, __) => const Image(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/cover.jpg'),
                              ),
                              placeholder: (context, url) => const Image(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/cover.jpg'),
                              ),
                            ),
                          ),
                          ),
                          Text('Bùi Anh Tuấn',style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.5,
                            height: 2
                          ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 90.4,
                            child: ClipRRect(
                            borderRadius: BorderRadius.circular(10000.0),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              // imageUrl: showList[index]['image_url_small']
                              //     .toString(),
                              imageUrl:
                                  'https://avatar-ex-swe.nixcdn.com/song/2020/06/15/b/0/f/a/1592231470406_640.jpg',
                              errorWidget: (context, _, __) => const Image(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/cover.jpg'),
                              ),
                              placeholder: (context, url) => const Image(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/cover.jpg'),
                              ),
                            ),
                          ),
                          ),
                          Text('Bùi Anh Tuấn',style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.5,
                            height: 2
                          ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 90.4,
                            child: ClipRRect(
                            borderRadius: BorderRadius.circular(10000.0),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              // imageUrl: showList[index]['image_url_small']
                              //     .toString(),
                              imageUrl:
                                  'https://avatar-ex-swe.nixcdn.com/song/2020/06/15/b/0/f/a/1592231470406_640.jpg',
                              errorWidget: (context, _, __) => const Image(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/cover.jpg'),
                              ),
                              placeholder: (context, url) => const Image(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/cover.jpg'),
                              ),
                            ),
                          ),
                          ),
                          Text('Bùi Anh Tuấn',style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.5,
                            height: 2
                          ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 90.4,
                            child: ClipRRect(
                            borderRadius: BorderRadius.circular(10000.0),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              // imageUrl: showList[index]['image_url_small']
                              //     .toString(),
                              imageUrl:
                                  'https://avatar-ex-swe.nixcdn.com/song/2020/06/15/b/0/f/a/1592231470406_640.jpg',
                              errorWidget: (context, _, __) => const Image(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/cover.jpg'),
                              ),
                              placeholder: (context, url) => const Image(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/cover.jpg'),
                              ),
                            ),
                          ),
                          ),
                          Text('Bùi Anh Tuấn',style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.5,
                            height: 2
                          ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 90.4,
                            child: ClipRRect(
                            borderRadius: BorderRadius.circular(10000.0),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              // imageUrl: showList[index]['image_url_small']
                              //     .toString(),
                              imageUrl:
                                  'https://avatar-ex-swe.nixcdn.com/song/2020/06/15/b/0/f/a/1592231470406_640.jpg',
                              errorWidget: (context, _, __) => const Image(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/cover.jpg'),
                              ),
                              placeholder: (context, url) => const Image(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/cover.jpg'),
                              ),
                            ),
                          ),
                          ),
                          Text('Bùi Anh Tuấn',style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.5,
                            height: 2
                          ),
                          )
                        ],
                      ),
                      
                      ],
                  )),
            )));
  }

  @override
  bool get wantKeepAlive => true;
}
