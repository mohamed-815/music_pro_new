import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:music_pro_1/models/db/allsongstoringclass.dart';
import 'package:music_pro_1/models/db/boxinstance.dart';
import 'package:music_pro_1/models/db/audioplay.dart';

import 'package:music_pro_1/controller/funtion.dart';
import 'package:music_pro_1/main.dart';
import 'package:music_pro_1/controller/favoritecontroller/favoritecontroller.dart';
import 'package:music_pro_1/view/home/mainscreen.dart';
import 'package:music_pro_1/view/detailsongs/miniplayer.dart';
import 'package:music_pro_1/view/commonwidgets/snackbars.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

//List<Audio> playlikedsong = [];
FavoriteController favoriteController = Get.put(FavoriteController());

class Favorites extends StatelessWidget {
  const Favorites({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final double screenhight = MediaQuery.of(context).size.height;
    // final double screenwidth = MediaQuery.of(context).size.width;
    return ScaffoldGradientBackground(
      gradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Color(0xFF52796F), Color.fromARGB(255, 27, 40, 37)],
      ),
      body: SafeArea(
          child: Stack(
        children: [
          GetBuilder<FavoriteController>(
              init: FavoriteController(),
              builder: (val1) {
                return Column(
                  children: [
                    ListTile(
                      leading: Container(
                        child: GestureDetector(
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
                              size: 19,
                            )),
                          ),
                        ),
                      ),
                      title: Center(
                        child: GradientText(
                          colors: const [
                            Color.fromARGB(255, 125, 184, 170),
                            Color.fromARGB(255, 116, 91, 91)
                          ],
                          'Favorite          ',
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),

                    // SizedBox(
                    //   height: screenhight / 100,
                    // ),
                    // SizedBox(
                    //   height: screenhight / 100,
                    // ),
                    Center(
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          height: val1.mediaQueryheight(context) / 3.5,
                          width: val1.mediaQuerywidth(context) / 2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/Microphone-background-sound-waves-energy-Music.webp'))),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: val1.mediaQueryheight(context) / 25,
                    ),

                    //favoritesongs == null || favoritesongs == []
                    val1.favoritesongs.isEmpty
                        ? Expanded(
                            child: const Center(
                                child: Text(
                            'No Favorite',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )))
                        : Expanded(
                            flex: 8,
                            child: GetBuilder<FavoriteController>(
                                init: FavoriteController(),
                                builder: (val1) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () async {
                                          // dbSongController.recent1 =
                                          //     dbSongController.box.get('recent1')!;
                                          // final isinrecent = dbSongController.recent1
                                          //     .where(((element) =>
                                          //         element.id.toString() ==
                                          //         favoriteController
                                          //             .favoritesongs![index].id
                                          //             .toString()))
                                          //     .toList();
                                          // if (isinrecent.isEmpty) {
                                          //   dbSongController.recent1.add(
                                          //       favoriteController
                                          //           .favoritesongs![index]);
                                          //   dbSongController.recent1 = dbSongController
                                          //       .recent1.reversed
                                          //       .toList();
                                          //   if (dbSongController.recent1.length >= 5) {
                                          //     dbSongController.recent1.removeLast();
                                          //   }
                                          //   dbSongController.recent1 = dbSongController
                                          //       .recent1.reversed
                                          //       .toList();
                                          //   await dbSongController.box.put(
                                          //       'recent1', dbSongController.recent1);
                                          //   // recent = box.get('recent1')!.toList();
                                          // }
                                          val1.addingTofavorite(index);

                                          showBottomSheet(
                                            backgroundColor:
                                                const Color(0xFF52796F),
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20))),
                                            context: context,
                                            builder: (ctx) => SizedBox(
                                                height: val1.mediaQueryheight(
                                                        context) /
                                                    9,
                                                child: MiniPlayer()),
                                          );

                                          val1.favoriteSongplay(index);

                                          // for (var element
                                          //     in favoriteController.favoritesongs!) {
                                          //   playlikedsong
                                          //       .add(Audio.file(element.uri.toString(),
                                          //           metas: Metas(
                                          //             title: element.title,
                                          //             id: element.id.toString(),
                                          //             artist: element.artist,
                                          //             album:
                                          //                 element.duration.toString(),
                                          //           )));
                                          // }

                                          // await AssetAudioPlay(
                                          //         audioconvertedsongs: playlikedsong,
                                          //         index: index)
                                          //     .songPlayNow(playlikedsong, index);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 12,
                                              top: 2,
                                              right: 12,
                                              bottom: 2),
                                          child: Card(
                                            color: Colors.white.withOpacity(.1),
                                            child: ListTile(
                                              contentPadding:
                                                  const EdgeInsets.all(6),
                                              leading: Container(
                                                // padding: EdgeInsets.only(
                                                //     top: screenwidth / 50, bottom: screenwidth / 50),
                                                width: 50,

                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    child: QueryArtworkWidget(
                                                        nullArtworkWidget:
                                                            Image.asset(
                                                          "assets/best-rap-songs-1583527287.png",
                                                        ),
                                                        id: val1
                                                            .favoritesongs[
                                                                index]
                                                            .id
                                                        // int.parse(audioconvertedsongs[index]
                                                        //     .metas
                                                        //     .id
                                                        //     .toString())
                                                        ,
                                                        type:
                                                            ArtworkType.AUDIO)),
                                              ),
                                              title: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width:
                                                            val1.mediaQuerywidth(
                                                                    context) /
                                                                3,
                                                        margin: const EdgeInsets
                                                            .only(right: 13),
                                                        child: Text(
                                                          val1
                                                              .favoritesongs[
                                                                  index]
                                                              .title!,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                            val1.mediaQuerywidth(
                                                                    context) /
                                                                3,
                                                        margin: const EdgeInsets
                                                            .only(right: 13),
                                                        child: val1
                                                                    .favoritesongs[
                                                                        index]
                                                                    .artist ==
                                                                '<unknown>'
                                                            ? const Text(
                                                                'unknown artist',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .white),
                                                              )
                                                            : Text(
                                                                val1
                                                                    .favoritesongs[
                                                                        index]
                                                                    .artist!,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),

                                              trailing: GestureDetector(
                                                onTap: () async {
                                                  // favoriteController.favoritesongs!
                                                  //     .removeAt(index);

                                                  // await favoritebox.put(
                                                  //     'favorite',
                                                  //     favoriteController
                                                  //         .favoritesongs!);

                                                  // setState(() {
                                                  //   favoriteController.favoritesongs =
                                                  //       favoritebox.get('favorite');
                                                  // });
                                                  // ScaffoldMessenger.of(context)
                                                  //     .showSnackBar(
                                                  //       SnackBar1().removefavorite);

                                                  val1.removeFromfave(index);

                                                  // ScaffoldMessenger.of(context)
                                                  //     .showSnackBar(
                                                  //         SnackBar1().removefavorite);
                                                },
                                                child: Icon(
                                                  Icons.favorite,
                                                  color: Colors.white,
                                                ),
                                              ),
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
                                    itemCount: val1.favoritesongs.length,
                                  );
                                }),
                          )

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
                );
              }),
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

// Future<void> Dialogbox2(context) async {
//   showDialog(
//       context: context,
//       builder: (ctx1) {
//         return Container(
//           width: 40,
//           child: AlertDialog(
//             actions: [
//               TextButton(
//                   onPressed: () async {
//                     Navigator.of(ctx1).pop();
//                   },
//                   child: Center(
//                     child: Text(
//                       'Remove',
//                       style: TextStyle(color: Color.fromARGB(255, 50, 74, 68)),
//                     ),
//                   )),
//               SizedBox(
//                 width: 13,
//               )
//             ],
//           ),
//         );
//       });
// }
