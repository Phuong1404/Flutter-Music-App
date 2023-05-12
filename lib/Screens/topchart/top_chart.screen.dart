import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/API/SongAPI.api.dart';
import 'package:music_app/Widgets/custom_physics.widget.dart';
import 'package:music_app/Widgets/empty_screen.widget.dart';
import 'package:music_app/Widgets/song_tile_trailing_menu.widget.dart';
import 'package:url_launcher/url_launcher.dart';

List localSongs = Hive.box('cache').get('LocalSong', defaultValue: []) as List;
List globalSongs = Hive.box('cache').get('GlobalSong', defaultValue: []) as List;
bool localFetched = false;
bool globalFetched = false;
final ValueNotifier<bool> localFetchFinished = ValueNotifier<bool>(false);
final ValueNotifier<bool> globalFetchFinished = ValueNotifier<bool>(false);

class TopChartScreen extends StatefulWidget {
  final PageController pageController;
  const TopChartScreen({super.key, required this.pageController});

  @override
  _TopChartScreenState createState() => _TopChartScreenState();
}

class _TopChartScreenState extends State<TopChartScreen>
    with AutomaticKeepAliveClientMixin<TopChartScreen> {
  final ValueNotifier<bool> localFetchFinished = ValueNotifier<bool>(false);

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext cntxt) {
    super.build(context);
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool rotated = MediaQuery.of(context).size.height < screenWidth;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Color.fromARGB(255, 4, 192, 60),
            tabs: [
              Tab(
                child: Text(
                  "Local",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  // AppLocalizations.of(context)!.global,
                  "Global",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          title: Text(
            "Top Chart",
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
        ),
        body: NotificationListener(
          onNotification: (overscroll) {
            if (overscroll is OverscrollNotification &&
                overscroll.overscroll != 0 &&
                overscroll.dragDetails != null) {
              widget.pageController.animateToPage(
                overscroll.overscroll < 0 ? 0 : 2,
                curve: Curves.ease,
                duration: const Duration(milliseconds: 150),
              );
            }
            return true;
          },
          child: TabBarView(
            physics: const CustomPhysics(),
            children: [
              const TopPage(type: 'Local'),
              const TopPage(type: 'Global'),
            ],
          ),
        ),
      ),
    );
  }
}

class TopPage extends StatefulWidget {
  final String type;
  const TopPage({super.key, required this.type});
  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage>
    with AutomaticKeepAliveClientMixin<TopPage> {
  Future<void> getDataLocal() async {
    final data = await SongApi().getLocal();
    if (data.isNotEmpty) {
      localSongs = data;
      Hive.box('cache').put('LocalSong', localSongs);
    }
  }

  Future<void> getDataGlobal() async {
    final data = await SongApi().getGlobal();
    if (data.isNotEmpty) {
      globalSongs = data;
      Hive.box('cache').put('GlobalSong', globalSongs);
    }
  }

  Future<void> getCachedData(String type) async {
    if (type == 'Global') {
      globalFetched = true;
    } else {
      localFetched = true;
    }
    if (type == 'Global') {
      await getDataGlobal();
    } else {
      await getDataLocal();
    }
    setState(() {});
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    getCachedData(widget.type);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final bool isLocal = widget.type == 'Local';
    if ((isLocal && !localFetched) || (!isLocal && !globalFetched)) {
      getCachedData(widget.type);
    }
    return ValueListenableBuilder(
      valueListenable: isLocal ? localFetchFinished : globalFetchFinished,
      builder: (BuildContext context, bool value, Widget? child) {
        final List showList = isLocal ? localSongs : globalSongs;
        return Column(
          children: [
            if (showList.isEmpty)
              Expanded(
                child: value
                    ? emptyScreen(
                        context,
                        0,
                        ':( ',
                        100,
                        'ERROR',
                        60,
                        'Service Unavailable',
                        20,
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(
                            color: Color.fromARGB(255, 4, 192, 60),
                          ),
                        ],
                      ),
              )
            else
              Expanded(
                  child: RefreshIndicator(
                      color: Color.fromARGB(255, 42, 215, 94),
                      onRefresh: () async {
                        await Future.delayed(
                            const Duration(milliseconds: 1200));
                        await getCachedData(widget.type);
                        setState(() {});
                      },
                      child: ListView.builder(
                        itemCount: showList.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          String name = showList[index]['name'];
                          int number = index + 1;
                          return ListTile(
                            leading: Card(
                              margin: EdgeInsets.zero,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Stack(
                                children: [
                                  const Image(
                                    image: AssetImage('assets/cover.jpg'),
                                  ),
                                  CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: showList[index]['image'],
                                    errorWidget: (context, _, __) =>
                                        const Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage('assets/cover.jpg'),
                                    ),
                                    placeholder: (context, url) => const Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage('assets/cover.jpg'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            title: Text(
                              '$number. $name',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  height: 1.4),
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              showList[index]['artist'],
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: SongTileTrailingMenu(
                              data: {},
                            ),
                            onTap: () {
                            },
                          );
                        },
                      ))),
          ],
        );
      },
    );
  }
}
