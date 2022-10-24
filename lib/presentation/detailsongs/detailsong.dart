import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

import 'package:marquee/marquee.dart';
import 'package:music_pro_1/db/boxinstance.dart';
import 'package:music_pro_1/db/dbfetching.dart';
import 'package:music_pro_1/funtion.dart';
import 'package:music_pro_1/main.dart';
import 'package:music_pro_1/presentation/favorite/favorite.dart';
import 'package:music_pro_1/presentation/home/mainscreen.dart';
import 'package:music_pro_1/presentation/commonwidgets/showbottomsheetplaylist.dart';

import 'package:on_audio_query/on_audio_query.dart';

class DetailSong extends StatefulWidget {
  final Audio? songdetailsshow;
  final AssetsAudioPlayer audioPlayer;
  int? index;
  final AsyncSnapshot<List<SongModel>>? item;

  DetailSong(
      {Key? key,
      this.songdetailsshow,
      this.index,
      required this.audioPlayer,
      this.item})
      : super(key: key);

  @override
  State<DetailSong> createState() => _DetailSongState();
}

class _DetailSongState extends State<DetailSong> {
  int? numberindex;
  bool isplay = true;
  bool isfavorite = false;
  int count = 1;
  int count1 = 1;
  int count2 = 1;
  @override
  void initState() {
    //if (widget.songdetailsshow == null) {
    //songPlayNow();
    // } else {
    //   songPlayNext();
    // }

    // TODO: implement initState
    super.initState();
  }

  // Future<void> songPlayNow() async {
  //   await widget.audioPlayer.open(
  //       showNotification: true,
  //       Playlist(audios: audioconvertedsongs, startIndex: widget.index!));

  //   //await widget.audioPlayer
  //   //    .open(audioconvertedsongs[widget.index!], showNotification: true);
  //   widget.audioPlayer.play();
  // }

  // Future<void> songPlayNext() async {
  // await widget.audioPlayer
  //  .open(widget.songdetailsshow!, showNotification: true);

