import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:logging/logging.dart';

import 'StaticApi.config.dart';

class AlbumAPI {
  final String Base_Url = ConfigApi().Base_Url;

  Future<Map> getTrendingAlbum() async {
    final Uri path = Uri.parse('$Base_Url/spotify/album/trending');
    final response = await get(path);
    if (response.statusCode == 200) {
      final List results = json.decode(response.body) as List;
      final List<Map> albumList = [];
      for (int i = 0; i < results.length; i++) {
        Map? album_record = {
          "id": results[i]['id'],
          "name": results[i]['name'],
          "image": results[i]['image'],
          "release_date": results[i]['release_date'],
          "topic": results[i]['topic'],
          "artist": results[i]['artist'],
          "song_count": results[i]['song_count'],
        };
        albumList.add(album_record);
      }
      return {"result": albumList, "length": albumList.length};
    }
    return {"message": "Data not found"};
  }

  Future<Map> getPopulateAlbum() async {
    final Uri path = Uri.parse('$Base_Url/spotify/album/most');
    final response = await get(path);
    if (response.statusCode == 200) {
      final List results = json.decode(response.body) as List;
      final List<Map> albumList = [];
      for (int i = 0; i < results.length; i++) {
        Map? album_record = {
          "id": results[i]['id'],
          "name": results[i]['name'],
          "image": results[i]['image'],
          "release_date": results[i]['release_date'],
          "topic": results[i]['topic'],
          "artist": results[i]['artist'],
          "song_count": results[i]['song_count'],
        };
        albumList.add(album_record);
      }
      return {"result": albumList, "length": albumList.length};
    }
    return {"message": "Data not found"};
  }

  Future<Map> getByUserAlbum() async {
    final Uri path = Uri.parse('$Base_Url/spotify/album/random');
    final response = await get(path);
    if (response.statusCode == 200) {
      final List results = json.decode(response.body) as List;
      final List<Map> albumList = [];
      for (int i = 0; i < results.length; i++) {
        Map? album_record = {
          "id": results[i]['id'],
          "name": results[i]['name'],
          "image": results[i]['image'],
          "release_date": results[i]['release_date'],
          "topic": results[i]['topic'],
          "artist": results[i]['artist'],
          "song_count": results[i]['song_count'],
        };
        albumList.add(album_record);
      }
      return {"result": albumList, "length": albumList.length};
    }
    return {"message": "Data not found"};
  }

  Future<Map> getSongInAlbum(String id) async {
    final Uri path = Uri.parse('$Base_Url/spotify/album/$id');
    final response = await get(path);
    if (response.statusCode == 200) {
      final result = await jsonDecode(response.body);
      final List song = result['song'] as List;
      final List<Map> songList = [];
      for (int i = 0; i < song.length; i++) {
        Map? song_record = {
          "id": song[i]['id'],
          "name": song[i]['name'],
          "image": song[i]['image'],
          "release_date": song[i]['release_date'],
          "file": song[i]['file'],
          "duration": song[i]['duration'],
          "artist": song[i]['artist'],
        };
        songList.add(song_record);
      }
      return {
        "id": result['id'],
        "name": result['name'],
        "image": result['image'],
        "release_date": result['release_date'],
        "topic": result['topic'],
        "song_count": result['song_count'],
        "song": songList,
        "artist": result['artist'],
      };
    }
    return {"message": "Data not found"};
  }
}
