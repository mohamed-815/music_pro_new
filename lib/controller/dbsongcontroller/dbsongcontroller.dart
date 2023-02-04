import 'package:get/state_manager.dart';

import 'package:music_pro_1/models/db/boxinstance.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:music_pro_1/controller/funtion.dart';
import 'package:hive/hive.dart';
import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:music_pro_1/models/db/allsongstoringclass.dart';
import 'package:music_pro_1/models/db/boxinstance.dart';

final playlistbox = Boxes.getInstance();

class DbSongController extends GetxController {
  bool nowplay = false;

  RxBool notificationison = false.obs;
  RxBool notificationison5 = false.obs;

  List<SongModel>? fetchedsongs;
  List<AllSongs>? allsongs;
  List<dynamic> dbsongs = [];
  List<Audio> audioconvertedsongs = [];

  String? value1;
//play list
  List playlists1 = [];

  //List playlistkeys = playlistbox.keys.toList();
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
    dbsongs = boxallsongs.get('totalsongs')!;

    // as

    //List<AllSongs>;

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

  sheredprefenrenceinitial() async {
    SharedPreferences pref3 = await SharedPreferences.getInstance();
    notificationison5.value = pref3.getBool('isturnon')!;
  }

  sheredprefenrenceinitialseting() async {
    final pref3 = await SharedPreferences.getInstance();
    notificationison5.value = await pref3.setBool('isturnon', false);
  }

// sheredprefenrenceinitial() async {
//   final pref3 = await SharedPreferences.getInstance();
//   dbSongController.notificationison5 = pref3.getBool('isturnon')!;

// all song to favorite

  // loadFavorite() {
  //   favoritesongs = favoritebox.get('favorite');
  // }
}
