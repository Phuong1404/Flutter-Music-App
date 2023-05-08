import 'package:audio_service/audio_service.dart';

class MediaItemConverter {
  static Map mediaItemToMap(MediaItem mediaItem) {
    return {
      "id": mediaItem.id,
      'album': mediaItem.album.toString(),
      'album_id': mediaItem.extras?['album_id'],
      'title': mediaItem.title, //name
      'image': mediaItem.extras!['image'].toString(),
      'file': mediaItem.extras!['file'].toString(),
      "duration": mediaItem.duration?.inSeconds.toString(),
      "artist": mediaItem.artist.toString(),
      'subtitle': mediaItem.extras?['subtitle'],
    };
  }

  static MediaItem mapToMediaItem(
    Map song, {
    bool addedByAutoplay = false,
    bool autoplay = true,
    String? playlistBox,
  }) {
    return MediaItem(
      id: song['id'].toString(),
      album: song['album'].toString(),
      artist: song['artist'].toString(),
      duration: Duration(
          milliseconds:
              (double.parse(song['duration'].toString()) * 60000).toInt()),
      title: song['name'].toString(),
      extras: {
        'image': song['image'],
        'file': song['file'],
        'subtitle': song['artist'],
        'addedByAutoplay': addedByAutoplay,
        'autoplay': autoplay,
        'playlistBox': playlistBox,
      },
    );
  }
}
