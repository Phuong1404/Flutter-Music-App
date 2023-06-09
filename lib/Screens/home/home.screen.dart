import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:music_app/API/UserAPI.api.dart';
import 'package:music_app/Screens/artists/artist.screen.dart';
import 'package:music_app/Screens/home/body_home.screen.dart';
import 'package:music_app/Screens/library/library.screen.dart';
import 'package:music_app/Screens/search/search.screen.dart';
import 'package:music_app/Screens/topchart/top_chart.screen.dart';
import 'package:music_app/Services/store_token.service.dart';
import 'package:music_app/Widgets/custom_physics.widget.dart';
import 'package:music_app/Widgets/gradient_container.widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:music_app/Widgets/miniplayer.widget.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
  static const routeName = '/home';
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();

  List sectionsToShow = ['Home', 'Top Charts', 'Artists', 'Library'] as List;
  String _name = '';
  Future<void> GetName() async {
    try {
      String? userId = await StoreToken.getToken();
      if (userId != null) {
        final data = await UserApi().GetProfile(userId);
        var names = data['name'].split(' ');
        String name = names[names.length - 1];
        setState(() {
          _name = name;
        });
      }
      else{
        setState(() {
        _name = "Guest";
      });
      }
    } catch (e) {
      setState(() {
        _name = "Guest";
      });
    }
  }

  Future<bool> handleWillPop(BuildContext context) async {
    return true;
  }

  void _onItemTapped(int index) {
    _selectedIndex.value = index;
    _pageController.jumpToPage(
      index,
    );
  }

  @override
  void initState() {
    super.initState();
    GetName();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool rotated = MediaQuery.of(context).size.height < screenWidth;
    return GradientContainer(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      drawer: Drawer(
        child: GradientContainer(
          child: CustomScrollView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                elevation: 0,
                stretch: true,
                expandedHeight: MediaQuery.of(context).size.height * 0.2,
                flexibleSpace: FlexibleSpaceBar(
                  title: RichText(
                    text: TextSpan(
                      text: 'Spotify',
                      style: const TextStyle(
                        fontSize: 33.0,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 4, 192, 60),
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '',
                          style: const TextStyle(
                            fontSize: 7.0,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.end,
                  ),
                  titlePadding: const EdgeInsets.only(bottom: 40.0),
                  centerTitle: true,
                  background: null,
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    ListTile(
                      title: Text(
                        'Home',
                        style: TextStyle(
                          color: Color.fromARGB(255, 4, 192, 60),
                        ),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20.0),
                      leading: Icon(
                        Icons.home_rounded,
                        color: Color.fromARGB(255, 4, 192, 60),
                      ),
                      selected: true,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(
                        'Top Charts',
                        style: TextStyle(color: Colors.white),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20.0),
                      leading: Icon(
                        Icons.trending_up_rounded,
                        color: Colors.white,
                      ),
                      onTap: () {
                        // Navigator.pop(context);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const DownloadedSongs(
                        //       showPlaylists: true,
                        //     ),
                        //   ),
                        // );
                      },
                    ),
                    ListTile(
                      title: Text(
                        'Library',
                        style: TextStyle(color: Colors.white),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20.0),
                      leading: Icon(
                        Icons.my_library_music_rounded,
                        color: Colors.white,
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                        _pageController.jumpToPage(1);
                      },
                    ),
                    ListTile(
                      title: Text(
                        'My Account',
                        style: TextStyle(color: Colors.white),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20.0),
                      leading: Icon(
                        Icons.account_circle,
                        color: Colors.white,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/profile');
                      },
                    ),
                    ListTile(
                      title: Text(
                        'Log Out',
                        style: TextStyle(color: Colors.white),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20.0),
                      leading: Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      onTap: () {
                        // Navigator.pop(context);
                        // Navigator.pushNamed(context, '/playlists');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: WillPopScope(
        // onWillPop: () => handleWillPop(context),
        onWillPop: () => handleWillPop(context),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: PageView(
                        physics: const CustomPhysics(),
                        onPageChanged: (indx) {
                          _selectedIndex.value = indx;
                        },
                        controller: _pageController,
                        children: [
                          Stack(
                            children: [
                              // checkVersion(),
                              NestedScrollView(
                                physics: const BouncingScrollPhysics(),
                                controller: _scrollController,
                                headerSliverBuilder: (
                                  BuildContext context,
                                  bool innerBoxScrolled,
                                ) {
                                  return <Widget>[
                                    SliverAppBar(
                                      expandedHeight: 135,
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                      // pinned: true,
                                      toolbarHeight: 65,
                                      // floating: true,
                                      automaticallyImplyLeading: false,
                                      flexibleSpace: LayoutBuilder(
                                        builder: (
                                          BuildContext context,
                                          BoxConstraints constraints,
                                        ) {
                                          return FlexibleSpaceBar(
                                            // collapseMode: CollapseMode.parallax,
                                            background: GestureDetector(
                                              onTap: () async {
                                              },
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  const SizedBox(
                                                    height: 60,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 15.0,
                                                        ),
                                                        child: Text(
                                                          'Hi There,',
                                                          style: TextStyle(
                                                            letterSpacing: 2,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    4,
                                                                    192,
                                                                    60),
                                                            fontSize: 33,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 15.0,
                                                    ),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Text(
                                                          _name,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                            letterSpacing: 2,
                                                            fontSize: 23,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    SliverAppBar(
                                      automaticallyImplyLeading: false,
                                      pinned: true,
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                      stretch: true,
                                      toolbarHeight: 65,
                                      title: Align(
                                        alignment: Alignment.centerRight,
                                        child: AnimatedBuilder(
                                          animation: _scrollController,
                                          builder: (context, child) {
                                            return GestureDetector(
                                              child: AnimatedContainer(
                                                width: (!_scrollController
                                                            .hasClients ||
                                                        _scrollController
                                                                // ignore: invalid_use_of_protected_member
                                                                .positions
                                                                .length >
                                                            1)
                                                    ? MediaQuery.of(context)
                                                        .size
                                                        .width
                                                    // :MediaQuery.of(context)
                                                    //             .size
                                                    //             .width,
                                                    : max(
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            _scrollController
                                                                .offset
                                                                .roundToDouble(),
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            70,
                                                      ),
                                                height: 52.0,
                                                duration: const Duration(
                                                  milliseconds: 150,
                                                ),
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                // margin: EdgeInsets.zero,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    10.0,
                                                  ),
                                                  color: Color.fromARGB(
                                                      255, 31, 33, 32),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: Colors.black26,
                                                      blurRadius: 5.0,
                                                      offset: Offset(1.5, 1.5),
                                                      // shadow direction: bottom right
                                                    )
                                                  ],
                                                ),
                                                child: Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    Icon(
                                                      CupertinoIcons.search,
                                                      color: Color.fromARGB(
                                                          255, 4, 192, 60),
                                                    ),
                                                    const SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    Text(
                                                      'Songs, albums or artists',
                                                      style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              onTap: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SearchPage(
                                                    query: '',
                                                    fromHome: true,
                                                    autofocus: true,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ];
                                },
                                // body: SaavnHomePage(),
                                body: HomeBodyScreen(),
                              ),
                              if (!rotated || screenWidth > 1050)
                                Builder(
                                  builder: (context) => Padding(
                                    padding: const EdgeInsets.only(
                                      top: 9.5,
                                      left: 4.0,
                                    ),
                                    child: Transform.rotate(
                                      angle: 22 / 7 * 2,
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.horizontal_split_rounded,
                                          color: Colors.white,
                                        ),
                                        // color: Colors.white,
                                        onPressed: () {
                                          Scaffold.of(context).openDrawer();
                                        },
                                        tooltip:
                                            MaterialLocalizations.of(context)
                                                .openAppDrawerTooltip,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          TopChartScreen(
                            pageController: _pageController,
                          ),
                          ArtistScreen(
                            pageController: _pageController,
                          ),
                          LibraryScreen()
                        ],
                      ),
                    ),
                    MiniPlayer()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: rotated
          ? null
          : SafeArea(
              child: ValueListenableBuilder(
                valueListenable: _selectedIndex,
                builder: (BuildContext context, int indexValue, Widget? child) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    height: 60,
                    child: SalomonBottomBar(
                      currentIndex: indexValue,
                      onTap: (index) {
                        _onItemTapped(index);
                      },
                      items: [
                        SalomonBottomBarItem(
                          icon: const Icon(Icons.home_rounded),
                          title: Text('Home'),
                          unselectedColor: Colors.white,
                          selectedColor: Color.fromARGB(255, 4, 192, 60),
                        ),
                        // if (sectionsToShow.contains('Top Charts'))
                        SalomonBottomBarItem(
                          icon: const Icon(Icons.trending_up_rounded),
                          title: Text(
                            'Top Charts',
                          ),
                          unselectedColor: Colors.white,
                          selectedColor: Color.fromARGB(255, 4, 192, 60),
                        ),
                        SalomonBottomBarItem(
                          icon: const Icon(MdiIcons.album),
                          title: Text('Artists'),
                          unselectedColor: Colors.white,
                          selectedColor: Color.fromARGB(255, 4, 192, 60),
                        ),
                        SalomonBottomBarItem(
                          icon: const Icon(Icons.my_library_music_rounded),
                          title: Text('Library'),
                          unselectedColor: Colors.white,
                          selectedColor: Color.fromARGB(255, 4, 192, 60),
                        ),
                        // if (sectionsToShow.contains('Settings'))
                        // SalomonBottomBarItem(
                        //   icon: const Icon(Icons.settings_rounded),
                        //   title: Text('Settings'),
                        //   selectedColor:
                        //       Color.fromARGB(255, 4, 192, 60),
                        // ),
                      ],
                    ),
                  );
                },
              ),
            ),
      // ),
    ));
  }
}
