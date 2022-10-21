import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import 'package:music_pro_1/db/audioplay.dart';
import 'package:music_pro_1/db/boxinstance.dart';
import 'package:music_pro_1/db/dbfetching.dart';

import 'package:music_pro_1/funtion.dart';
import 'package:music_pro_1/presentation/home/mainscreen.dart';
import 'package:music_pro_1/presentation/commonwidgets/miniplayer.dart';
import 'package:music_pro_1/presentation/commonwidgets/snackbars.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Favorites extends StatefulWidget {
  const Favorites({
    Key? key,
  }) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

List<Audio> playlikedsong = [];
final favoritebox = Boxes.getInstance();

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
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
                    height: screenhight / 3.5,
                    width: screenwidth / 2,
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
                height: screenhight / 25,
              ),

              //favoritesongs == null || favoritesongs == []
              favoritesongs!.isEmpty
                  ? Expanded(
                      child: const Center(
                          child: Text(
                      'No Favorite',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )))
                  : Expanded(
                      flex: 8,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              recent1 = box.get('recent1')!;
                              final isinrecent = recent1
                                  .where(((element) =>
                                      element.id.toString() ==
                                      favoritesongs![index].id.toString()))
                                  .toList();
                              if (isinrecent.isEmpty) {
                                recent1.add(favoritesongs![index]);
                                recent1 = recent1.reversed.toList();
                                if (recent1.length >= 5) {
                                  recent1.removeLast();
                                }
                                recent1 = recent1.reversed.toList();
                                await box.put('recent1', recent1);
                                // recent = box.get('recent1')!.toList();
                              }

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
                              for (var element in favoritesongs!) {
                                playlikedsong
                                    .add(Audio.file(element.uri.toString(),
                                        metas: Metas(
                                          title: element.title,
                                          id: element.id.toString(),
                                          artist: element.artist,
                                          album: element.duration.toString(),
                                        )));
                              }

                              await AssetAudioPlay(
                                      audioconvertedsongs: playlikedsong,
                                      index: index)
                                  .songPlayNow(playlikedsong, index);

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: ((context) => DetailSong(
                              //               audioPlayer: audioplayer,
                              //               index: index,
                              //             ))));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, top: 2, right: 12, bottom: 2),
                              child: Card(
                                color: Colors.white.withOpacity(.1),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(6),
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
                                            id: favoritesongs![index].id
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
                                              favoritesongs![index].title!,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Container(
                                            width: screenwidth / 3,
                                            margin: const EdgeInsets.only(
                                                right: 13),
                                            child: favoritesongs![index]
                                                        .artist ==
                                                    '<unknown>'
                                                ? const Text(
                                                    'unknown artist',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white),
                                                  )
                                                : Text(
                                                    favoritesongs![index]
                                                        .artist!,
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

                                  trailing: GestureDetector(
                                    onTap: () async {
                                      favoritesongs!.removeAt(index);

                                      await favoritebox.put(
                                          'favorite', favoritesongs!);

                                      setState(() {
                                        favoritesongs =
                                            favoritebox.get('favorite');
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                              SnackBar1().removefavorite);
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
                        itemCount: favoritesongs!.length,
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

  // @override
  // void didChangeDependencies() {
  //   favoritesongs = favoritebox.get('favorite');
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  // }
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
