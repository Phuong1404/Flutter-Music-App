import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/Screens/player/audioplayer.screen.dart';
import 'package:music_app/Screens/profile/profile.screen.dart';
import 'package:music_app/Screens/start/start.screen.dart';
import 'package:music_app/route.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:path_provider/path_provider.dart';

import 'Services/audio_service.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print('Got a message whilst in the foreground!=======================');
  //   print('Message data: ${message} ==============================');

  //   if (message.notification != null) {
  //     print('Message also contained a notification: ${message.notification?.title} =======================');
  //   }
  // });
  WidgetsFlutterBinding.ensureInitialized();
  Paint.enableDithering = true;

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await Hive.initFlutter('Spotify');
  } else {
    await Hive.initFlutter();
  }
  await openHiveBox('settings');
  ;
  await openHiveBox('cache', limit: true);
  // if (Platform.isAndroid) {
  //   setOptimalDisplayMode();
  // }
  await startService();
  runApp(const MyApp());
}

// Future<void> setOptimalDisplayMode() async {
//   await FlutterDisplayMode.setHighRefreshRate();
// }

Future<void> startService() async {
  final AudioPlayerHandler audioHandler = await AudioService.init(
    builder: () => AudioPlayerHandlerImpl(),
    config: AudioServiceConfig(
      androidNotificationChannelId: 'com.example.music_app.channel.audio',
      androidNotificationChannelName: 'Spotyfy',
      // androidNotificationIcon: null,
      androidShowNotificationBadge: true,
      androidStopForegroundOnPause: false,
      notificationColor: Colors.grey[900],
    ),
  );
  GetIt.I.registerSingleton<AudioPlayerHandler>(audioHandler);
}
Future<void> openHiveBox(String boxName, {bool limit = false}) async {
  final box = await Hive.openBox(boxName).onError((error, stackTrace) async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final String dirPath = dir.path;
    File dbFile = File('$dirPath/$boxName.hive');
    File lockFile = File('$dirPath/$boxName.lock');
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      dbFile = File('$dirPath/BlackHole/$boxName.hive');
      lockFile = File('$dirPath/BlackHole/$boxName.lock');
    }
    await dbFile.delete();
    await lockFile.delete();
    await Hive.openBox(boxName);
    throw 'Failed to open $boxName Box\nError: $error';
  });
  // clear box if it grows large
  if (limit && box.length > 500) {
    box.clear();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // void get_token()async{
  //   final fcmToken = await FirebaseMessaging.instance.getToken();
  //   // print('--------------------------------');
  //   // print(fcmToken);
  //   // print('--------------------------------');
  // }

  @override
  Widget build(BuildContext context) {
    // get_token();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black38,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
      title: 'Spotify clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 42, 215, 94),
      ),
      home: StartScreen(),
      routes: routes,
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == '/player') {
          return PageRouteBuilder(
            opaque: false,
            pageBuilder: (_, __, ___) => const PlayScreen(),
          );
        }
        // return HandleRoute.handleRoute(settings.name);
      },
    );
  }
}
