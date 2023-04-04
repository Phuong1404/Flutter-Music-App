import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_app/Screens/player/audioplayer.screen.dart';
import 'package:music_app/Screens/start/start.screen.dart';
import 'package:music_app/route.dart';

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
  runApp(const MyApp());
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
      home: PlayScreen(),
      routes: routes,
    );
  }
}
