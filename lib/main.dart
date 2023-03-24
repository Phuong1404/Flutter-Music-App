import 'package:flutter/material.dart';
import 'package:music_app/Screens/auth/register.screen.dart';
import 'package:music_app/Screens/auth/signin.screen.dart';
import 'package:music_app/Screens/auth/login.screen.dart';
import 'package:music_app/Screens/common/song_list.screen.dart';
import 'package:music_app/Screens/start/start.screen.dart';
import 'package:music_app/route.dart';
import 'Screens/home/home.screen.dart';
import 'Screens/start/splash.screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
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
  void get_token()async{
    final fcmToken = await FirebaseMessaging.instance.getToken();
    // print('--------------------------------');
    // print(fcmToken);
    // print('--------------------------------');
  }
  @override
  Widget build(BuildContext context) {
    get_token();
    return MaterialApp(
      title: 'Spotify clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 42, 215, 94),
      ),
      home: StartScreen(),
      routes: routes,
    );
  }
}
