import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import 'package:marquee/marquee.dart';
import 'package:music_pro_1/db/allsongstoringclass.dart';
import 'package:music_pro_1/db/dbfetching.dart';
import 'package:music_pro_1/main.dart';
import 'package:music_pro_1/presentation/detailsongs/detailsong.dart';
import 'package:music_pro_1/funtion.dart';

class MiniPlayer extends StatelessWidget {
  int? index;
  List<dynamic>? dbsong1;

  MiniPlayer({this.dbsong1, this.index, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenhieght = MediaQuery.of(context).size.height;
    final double screenwidth = MediaQuery.of(context).size.width;
    //
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => DetailSong(
                    audioPlayer: audioplayer,
                  )))),
      child: Center(
        child: audioplayer.builderCurrent(builder: (context, Playing? playing) {
          final miniplayersongdetail = find(
              dbSongController.audioconvertedsongs,
              playing!.audio.assetAudioPath);
          return Container(
            height: screenhieght / 9,
            width: screenwidth,
            child: Card(
              color: Colors.white.withOpacity(.01),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Center(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF52796F),
                    radius: 30,
                    child: CircleAvatar(
                      child: PlayerBuilder.isPlaying(
                          player: audioplayer,
                          builder: (context, isPlaying) {
                            return GestureDetector(
                                onTap: () => audioplayer.playOrPause(),
                                child: isPlaying
                                    ? const Icon(Icons.pause,
                                        color: Colors.white)
                                    : const Icon(Icons.play_arrow,
                                        color: Colors.white));
                          }),
                      backgroundColor: const Color.fromARGB(255, 27, 40, 37),
                      radius: 22,
                    ),
                  ),
                  title: Container(
                      child: Marquee(
                          text: miniplayersongdetail.metas.title!,
                          style: TextStyle(fontSize: 20, color: Colors.white))),
                  // subtitle: Marquee(text: miniplayersongdetail.metas.artist!),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onDoubleTapCancel: () {},
                        onDoubleTapDown: ((details) {}),
                        onDoubleTap: () {},
                        onTap: () async {
                          dbSongController.recent1 =
                              dbSongController.box.get('recent1')!;
                          final isinrecent = dbSongController.recent1
                              .where(((element) =>
                                  element.id.toString() ==
                                  miniplayersongdetail.metas.id.toString()))
                              .toList();
                          if (isinrecent.isEmpty) {
                            final songmodelsong = dbSongController.dbsongs
                                .firstWhere((element) =>
                                    element.id.toString() ==
                                    miniplayersongdetail.metas.id.toString());

                            dbSongController.recent1.add(songmodelsong);
                            dbSongController.recent1 =
                                dbSongController.recent1.reversed.toList();
                            if (dbSongController.recent1.length >= 10) {
                              dbSongController.recent1.removeLast();
                            }
                            dbSongController.recent1 =
                                dbSongController.recent1.reversed.toList();
                            await dbSongController.box
                                .put('recent1', dbSongController.recent1);
                            // recent = box.get('recent1')!.toList();
                          }

                          audioplayer.previous();
                        },
                        child: const CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(0xFF52796F),
                          child: CircleAvatar(
                              radius: 22,
                              backgroundColor: Color.fromARGB(255, 27, 40, 37),
                              child:
                                  //  dbsongs[widget.index!] != 0
                                  //     ?

                                  Icon(
                                Icons.skip_previous,
                                color: Colors.white,
                                size: 35,
                              )
                              // : Container()

                              ),
                        ),
                      ),
                      SizedBox(
                        width: screenwidth / 25,
                      ),
                      GestureDetector(
                        onDoubleTapCancel: () {},
                        onDoubleTapDown: ((details) {}),
                        onDoubleTap: () {},
                        onTap: () async {
                          dbSongController.recent1 =
                              dbSongController.box.get('recent1')!;
                          final isinrecent = dbSongController.recent1
                              .where(((element) =>
                                  element.id.toString() ==
                                  miniplayersongdetail.metas.id.toString()))
                              .toList();
                          if (isinrecent.isEmpty) {
                            final songmodelsong = dbSongController.dbsongs
                                .firstWhere((element) =>
                                    element.id.toString() ==
                                    miniplayersongdetail.metas.id.toString());

                            dbSongController.recent1.add(songmodelsong);
                            dbSongController.recent1 =
                                dbSongController.recent1.reversed.toList();
                            if (dbSongController.recent1.length >= 10) {
                              dbSongController.recent1.removeLast();
                            }
                            dbSongController.recent1 =
                                dbSongController.recent1.reversed.toList();
                            await dbSongController.box
                                .put('recent1', dbSongController.recent1);
                            // recent = box.get('recent1')!.toList();
                          }
                          audioplayer.next();
                        },

                        child: const CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(0xFF52796F),
                          child: CircleAvatar(
                              radius: 22,
                              backgroundColor: Color.fromARGB(255, 27, 40, 37),
                              child:
                                  // widget.convertedsongs![widget.index!] !=
                                  //  widget.convertedsongs!.length?
                                  Icon(
                                Icons.skip_next,
                                color: Colors.white,
                                size: 35,
                              )
                              // :
                              //Container()
                              ),
                        ),
                        // CircleAvatar(
                        //   radius: 25,
                        //   backgroundColor: Color(0xFF9d4edd),
                        //   child: CircleAvatar(
                        //     radius: 30,
                        //     backgroundColor: Color.fromARGB(255, 27, 40, 37),
                        //     child: Icon(
                        //       Icons.skip_next,
                        //       color: Colors.white,
                        //       size: 35,
                        //     ),
                        //   ),
                        // ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
