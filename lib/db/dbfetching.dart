import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:music_pro_1/db/allsongstoringclass.dart';
import 'package:music_pro_1/db/boxinstance.dart';
import 'package:music_pro_1/funtion.dart';
import 'package:hive/hive.dart';
import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool nowplay = false;

bool notificationison = false;
bool? notificationison5;

List<SongModel>? fetchedsongs;
List<AllSongs>? allsongs;
List<AllSongs> dbsongs = [];
List<Audio> audioconvertedsongs = [];
List<dynamic>? favoritesongs = [];
String? value1;
//play list
List playlists = [];

final playlistbox = Boxes.getInstance();
List playlistkeys = playlistbox.keys.toList();
List playlistkey = [];
List<dynamic> playlistsongs1 = [];

//recent
List<dynamic> recent = [];
List<dynamic> recent1 = [];
final box = Boxes.getInstance();

fetchSongs() async {
  bool ispermition = await audioquery.permissionsStatus();
  if (!ispermition) {
    await audioquery.permissionsRequest();
  }

  fetchedsongs = await audioquery.querySongs();
  if (fetchedsongs != null) {
    allsongs = fetchedsongs!
        .map((audio) => AllSongs(
              uri: audio.uri,
              artist: audio.artist,
              id: audio.id,
              title: audio.title,
              duration: audio.duration,
            ))
        .toList();
  }

  final Box<List> boxallsongs = Boxes.getInstance();
  await boxallsongs.put('totalsongs', allsongs!);
  dbsongs = boxallsongs.get('totalsongs') as List<AllSongs>;

  if (dbsongs != null) {
    for (var element in dbsongs) {
      audioconvertedsongs.add(Audio.file(
        element.uri.toString(),
        metas: Metas(
            id: element.id.toString(),
            title: element.title,
            artist: element.artist,
            album: element.duration.toString()),
      ));
    }
  }
  //favorite
  //final favoritebox = await Hive.box<List>('favorite');
}

// class FavoriteBoxes {
//   static Box<List>? box;
//   static Box<List>? getinstance() {
//      return box.
//   }
// }

//  List  
//  final playlistbox1 = Boxes.getInstance();
// List playlistkeys1 = playlistbox1.keys.toList();