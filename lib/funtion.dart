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
