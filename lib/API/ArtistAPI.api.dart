import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:music_app/API/StaticApi.config.dart';

class ArtistApi {
  final String Base_Url = ConfigApi().Base_Url;

  Future<List<Map>> getAllArtist() async {
    final Uri path = Uri.parse('$Base_Url/spotify/artists');
    final response = await get(path);
    if (response.statusCode == 200) {
      final List results = await jsonDecode(response.body) as List;
      final List<Map> artistList = [];
      for (int i = 0; i < results.length; i++) {
        Map? artist_record = {
          "id": results[i]['id'],
          "name": results[i]['name'],
          "avatar": results[i]['avatar'],
          "album_count": results[i]['album_count'],
          "song_count": results[i]['song_count']
        };
        artistList.add(artist_record);
      }
      return artistList;
    }
    return List.empty();
  }

  Future<Map> getOneArtist(String Id) async {
    final Uri path = Uri.parse('$Base_Url/spotify/artists/$Id');
    final response = await get(path);
    if (response.statusCode == 200) {
      final result = await jsonDecode(response.body);
      final List album_list = result['album'] as List;
      final List song_list = result['song'] as List;
      final List<Map> album = [];
      final List<Map> song = [];
      for (int i = 0; i < album_list.length; i++) {
        Map? data = {
          "id": album_list[i]['id'],
          "name": album_list[i]['name'],
          "image": album_list[i]['image'],
          "topic": album_list[i]['topic'],
          "song_count": album_list[i]['song_count'],
        };
        album.add(data);
      }
      for (int i = 0; i < song_list.length; i++) {
        Map? data = {
          "id": song_list[i]['id'],
          "name": song_list[i]['name'],
          "image": song_list[i]['image'],
          "file": song_list[i]['file'],
          "duration": song_list[i]['duration'],
          "artist": song_list[i]['artist'],
        };
        song.add(data);
      }
      return {
        "id": result['id'],
        "name": result['name'],
        "avatar": result['avatar'],
        "birthday": result['birthday'],
        "song": song,
        "album": album
      };
    }
    return {};
  }
}
