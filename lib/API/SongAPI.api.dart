import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:music_app/API/StaticApi.config.dart';

class SongApi {
  final String Base_Url = ConfigApi().Base_Url;

  Future<List<Map>> getGlobal() async {
    final Uri path = Uri.parse('$Base_Url/spotify/song/global');
    final response = await get(path);
    if (response.statusCode == 200) {
      final List results = await jsonDecode(response.body) as List;
      final List<Map> songList = [];
      for (int i = 0; i < results.length; i++) {
        Map? song_record = {
          "id": results[i]['id'],
          "name": results[i]['name'],
          "image": results[i]['image'],
          "release_date": results[i]['release_date'],
          "topic": results[i]['topic'],
          "album_id": results[i]['album_id'],
          "file": results[i]['file'],
          "duration": results[i]['duration'],
          "listenCount": results[i]['listenCount'],
          "artist": results[i]['artist'],
          "likeCount": results[i]['likeCount']
        };
        songList.add(song_record);
      }
      return songList;
    }
    return List.empty();
  }


  Future<List<Map>> getLocal() async {
    final Uri path = Uri.parse('$Base_Url/spotify/song/local');
    final response = await get(path);
    if (response.statusCode == 200) {
      final List results = await jsonDecode(response.body) as List;
      final List<Map> songList = [];
      for (int i = 0; i < results.length; i++) {
        Map? song_record = {
          "id": results[i]['id'],
          "name": results[i]['name'],
          "image": results[i]['image'],
          "release_date": results[i]['release_date'],
          "topic": results[i]['topic'],
          "album_id": results[i]['album_id'],
          "file": results[i]['file'],
          "duration": results[i]['duration'],
          "listenCount": results[i]['listenCount'],
          "artist": results[i]['artist'],
          "likeCount": results[i]['likeCount']
        };
        songList.add(song_record);
      }
      return songList;
    }
    return List.empty();
  }
}
