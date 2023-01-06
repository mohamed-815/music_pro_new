import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:music_pro_1/db/audioplay.dart';
import 'package:music_pro_1/db/boxinstance.dart';
import 'package:music_pro_1/db/dbsongcontroller/dbsongcontroller.dart';
import 'package:music_pro_1/main.dart';
import 'package:music_pro_1/presentation/home/widget/allsongs.dart';
import 'package:music_pro_1/presentation/playlist/insideplaylist.dart';

class PlayListController extends GetxController {
  List<Audio> playlistaudio = [];
  late TextEditingController controller;
  final formkey = GlobalKey<FormState>();
  List playlistkeys = playlistbox.keys.toList();
  @override
  void onInit() {
    // requesrpermisson();
    controller = TextEditingController();

    super.onInit();
  }

  playlistSongLoad(playlistname) {
    final playlistsongs1 = playlistbox.get(playlistname)!;
  }

  void submit(context) {
    //playlistName = controller.text;
    List<AllSongs1> librayry = [];
    List<dynamic> freelist = [];
    List? excistingName = [];
    if (dbSongController.playlists1.isNotEmpty) {
      excistingName = dbSongController.playlists1
          .where((element) => element == controller.text)
          .toList();
    }

    if (controller.text != '' &&
        excistingName.isEmpty &&
        formkey.currentState!.validate()) {
      playlistbox.put(controller.text, freelist);
      Navigator.of(context).pop();

      //setState(() {
      playlistkeys = playlistbox.keys.toList();
      // });
    }

    // else {
    //   ScaffoldMessenger.of(context).showSnackBar(existingPlaylist);
    // }

    controller.clear();
    update();
  }

  String totalSongs({required name}) {
    final playBox = Boxes.getInstance();
    final list = playBox.get(name);
    final temp = list!.length.toString();
    return temp;
  }

  playListDelete(index) async {
    if (playlistbox.keys.toList() != 'favorite' ||
        playlistbox.keys.toList() != 'totalsongs' ||
        playlistbox.keys.toList() != 'recent1') {
      await playlistbox.delete(playlistkeys[index]);
    }

    playlistkeys = playlistbox.keys.toList();
    // playlistkeys.removeWhere((element) =>
    //     element.toString() ==
    //     playlistkeys[index].toString());

    update();
  }

  void submit1(playlistcurrentname, context) async {
    //playlistName = controller.text;
    //List<AllSongs1> librayry = [];

    List<dynamic> freelist = playlistbox.get(playlistcurrentname)!.toList();
    List? excistingName = [];
    if (dbSongController.playlists1.isNotEmpty) {
      excistingName = dbSongController.playlists1
          .where((element) => element == controller.text)
          .toList();
    }

    if (controller.text != '' &&
        excistingName.isEmpty &&
        formkey.currentState!.validate()) {
      await playlistbox.put(controller.text, freelist);
      await playlistbox.delete(playlistcurrentname);
      Navigator.of(context).pop();
      //  setState(() {
      playlistkeys = playlistbox.keys.toList();
      // });
    }

    // else {
    //   ScaffoldMessenger.of(context).showSnackBar(existingPlaylist);
    // }

    controller.clear();

    update();
  }

  playlist(e) async {
    if (playlistbox.keys.toList() != 'favorite' ||
        playlistbox.keys.toList() != 'totalsongs') {
      await playlistbox.delete(e);
    }

    //   setState(() {

    playlistkeys = playlistbox.keys.toList();
    // playlistkeys.removeWhere((element) =>
    //     element.toString() ==
    //     playlistkeys[index].toString());
    // });

    update();
  }

  playlistSongAdd(playlistsong6, index, box1, playlistname1) async {
    final ispresent = playlistsong6.where((element) =>
        element.id.toString() == dbSongController.dbsongs[index].id.toString());

    if (ispresent.isEmpty) {
      //setState(() {
      playlistsong6.add(dbSongController.dbsongs[index]);
      // });

      await box1.put(playlistname1, playlistsong6);
    }
    update();
  }

  adingToRecentFromPlayList(index) async {
    dbSongController.recent1 = dbSongController.box.get('recent1')!;
    final isinrecent = dbSongController.recent1
        .where(((element) =>
            element.id.toString() ==
            dbSongController.playlistsongs1[index].id.toString()))
        .toList();
    if (isinrecent.isEmpty) {
      dbSongController.recent1.add(dbSongController.playlistsongs1[index]);
      dbSongController.recent1 = dbSongController.recent1.reversed.toList();
      if (dbSongController.recent1.length >= 10) {
        dbSongController.recent1.removeLast();
      }
      dbSongController.recent1 = dbSongController.recent1.reversed.toList();
      await dbSongController.box.put('recent1', dbSongController.recent1);
      // recent = box.get('recent1')!.toList();
    }

    update();
  }

  playListSongPlay(index) async {
    for (var element in dbSongController.playlistsongs1) {
      playlistaudio.add(Audio.file(element.uri.toString(),
          metas: Metas(
            title: element.title,
            id: element.id.toString(),
            artist: element.artist,
            album: element.duration.toString(),
          )));
    }

    await AssetAudioPlay(audioconvertedsongs: playlistaudio, index: index)
        .songPlayNow(playlistaudio, index);
  }
}
