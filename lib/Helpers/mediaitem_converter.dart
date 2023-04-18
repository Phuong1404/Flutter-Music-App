import 'package:audio_service/audio_service.dart';

class MediaItemConverter {
  static Map mediaItemToMap(MediaItem mediaItem) {
    return {
      "id": mediaItem.id,
      'album': mediaItem.album.toString(),
      'album_id': mediaItem.extras?['album_id'],
      'title': mediaItem.title, //name
      'image': mediaItem.extras!['image'].toString(),
      'url': mediaItem.extras!['url'].toString(),
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
        seconds: int.parse(
          (song['duration'] == null ||
                  song['duration'] == 'null' ||
                  song['duration'] == '')
              ? '180'
              : song['duration'].toString(),
        ),
      ),
      title: song['title'].toString(),
      extras: {
        'image':song['image'],
        'url': song['url'],
        'album_id': song['album_id'],
        'subtitle': song['subtitle'],
        'addedByAutoplay': addedByAutoplay,
        'autoplay': autoplay,
        'playlistBox': playlistBox,
      },
    );
  }
}
