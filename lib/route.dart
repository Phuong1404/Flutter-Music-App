import 'package:flutter/material.dart';
import 'package:music_app/Screens/auth/login.screen.dart';
import 'package:music_app/Screens/auth/register.screen.dart';
import 'package:music_app/Screens/auth/signin.screen.dart';
import 'package:music_app/Screens/common/song_list.screen.dart';
import 'package:music_app/Screens/home/home.screen.dart';
import 'package:music_app/Screens/start/start.screen.dart';



final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => LoginScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  StartScreen.routeName: (context) => StartScreen(),
  HomeScreen.routeName:(context) => HomeScreen(),
  SongsListScreen.routeName:(context) => SongsListScreen()
};