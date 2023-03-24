import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:music_app/Screens/home/body_home.screen.dart';
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
  // List sectionsToShow = Hive.box('settings').get(
  //   'sectionsToShow',
  //   defaultValue: ['Home', 'Top Charts', 'YouTube', 'Library'],
  // ) as List;
  Future<bool> handleWillPop(BuildContext context) async {
    // final now = DateTime.now();
    // final backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
    //     backButtonPressTime == null ||
    //         now.difference(backButtonPressTime!) > const Duration(seconds: 3);

    // if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
    //   backButtonPressTime = now;
    //   ShowSnackBar().showSnackBar(
    //     context,
    //     AppLocalizations.of(context)!.exitConfirm,
    //     duration: const Duration(seconds: 2),
    //     noAction: true,
    //   );
    //   return false;
    // }
    return true;
  }

  @override
  void initState() {
    super.initState();
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
                  background: ShaderMask(
                    shaderCallback: (rect) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.8),
                          Colors.black.withOpacity(0.1),
                        ],
                      ).createShader(
                        Rect.fromLTRB(0, 0, rect.width, rect.height),
                      );
                    },
                    blendMode: BlendMode.dstIn,
                    child: Image(
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      image: AssetImage(
                        Theme.of(context).brightness == Brightness.dark
                            ? 'assets/header-dark.jpg'
                            : 'assets/header.jpg',
                      ),
                    ),
                  ),
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
                        'My Music',
                        style: TextStyle(color: Colors.white),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20.0),
                      leading: Icon(
                        MdiIcons.folderMusic,
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
                        'Downloads',
                        style: TextStyle(color: Colors.white),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20.0),
                      leading: Icon(
                        Icons.download_done_rounded,
                        color: Colors.white,
                      ),
                      onTap: () {
                        // Navigator.pop(context);
                        // Navigator.pushNamed(context, '/downloads');
                      },
                    ),
                    ListTile(
                      title: Text(
                        'Playlists',
                        style: TextStyle(color: Colors.white),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20.0),
                      leading: Icon(
                        Icons.playlist_play_rounded,
                        color: Colors.white,
                      ),
                      onTap: () {
                        // Navigator.pop(context);
                        // Navigator.pushNamed(context, '/playlists');
                      },
                    ),
                    ListTile(
                      title: Text(
                        'Settings',
                        style: TextStyle(color: Colors.white),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20.0),
                      leading: Icon(
                        Icons
                            .settings_rounded, // miscellaneous_services_rounded,
                        color: Colors.white,
                      ),
                      onTap: () {
                        // Navigator.pop(context);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         SettingPage(callback: callback),
                        //   ),
                        // );
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
                        // physics: const CustomPhysics(),
                        onPageChanged: (indx) {
                          _selectedIndex.value = indx;
                        },
                        // controller: _pageController,
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
                                                // await showTextInputDialog(
                                                //   context: context,
                                                //   title: 'Name',
                                                //   initialText: name,
                                                //   keyboardType:
                                                //       TextInputType.name,
                                                //   onSubmitted: (value) {
                                                //     Hive.box('settings').put(
                                                //       'name',
                                                //       value.trim(),
                                                //     );
                                                //     name = value.trim();
                                                //     Navigator.pop(context);
                                                //     updateUserDetails(
                                                //       'name',
                                                //       value.trim(),
                                                //     );
                                                //   },
                                                // );
                                                // setState(() {});
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
                                                        // ValueListenableBuilder(
                                                        //   valueListenable:
                                                        //       Hive.box(
                                                        //     'settings',
                                                        //   ).listenable(),
                                                        //   builder: (
                                                        //     BuildContext
                                                        //         context,
                                                        //     Box box,
                                                        //     Widget? child,
                                                        //   ) {
                                                        //     return Text(
                                                        //       (box.get('name') ==
                                                        //                   null ||
                                                        //               box.get('name') ==
                                                        //                   '')
                                                        //           ? 'Guest'
                                                        //           : box
                                                        //               .get(
                                                        //                 'name',
                                                        //               )
                                                        //               .split(
                                                        //                 ' ',
                                                        //               )[0]
                                                        //               .toString(),
                                                        //       style:
                                                        //           const TextStyle(
                                                        //         letterSpacing:
                                                        //             2,
                                                        //         fontSize: 20,
                                                        //         fontWeight:
                                                        //             FontWeight
                                                        //                 .w500,
                                                        //       ),
                                                        //     );
                                                        //   },
                                                        // ),
                                                        Text(
                                                          'Phương',
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
                                                  color: Color.fromARGB(255, 31, 33, 32),
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
                                              // onTap: () => Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //     builder: (context) =>
                                              //         const SearchPage(
                                              //       query: '',
                                              //       fromHome: true,
                                              //       autofocus: true,
                                              //     ),
                                              //   ),
                                              // ),
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
                          // if (sectionsToShow.contains('Top Charts'))
                          //   TopCharts(
                          //     pageController: _pageController,
                          //   ),
                          // const YouTube(),
                          // const LibraryPage(),
                          // if (sectionsToShow.contains('Settings'))
                          //   SettingPage(callback: callback),
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
                        // _onItemTapped(index);
                      },
                      items: [
                        SalomonBottomBarItem(
                          icon: const Icon(Icons.home_rounded),
                          title: Text('Home'),
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
                          icon: const Icon(MdiIcons.youtube),
                          title: Text('YouTube'),
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