  //  count++;
  //  widget.audioPlayer.play();
  // }
  final favoritebox = Boxes.getInstance();
  int counting = 0;
  @override
  Widget build(BuildContext context) {
    final double screenhight = MediaQuery.of(context).size.height;
    final double screenwidth = MediaQuery.of(context).size.width;
    favoriteController.favoritesongs!.value = favoritebox.get('favorite')!;
    return Scaffold(
      backgroundColor: const Color(0xFF2F3E46),
      body: audioplayer.builderCurrent(builder: (context, Playing? playing) {
        final curentsongdetail = find(dbSongController.audioconvertedsongs,
            playing!.audio.assetAudioPath);

        final nowplayingsongfavorite = dbSongController.dbsongs.firstWhere(
            (element) =>
                element.id.toString() == curentsongdetail.metas.id.toString());

        if (playing.audio.assetAudioPath.isEmpty) {
          return const Center(
            child: Text('empty'),
          );
        } else {
          return SafeArea(
              child: Column(
            children: [
              SizedBox(
                height: screenhight / 35,
              ),

              ListTile(
                leading: GestureDetector(
                  onTap: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const MainScreen())),
                      (route) => false),
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(.1),
                    child: const Center(
                        child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 18,
                    )),
                  ),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    showBottomSheet(
                        backgroundColor: const Color.fromARGB(255, 53, 78, 71),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        context: context,
                        builder: (ctx) {
                          return SizedBox(
                            height: screenhight / 4,
                            child: ShowbottomList(
                                songaddplaylist: curentsongdetail),
                          );
                        });
                  },
                  child: const Icon(
                    Icons.queue_music,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: screenhight / 3,
                width: screenwidth / 2,
                child: QueryArtworkWidget(
                    nullArtworkWidget: Container(
                        height: screenhight / 3,
                        width: screenwidth / 2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    'assets/best-rap-songs-1583527287.png')))),
                    id: int.parse(curentsongdetail.metas.id.toString()),
                    type: ArtworkType.AUDIO),
              ),
              SizedBox(
                height: screenhight / 20,
              ),
              // widget.songdetailsshow == null
              //     ?
              //
              Container(
                width: screenwidth / 1.5,
                height: screenhight / 30,
                child: Marquee(
                  velocity: 20,
                  text: curentsongdetail.metas.title!,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              SizedBox(
                height: screenhight / 60,
              ),
              //  Text(
              //     widget.songdetailsshow!.metas.title!,
              //     style: TextStyle(fontSize: 16, color: Colors.white),
              //   ),
              //widget.songdetailsshow == null

              //   ?

              curentsongdetail.metas.artist == '<unknown>'
                  ? const Text(
                      'unknown artist',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    )
                  : Text(
                      curentsongdetail.metas.artist!,
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),

              //  Text(
              //     widget.songdetailsshow!.metas.artist!,
              //     style: TextStyle(color: Colors.white),
              //   ),
              // Container(
              //   margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(c.inSeconds.toString().split(".")[0]),
              //       Text(duration.inSeconds.toString().split(".")[0]),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: screenhight / 50,
              ),
              Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: widget.audioPlayer.builderRealtimePlayingInfos(
                      builder: (context, infos) {
                    Duration currentposition = infos.currentPosition;
                    Duration totalduration = infos.duration;
                    return ProgressBar(
                        timeLabelTextStyle:
                            const TextStyle(color: Colors.white, fontSize: 16),
                        thumbColor: const Color.fromARGB(255, 64, 82, 68),
                        baseBarColor: const Color.fromARGB(255, 127, 126, 126),
                        progressBarColor:
                            const Color.fromARGB(255, 86, 110, 91),
                        bufferedBarColor:
                            const Color.fromARGB(255, 123, 157, 131),
                        thumbRadius: 8,
                        barHeight: 3,
                        progress: currentposition,
                        total: totalduration,
                        onSeek: (to) {
                          audioplayer.seek(to);
                        });
                  })),
              SizedBox(
                height: screenhight / 25,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            audioplayer.toggleShuffle();
                          });
                        },
                        child: audioplayer.isShuffling.value
                            ? Icon(
                                Icons.shuffle_on_rounded,
                                color: Colors.grey.shade200,
                              )
                            : Icon(
                                Icons.shuffle,
                                color: Colors.grey.shade200,
                              )),

                    favoriteController.favoritesongs!
                            .where(
                              (element) =>
                                  element.id.toString() ==
                                  nowplayingsongfavorite.id!.toString(),
                            )
                            .isEmpty
                        ? IconButton(
                            onPressed: () async {
                              favoriteController.favoritesongs
                                  ?.add(nowplayingsongfavorite);
                              await favoritebox.put('favorite',
                                  favoriteController.favoritesongs!);
                              setState(() {
                                favoriteController.favoritesongs!.value =
                                    favoritebox.get('favorite')!;
                              });
                            },
                            icon: const Icon(
                              Icons.favorite,
                            ))
                        : IconButton(
                            onPressed: () async {
                              favoriteController.favoritesongs?.removeWhere(
                                (element) =>
                                    element.id.toString() ==
                                    nowplayingsongfavorite.id.toString(),
                              );
                              await favoritebox.put('favorite',
                                  favoriteController.favoritesongs!);
                              setState(() {
                                favoriteController.favoritesongs!.value =
                                    favoritebox.get('favorite')!;
                              });
                            },
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.white,
                            )),
                    // GestureDetector(
                    //     onTap: () => setState(() {
                    //           if (isfavorite == true) {
                    //             isfavorite = false;
                    //           } else {
                    //             isfavorite = true;
                    //           }
                    //         }),
                    //     child: isfavorite
                    //         ? Icon(Icons.favorite)
                    //         : Icon(
                    //             Icons.favorite,
                    //             color: Colors.white,
                    //           )),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            if (counting % 2 == 0) {
                              audioplayer.setLoopMode(LoopMode.single);
                              counting++;
                            } else {
                              audioplayer.setLoopMode(LoopMode.none);
                              counting++;
                            }
                          });
                        },
                        child: counting % 2 == 0
                            ? Icon(
                                Icons.repeat,
                                color: Colors.grey.shade200,
                              )
                            : Icon(
                                Icons.repeat_on_rounded,
                                color: Colors.grey.shade200,
                              )),
                  ],
                ),
              ),
              SizedBox(
                height: screenhight / 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onDoubleTap: () async {
                      await audioplayer.seekBy(const Duration(seconds: -5));
                    },
                    onTap: () async {
                      dbSongController.recent1 =
                          dbSongController.box.get('recent1')!;
                      final isinrecent = dbSongController.recent1
                          .where(((element) =>
                              element.id.toString() ==
                              curentsongdetail.metas.id.toString()))
                          .toList();
                      if (isinrecent.isEmpty) {
                        final songmodelsong = dbSongController.dbsongs
                            .firstWhere((element) =>
                                element.id.toString() ==
                                curentsongdetail.metas.id.toString());

                        dbSongController.recent1.add(songmodelsong);
                        dbSongController.recent1 =
                            dbSongController.recent1.reversed.toList();
                        if (dbSongController.recent1.length >= 5) {
                          dbSongController.recent1.removeLast();
                        }
                        dbSongController.recent1 =
                            dbSongController.recent1.reversed.toList();
                        await dbSongController.box
                            .put('recent1', dbSongController.recent1);
                        // recent = box.get('recent1')!.toList();
                      }
                      audioplayer.previous();
                      // count2++;
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: ((context) => widget.index! > 0
                      //             ? DetailSong(
                      //                 songdetailsshow:
                      //                     audioconvertedsongs[widget.index! - 1],
                      //                 index: widget.index! - 1,
                      //                 audioPlayer: widget.audioPlayer)
                      //             : MainScreen())));
                    },
                    child: Icon(
                      Icons.skip_previous,
                      size: 30,
                    ),
                  ),
                  SizedBox(
                    width: screenwidth / 30,
                  ),

                  PlayerBuilder.isPlaying(
                      player: audioplayer,
                      builder: (context, isPlaying) {
                        return GestureDetector(
                          onTap: () async {
                            await audioplayer.playOrPause();
                          },
                          child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey.shade200,
                              child: isPlaying
                                  ? const Icon(
                                      size: 40,
                                      Icons.pause,
                                      color: Colors.black,
                                    )
                                  : const Icon(
                                      Icons.play_arrow,
                                      size: 40,
                                      color: Colors.black,
                                    )),
                        );
                      }),

                  // child: GestureDetector(
                  //   onTap: () => setState(() {
                  //     if (isplay == true) {
                  //       audioplayer.pause();
                  //       isplay = false;
                  //     } else {
                  //       audioplayer.play();
                  //       isplay = true;
                  //     }
                  //   }),
                  //   child: CircleAvatar(
                  //       radius: 30,
                  //       backgroundColor: Colors.grey.shade200,
                  //       child: isplay
                  //           ? Icon(
                  //               size: 40,
                  //               Icons.pause,
                  //               color: Colors.black,
                  //             )
                  //           : Icon(
                  //               Icons.play_arrow,
                  //               size: 40,
                  //               color: Colors.black,
                  //             )),
                  // ),

                  SizedBox(
                    width: screenwidth / 30,
                  ),
                  GestureDetector(
                      onDoubleTap: () async {
                        await audioplayer.seekBy(Duration(seconds: 5));
                      },
                      onTap: () async {
                        dbSongController.recent1 =
                            dbSongController.box.get('recent1')!;
                        final isinrecent = dbSongController.recent1
                            .where(((element) =>
                                element.id.toString() ==
                                curentsongdetail.metas.id.toString()))
                            .toList();
                        if (isinrecent.isEmpty) {
                          final songmodelsong = dbSongController.dbsongs
                              .firstWhere((element) =>
                                  element.id.toString() ==
                                  curentsongdetail.metas.id.toString());

                          dbSongController.recent1.add(songmodelsong);
                          dbSongController.recent1 =
                              dbSongController.recent1.reversed.toList();
                          if (dbSongController.recent1.length >= 5) {
                            dbSongController.recent1.removeLast();
                          }
                          dbSongController.recent1 =
                              dbSongController.recent1.reversed.toList();
                          await dbSongController.box
                              .put('recent1', dbSongController.recent1);
                          // recent = box.get('recent1')!.toList();
                        }
                        audioplayer.next();
                        // count1++;
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: ((context) => widget.index! <
                        //                 audioconvertedsongs.length - 1
                        //             ? DetailSong(
                        //                 songdetailsshow:
                        //                     audioconvertedsongs[widget.index! + 1],
                        //                 index: widget.index! + 1,
                        //                 audioPlayer: widget.audioPlayer)
                        //             : MainScreen())));
                      },
                      child: const Icon(Icons.skip_next, size: 30)),
                ],
              ),
            ],
          ));
        }
      }),
    );
  }

  @override
  void dispose() {
    count1 = 1;
    count2 = 1;

    // TODO: implement dispose
    super.dispose();
  }
}
