import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:logging/logging.dart';

import 'StaticApi.config.dart';

class SearchAPI {
  final String Base_Url = ConfigApi().Base_Url;

  Future<Map> getSongSearch(String query) async {
    final Uri path = Uri.parse('$Base_Url/spotify/search/song?query=$query');
    final response = await get(path);
    if (response.statusCode == 200) {
      final List results = json.decode(response.body) as List;
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
      return {'songs': songList, 'error': ''};
    } else {
      return {'songs': List.empty(), 'error': 'Not Found'};
    }
  }

  Future<List<Map>> getAllSearch(String query) async {
    final Uri path = Uri.parse('$Base_Url/spotify/search?query=$query');
    final response = await get(path);
    if (response.statusCode == 200) {
      final result = await jsonDecode(response.body);
      final List album_list = result['album'] as List;
      final List artist_list = result['artist'] as List;
      final List playlist_list = result['playlist'] as List;

      final List<Map> album = [];
      final List<Map> artist = [];
      final List<Map> playlist = [];

      for (int i = 0; i < album_list.length; i++) {
        final List<Map> songList = [];
        for (int j = 0; j < album_list[i]['song_list'].length; j++) {
          songList.add({
            "id": album_list[i]['song_list'][j]['id'],
            "name": album_list[i]['song_list'][j]['name'],
            "image": album_list[i]['song_list'][j]['image'],
            "release_date": album_list[i]['song_list'][j]['release_date'],
            "topic": album_list[i]['song_list'][j]['topic'],
            "album_id": album_list[i]['song_list'][j]['album_id'],
            "file": album_list[i]['song_list'][j]['file'],
            "duration": album_list[i]['song_list'][j]['duration'],
            "listenCount": album_list[i]['song_list'][j]['listenCount'],
            "artist": album_list[i]['song_list'][j]['artist'],
            "likeCount": album_list[i]['song_list'][j]['likeCount']
          });
        }
        album.add({
          "id": album_list[i]['id'],
          "name": album_list[i]['name'],
          "image": album_list[i]['image'],
          "song_count": album_list[i]['song_count'],
          "release_date": album_list[i]['release_date'],
          "topic": album_list[i]['topic'],
          "song_list": songList
        });
      }

      for (int i = 0; i < artist_list.length; i++) {
        final List<Map> songList = [];
        for (int j = 0; j < artist_list[i]['song_list'].length; j++) {
          songList.add({
            "id": artist_list[i]['song_list'][j]['id'],
            "name": artist_list[i]['song_list'][j]['name'],
            "image": artist_list[i]['song_list'][j]['image'],
            "release_date": artist_list[i]['song_list'][j]['release_date'],
            "topic": artist_list[i]['song_list'][j]['topic'],
            "album_id": artist_list[i]['song_list'][j]['album_id'],
            "file": artist_list[i]['song_list'][j]['file'],
            "duration": artist_list[i]['song_list'][j]['duration'],
            "listenCount": artist_list[i]['song_list'][j]['listenCount'],
            "artist": artist_list[i]['song_list'][j]['artist'],
            "likeCount": artist_list[i]['song_list'][j]['likeCount']
          });
        }
        artist.add({
          "id": artist_list[i]['id'],
          "name": artist_list[i]['name'],
          "avatar": artist_list[i]['avatar'],
          "album_count": artist_list[i]['album_count'],
          "song_count": artist_list[i]['song_count'],
          "song_list": songList
        });
      }

      for (int i = 0; i < playlist_list.length; i++) {
        final List<Map> songList = [];
        for (int j = 0; j < playlist_list[i]['song_list'].length; j++) {
          songList.add({
            "id": playlist_list[i]['song_list'][j]['id'],
            "name": playlist_list[i]['song_list'][j]['name'],
            "image": playlist_list[i]['song_list'][j]['image'],
            "release_date": playlist_list[i]['song_list'][j]['release_date'],
            "topic": playlist_list[i]['song_list'][j]['topic'],
            "album_id": playlist_list[i]['song_list'][j]['album_id'],
            "file": playlist_list[i]['song_list'][j]['file'],
            "duration": playlist_list[i]['song_list'][j]['duration'],
            "listenCount": playlist_list[i]['song_list'][j]['listenCount'],
            "artist": playlist_list[i]['song_list'][j]['artist'],
            "likeCount": playlist_list[i]['song_list'][j]['likeCount']
          });
        }
        playlist.add({
          "id": playlist_list[i]['id'],
          "name": playlist_list[i]['name'],
          "song_count": playlist_list[i]['song_count'],
          "song_list": songList
        });
      }
      return ([{"album": album, "artist": artist, "playlist": playlist}]);
    } else {
      return List.empty();
    }
  }
}
