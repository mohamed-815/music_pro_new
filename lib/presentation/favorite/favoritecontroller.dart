import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/state_manager.dart';
import 'package:music_pro_1/db/audioplay.dart';
import 'package:music_pro_1/db/boxinstance.dart';
import 'package:music_pro_1/main.dart';
import 'package:music_pro_1/presentation/favorite/favorite.dart';

final favoritebox = Boxes.getInstance();

class FavoriteController extends GetxController {
  RxList<dynamic>? favoritesongs = [].obs;
  List<Audio> playlikedsong = [];

  addingTofavorite(index) async {
    dbSongController.recent1 = dbSongController.box.get('recent1')!;
    final isinrecent = dbSongController.recent1
        .where(((element) =>
            element.id.toString() == favoritesongs![index].id.toString()))
        .toList();
    if (isinrecent.isEmpty) {
      dbSongController.recent1.add(favoritesongs![index]);
      dbSongController.recent1 = dbSongController.recent1.reversed.toList();
      if (dbSongController.recent1.length >= 5) {
        dbSongController.recent1.removeLast();
      }
      dbSongController.recent1 = dbSongController.recent1.reversed.toList();
      await dbSongController.box.put('recent1', dbSongController.recent1);
      // recent = box.get('recent1')!.toList();
    }
  }

  favoriteSongplay(index) async {
    for (var element in favoritesongs!) {
      ///////  check
      playlikedsong.add(Audio.file(element.uri.toString(),
          metas: Metas(
            title: element.title,
            id: element.id.toString(),
            artist: element.artist,
            album: element.duration.toString(),
          )));
    }

    await AssetAudioPlay(audioconvertedsongs: playlikedsong, index: index)
        .songPlayNow(playlikedsong, index);
  }

  removeFromfave(index) async {
    favoritesongs!.removeAt(index);

    await favoritebox.put('favorite', favoriteController.favoritesongs!);

    favoritesongs!.value = favoritebox.get('favorite')!;
  }
}
