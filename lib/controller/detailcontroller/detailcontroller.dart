import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/state_manager.dart';
import 'package:music_pro_1/controller/funtion.dart';
import 'package:music_pro_1/main.dart';
import 'package:music_pro_1/view/favorite/favorite.dart';
import 'package:music_pro_1/controller/favoritecontroller/favoritecontroller.dart';

class DetailController extends GetxController {
  int counting = 0;
  addToFavoriteFromDetail(nowplayingsongfavorite) async {
    favoriteController.favoritesongs.add(nowplayingsongfavorite);
    await favoritebox.put('favorite', favoriteController.favoritesongs);
    // setState(() {
    favoriteController.favoritesongs = favoritebox.get('favorite')!;
    // });

    update();
  }

  shuffle() {
    //setState(() {
    audioplayer.toggleShuffle();
    //  });
    update();
  }

  bool faveCheck(nowplayingsongfavorite) {
    bool isinfav = favoriteController.favoritesongs
        .where(
          (element) =>
              element.id.toString() == nowplayingsongfavorite.id!.toString(),
        )
        .isEmpty;

    return isinfav;
  }

  removeFav(nowplayingsongfavorite) async {
    favoriteController.favoritesongs.removeWhere(
      (element) =>
          element.id.toString() == nowplayingsongfavorite.id.toString(),
    );
    await favoritebox.put('favorite', favoriteController.favoritesongs);
    //setState(() {
    favoriteController.favoritesongs = favoritebox.get('favorite')!;
    // });

    update();
  }

  loopMode() async {
    // setState(() {
    if (counting % 2 == 0) {
      await audioplayer.setLoopMode(LoopMode.single);
      counting++;
    } else {
      await audioplayer.setLoopMode(LoopMode.none);
      counting++;
    }

    log(counting.toString());

    update();
    //        });
    //  update();
  }

  addToRecentcurentsongdetail(curentsongdetail) async {
    dbSongController.recent1 = dbSongController.box.get('recent1')!;
    final isinrecent = dbSongController.recent1
        .where(((element) =>
            element.id.toString() == curentsongdetail.metas.id.toString()))
        .toList();
    if (isinrecent.isEmpty) {
      final songmodelsong = dbSongController.dbsongs.firstWhere((element) =>
          element.id.toString() == curentsongdetail.metas.id.toString());

      dbSongController.recent1.add(songmodelsong);
      dbSongController.recent1 = dbSongController.recent1.reversed.toList();
      if (dbSongController.recent1.length >= 10) {
        dbSongController.recent1.removeLast();
      }
      dbSongController.recent1 = dbSongController.recent1.reversed.toList();
      await dbSongController.box.put('recent1', dbSongController.recent1);
      //
      //recent = box.get('recent1')!.toList();
    }
    update();
  }
}
