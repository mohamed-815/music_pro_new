import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import 'package:music_pro_1/models/db/allsongstoringclass.dart';
import 'package:music_pro_1/models/db/boxinstance.dart';
import 'package:music_pro_1/models/db/audioplay.dart';
import 'package:music_pro_1/controller/funtion.dart';
import 'package:music_pro_1/main.dart';
import 'package:music_pro_1/view/home/mainscreen.dart';
import 'package:music_pro_1/view/detailsongs/miniplayer.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Recent1 extends StatelessWidget {
  Recent1({
    Key? key,
  }) : super(key: key);

  List<Audio> rcentaudio = [];

  @override
  Widget build(BuildContext context) {
    dbSongController.recent = dbSongController.box.get('recent1')!;
    final double screenhight = MediaQuery.of(context).size.height;
    final double screenwidth = MediaQuery.of(context).size.width;
    return ScaffoldGradientBackground(
      gradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Color(0xFF52796F), Color.fromARGB(255, 27, 40, 37)],
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Column(
            children: [
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
              ),
              Center(
                child: GradientText(
                  colors: const [
                    Color.fromARGB(255, 125, 184, 170),
                    Color.fromARGB(255, 116, 91, 91)
                  ],
                  'Recents',
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: screenhight / 40,
              ),
              Center(
                child: Card(
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9)),
                  child: Container(
                    height: screenhight / 3.5,
                    width: screenwidth / 2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                'assets/female-rock-singers-of-the-2000s-and-2010s.jpg'))),
                  ),
                ),
              ),
              SizedBox(
                height: screenhight / 25,
              ),
              dbSongController.recent.isEmpty
                  ? Expanded(
                      child: Container(
                        child: GradientText(
                          colors: const [
                            Color.fromARGB(255, 125, 184, 170),
                            Color.fromARGB(255, 116, 91, 91)
                          ],
                          'No Recents',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  : Expanded(
                      flex: 8,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              showBottomSheet(
                                backgroundColor: const Color(0xFF52796F),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20))),
                                context: context,
                                builder: (ctx) => SizedBox(
                                    height: screenhight / 9,
                                    child: MiniPlayer()),
                              );
                              for (var element in dbSongController.recent) {
                                rcentaudio
                                    .add(Audio.file(element.uri.toString(),
                                        metas: Metas(
                                          title: element.title,
                                          id: element.id.toString(),
                                          artist: element.artist,
                                          album: element.duration.toString(),
                                        )));
                              }

                              await AssetAudioPlay(
                                      audioconvertedsongs: rcentaudio,
                                      index: index)
                                  .songPlayNow(rcentaudio, index);

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: ((context) => DetailSong(
                              //               audioPlayer: audioplayer,
                              //               index: index,
                              //             ))));
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(12, 2, 12, 2),
                              child: Card(
                                color: Colors.white.withOpacity(.1),
                                child: ListTile(
                                  contentPadding: EdgeInsets.all(6),
                                  leading: Container(
                                    // padding: EdgeInsets.only(
                                    //     top: screenwidth / 50, bottom: screenwidth / 50),
                                    width: 50,

                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: QueryArtworkWidget(
                                            nullArtworkWidget: Image.asset(
                                              "assets/best-rap-songs-1583527287.png",
                                            ),
                                            id: dbSongController
                                                .recent[index].id
                                            // int.parse(audioconvertedsongs[index]
                                            //     .metas
                                            //     .id
                                            //     .toString())
                                            ,
                                            type: ArtworkType.AUDIO)),
                                  ),
                                  title: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: screenwidth / 3,
                                            margin: const EdgeInsets.only(
                                                right: 13),
                                            child: Text(
                                              dbSongController
                                                  .recent[index].title!,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Container(
                                            width: screenwidth / 3,
                                            margin: const EdgeInsets.only(
                                                right: 13),
                                            child: dbSongController
                                                        .recent[index].artist ==
                                                    '<unknown>'
                                                ? const Text(
                                                    'unknown artist',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white),
                                                  )
                                                : Text(
                                                    dbSongController
                                                        .recent[index].artist!,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white),
                                                  ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),

                                  // trailing: GestureDetector(
                                  //   onTap: () async {
                                  //     favoritesongs!.removeAt(index);

                                  //     await favoritebox.put('favorite', favoritesongs!);

                                  //     setState(() {
                                  //       favoritesongs = favoritebox.get('favorite');
                                  //     });
                                  //   },
                                  //   child: Icon(
                                  //     Icons.favorite,
                                  //     color: Colors.white,
                                  //   ),
                                  // ),
                                  // trailing: GestureDetector(
                                  //   onTap: () => Dialogbox2(context),
                                  //   child: Row(
                                  //     mainAxisSize: MainAxisSize.min,
                                  //     children: [
                                  //       Icon(
                                  //         Icons.fiber_manual_record,
                                  //         size: 10,
                                  //       ),
                                  //       Icon(
                                  //         Icons.fiber_manual_record,
                                  //         size: 10,
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: dbSongController.recent.length,
                      )),
              // Expanded(
              //   child: ListView.builder(
              //     itemBuilder: (context, index) {
              //       return GestureDetector(
              //         child: ListTile(
              //           onTap: () => Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                   builder: ((context) => DetailSong(
              //                         songdetailsshow: songarrey1[index],
              //                         index: index,
              //                         audioPlayer: audioplayer,
              //                       )))),
              //           leading: SizedBox(
              //             width: 45,
              //             child: ClipRRect(
              //                 borderRadius: BorderRadius.circular(8.0),
              //                 child: Image.asset(
              //                     "assets/best-rap-songs-1583527287.png")),
              //           ),
              //           title: Row(
              //             mainAxisSize: MainAxisSize.min,
              //             children: [
              //               Column(
              //                 mainAxisSize: MainAxisSize.min,
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Text(
              //                     Songdetailarrey[index].title!,
              //                     style: TextStyle(color: Colors.white),
              //                   ),
              //                   Text(
              //                     Songdetailarrey[index].titlesmall!,
              //                     style: TextStyle(
              //                         color: Colors.grey.shade500,
              //                         fontFamily: 'Montserrat',
              //                         fontSize: 13),
              //                   )
              //                 ],
              //               ),
              //             ],
              //           ),
              //           trailing: GestureDetector(
              //             onTap: () => Dialogbox2(context),
              //             child: Row(
              //               mainAxisSize: MainAxisSize.min,
              //               children: [
              //                 Icon(
              //                   Icons.fiber_manual_record,
              //                   size: 10,
              //                 ),
              //                 Icon(
              //                   Icons.fiber_manual_record,
              //                   size: 10,
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       );
              //     },
              //     itemCount: songarrey1.length,
              //   ),
              // ),
            ],
          ),
          Positioned(
            bottom: 0,
            child: audioplayer.builderCurrent(
                builder: ((context, Playing? playing) =>
                    //  showBottomSheet(
                    // backgroundColor: Color.fromARGB(255, 55, 72, 67),
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.only(
                    //         topLeft: Radius.circular(20),
                    //         topRight: Radius.circular(20))),
                    // context: context,
                    // builder: (ctx) =>
                    //     SizedBox(height: screenhight / 9, child: MiniPlayer()),
                    // enableDrag: true)

                    PlayerBuilder.isPlaying(
                        player: audioplayer,
                        builder: (context, isPlaying) {
                          return isPlaying ? MiniPlayer() : Container();
                        }))),
          ),
        ],
      )),
    );
  }
}

Future<void> Dialogbox2(context) async {
  showDialog(
      context: context,
      builder: (ctx1) {
        return AlertDialog(
          actions: [
            TextButton(
                onPressed: () async {
                  Navigator.of(ctx1).pop();
                },
                child: const Text(
                  'Remove',
                  style: TextStyle(color: Color.fromARGB(255, 50, 74, 68)),
                )),
            const SizedBox(
              width: 13,
            )
          ],
        );
      });
}
