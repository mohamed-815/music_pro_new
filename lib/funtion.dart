import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:on_audio_query/on_audio_query.dart';

AssetsAudioPlayer audioplayer = AssetsAudioPlayer.withId("0");
Audio find(List<Audio> audioconvertedsongs, String frompath) {
  return audioconvertedsongs.firstWhere((element) => element.path == frompath);
}

final audioquery = OnAudioQuery();

class Songs1 {
  final String? title;
  final String? image;
  final IconData? icon1;
  Songs1({this.title, this.image, this.icon1});
}

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
      title: 'Recent',
      image:
          //'assets/black-brick-wall-background-600w-709530229.webp'
          "assets/photo-1531651008558-ed1740375b39.jpg"),
];
