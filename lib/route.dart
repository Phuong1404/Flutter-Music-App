import 'package:flutter/material.dart';
import 'package:music_app/Screens/auth/login.screen.dart';
import 'package:music_app/Screens/auth/register.screen.dart';
import 'package:music_app/Screens/auth/signin.screen.dart';
import 'package:music_app/Screens/common/song_list.screen.dart';
import 'package:music_app/Screens/home/home.screen.dart';
import 'package:music_app/Screens/library/liked.screen.dart';
import 'package:music_app/Screens/library/nowplaying.screen.dart';
import 'package:music_app/Screens/library/playlists.dart';
import 'package:music_app/Screens/library/recent.screen.dart';
import 'package:music_app/Screens/profile/profile.screen.dart';
import 'package:music_app/Screens/start/start.screen.dart';
import 'package:music_app/Screens/topchart/top_chart.screen.dart';



final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => LoginScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  StartScreen.routeName: (context) => StartScreen(),
  HomeScreen.routeName:(context) => HomeScreen(),
  SongsListScreen.routeName:(context) => SongsListScreen(),
  NowPlaying.routeName:(context)=>NowPlaying(),
  RecentlyPlayed.routeName:(context)=>RecentlyPlayed(),
  LikedSongs.routeName:(context)=>LikedSongs(playlistName: '',),
  PlaylistScreen.routeName:(context)=>PlaylistScreen(),
  ProfilePage.routeName:(context)=>ProfilePage(),
};