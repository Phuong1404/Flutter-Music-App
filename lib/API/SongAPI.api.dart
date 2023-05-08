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

  Future<List<Map>> getHistorySong(String id) async {
    final Uri path = Uri.parse('$Base_Url/spotify/song/history/$id');
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

  Future<Map> getPlayingSong(String id) async {
    final Uri path = Uri.parse('$Base_Url/spotify/song/quere/$id');
    final response = await get(path);
    if (response.statusCode == 200) {
      final Map data = await jsonDecode(response.body);
      final List results = data['list_song'] as List;
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
          "likeCount": results[i]['likeCount'],
          "is_playing": results[i]['is_playing']
        };
        songList.add(song_record);
      }
      final Map play_now = {
        "id": data['now_play']['id'],
        "name": data['now_play']['name'],
        "image": data['now_play']['image'],
      };
      return {"now_play": play_now, "list_song": songList};
    }
    return {};
  }

  Future<Map> changeSongQuere(String id, int currentIndex, int newIndex) async {
    try {
      final Uri path = Uri.parse('$Base_Url/spotify/change/quere/$id');
      final response = await post(path,
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*'
          },
          body: jsonEncode({'song1': currentIndex, 'song2': newIndex}));
      if (response.statusCode == 200) {
        final result = await jsonDecode(response.body);
        if (result['result']['Error'] == null) {
          return {"status_code": 200, "data": "Change quere success"};
        } else {
          return {"status_code": 400, "error": result['result']['Error']};
        }
      } else {
        return {
          "status_code": 400,
          "error": "Change quere failed, please try again"
        };
      }
    } catch (e) {
      return {
        "status_code": 400,
        "error": "Change quere failed, please try again"
      };
    }
  }

  Future<Map> nextSongQuere(String id) async {
    try {
      final Uri path = Uri.parse('$Base_Url/spotify/next/quere/$id');
      final response = await get(path);
      if (response.statusCode == 200) {
        final result = await jsonDecode(response.body);
        if (result['Error'] == null) {
          return {"status_code": 200, "data": "Success"};
        } else {
          return {"status_code": 400, "error": result['Error']};
        }
      } else {
        return {
          "status_code": 400,
          "error": "Next quere failed, please try again"
        };
      }
    } catch (e) {
      return {
        "status_code": 400,
        "error": "Next quere failed, please try again"
      };
    }
  }

  Future<Map> addSongQuere(String id, String song) async {
    try {
      final Uri path = Uri.parse('$Base_Url/spotify/change/quere/$id');
      final response = await post(path,
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*'
          },
          body: jsonEncode({'song': song}));
      if (response.statusCode == 200) {
        final result = await jsonDecode(response.body);
        if (result['result']['Error'] == null) {
          return {"status_code": 200, "data": "Add quere success"};
        } else {
          return {"status_code": 400, "error": result['result']['Error']};
        }
      } else {
        return {
          "status_code": 400,
          "error": "Add quere failed, please try again"
        };
      }
    } catch (e) {
      return {
        "status_code": 400,
        "error": "Add quere failed, please try again"
      };
    }
  }

}
