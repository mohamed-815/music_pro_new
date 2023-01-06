import 'package:get/state_manager.dart';
import 'package:music_pro_1/db/audioplay.dart';
import 'package:music_pro_1/funtion.dart';
import 'package:music_pro_1/main.dart';
import 'package:music_pro_1/presentation/favorite/favorite.dart';
import 'package:music_pro_1/presentation/favorite/favoritecontroller.dart';

class MainScreenController extends GetxController {
  final SongList = [
    Songs1(
        title: 'Favorite',
        image:
            //'assets/black-brick-wall-background-600w-709530229.webp'
            "assets/unnamed.jpg"),
    Songs1(
        title: 'Play List',
        image:
            // 'assets/black-brick-wall-background-600w-709530229.webp'
            "assets/headphone-music-hd-wallpaper-for-mobile-3831409.png"),
    Songs1(
        title: 'Recents',
        image:
            //'assets/black-brick-wall-background-600w-709530229.webp'
            "assets/photo-1531651008558-ed1740375b39.jpg"),
  ].obs;

  addingToRecentfromhome(index) async {
    dbSongController.recent1 = dbSongController.box.get('recent1')!;
    final isinrecent = dbSongController.recent1
        .where(((element) =>
            element.id.toString() ==
            dbSongController.dbsongs[index].id.toString()))
        .toList();
    if (isinrecent.isEmpty) {
      dbSongController.recent1.add(dbSongController.dbsongs[index]);
      dbSongController.recent1 = dbSongController.recent1.reversed.toList();
      if (dbSongController.recent1.length >= 10) {
        dbSongController.recent1.removeLast();
      }
      dbSongController.recent1 = dbSongController.recent1.reversed.toList();
      await dbSongController.box.put('recent1', dbSongController.recent1);
      // recent = box.get('recent1')!.toList();
    }
  }

  mainScreenaudioplay(index) {
    AssetAudioPlay(
            audioconvertedsongs: dbSongController.audioconvertedsongs,
            index: index)
        .songPlayNow(dbSongController.audioconvertedsongs, index);
  }

  removeFromfav(index) async {
    favoriteController.favoritesongs.removeWhere(
      (element) =>
          element.id.toString() ==
          dbSongController.dbsongs[index].id.toString(),
    );
    await favoritebox.put('favorite', favoriteController.favoritesongs);

    favoriteController.favoritesongs = favoritebox.get('favorite')!;
    update();
  }

  addTofav(index) async {
    favoriteController.favoritesongs.add(dbSongController.dbsongs[index]);
    await favoritebox.put('favorite', favoriteController.favoritesongs);

    favoriteController.favoritesongs = favoritebox.get('favorite')!;
    update();
  }

  bool favCheck(index) {
    return favoriteController.favoritesongs
        .where(
          (element) =>
              element.id.toString() ==
              dbSongController.dbsongs[index].id!.toString(),
        )
        .isEmpty;
  }
}
