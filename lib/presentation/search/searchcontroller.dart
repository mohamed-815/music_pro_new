import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_pro_1/main.dart';

class SearchController extends GetxController {
  List<dynamic> listsearch = [];
  List<Audio> listsearch1 = [];
  String? valeu1;
  final controller1 = TextEditingController();

  findingSong(value) {
    //setState(() {
    listsearch = dbSongController.dbsongs
        .where((element) =>
            element.title!.toLowerCase().contains(value.toLowerCase()))
        .toList();
    //                   });

    update();
  }
}
