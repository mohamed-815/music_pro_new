import 'package:assets_audio_player/assets_audio_player.dart';

class SongDetails {
  final String? title;
  final String? titlesmall;
  final String? image1;
  SongDetails({this.image1, this.title, this.titlesmall});
}

final Songdetailarrey = [
  SongDetails(
      title: 'hara hara',
      titlesmall: 'nadirsha',
      image1: "assets/best-rap-songs-1583527287.png"),
  SongDetails(
      title: 'melody',
      titlesmall: 'dua lipa',
      image1: "assets/best-rap-songs-1583527287.png"),
  SongDetails(
      title: 'vibe ',
      titlesmall: 'justin beebar',
      image1: "assets/best-rap-songs-1583527287.png"),
  SongDetails(
      title: 'harey ram',
      titlesmall: 'honey sing',
      image1: "assets/best-rap-songs-1583527287.png"),
  SongDetails(
      title: 'honey boney',
      titlesmall: 'nadirsha',
      image1: "assets/best-rap-songs-1583527287.png"),
  SongDetails(
      title: 'rabba rabba',
      titlesmall: 'MG shreekumar',
      image1: "assets/best-rap-songs-1583527287.png"),
  SongDetails(
      title: 'inakkuyil',
      titlesmall: 'Sithara',
      image1: "assets/best-rap-songs-1583527287.png"),
];

final songarrey1 = <Audio>[
  Audio(
    'assets/musics/sample-12s.mp3',
    metas: Metas(id: 'indian1', title: 'Inakkuzhil', artist: 'Sabu'),
  ),
  Audio(
    'assets/musics/file_example_MP3_2MG.mp3',
    metas: Metas(id: 'indian1', title: 'kadal mannan', artist: 'Sabu'),
  ),
  Audio(
    'assets/musics/sample-15s.mp3',
    metas: Metas(id: 'indian1', title: 'my love is gone', artist: 'Inna'),
  ),
];
