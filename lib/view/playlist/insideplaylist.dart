import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/state_manager.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:music_pro_1/controller/dbsongcontroller/dbsongcontroller.dart';
import 'package:music_pro_1/main.dart';
import 'package:music_pro_1/view/detailsongs/miniplayer.dart';
import 'package:music_pro_1/view/home/mainscreencontroller.dart';
import 'package:music_pro_1/controller/playlistcontroller/playlistcontroller.dart';
import 'package:music_pro_1/view/playlist/widgets/allsongforplaylist.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

// @override
// void initState() {
//   //final playlistsongs1 = playlistbox.get(widget.playlistname)!;
//   // TODO: implement initState
//   super.initState();
//   // print(playlistsongs1);
// }

class InsidePlaylist extends StatelessWidget {
  String playlistname;
  InsidePlaylist({required this.playlistname, super.key});

  // List<dynamic> playlistsongs1 = [];
// List<Audio> playlistaudio = [];
//List<Audio> playlistaudio = [];

  @override
  Widget build(BuildContext context) {
    final screenhight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;

    return ScaffoldGradientBackground(
      gradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color.fromARGB(255, 108, 158, 145),
          Color.fromARGB(255, 54, 70, 67)
        ],
      ),
      body: SafeArea(
        child: Column(children: [
          ListTile(
            leading: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
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
          SizedBox(
            height: screenhight / 50,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
              color: Colors.white.withOpacity(.1),
              child: ListTile(
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: screenwidth / 20,
                    ),
                    GradientText(
                      colors: const [
                        Color.fromARGB(255, 212, 231, 227),
                        Color.fromARGB(255, 225, 213, 213)
                      ],
                      playlistname.toString(),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                trailing: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          backgroundColor:
                              const Color.fromARGB(255, 63, 80, 66),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          context: context,
                          builder: (ctx) {
                            return AllSongs3(
                              playlistname1: playlistname,
                            );
                          });
                      // showBottomSheet(
                      //     context: context,
                      //     builder: (ctx) {
                      //       return const SearchingList();
                      //     });
                    },
                    child: Card(
                        color: Colors.white.withOpacity(.1),
                        child: Container(
                            width: screenwidth / 10,
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 30,
                              shadows: [],
                            )))),
              ),
            ),
          ),
          SizedBox(
            height: screenhight / 50,
          ),
          ValueListenableBuilder(
            valueListenable: playlistbox.listenable(),
            builder: (BuildContext context, Boxes, _) {
              dbSongController.playlistsongs1 = playlistbox.get(playlistname)!;

              return Expanded(
                  flex: 8,
                  child: GetBuilder<DbSongController>(
                      init: DbSongController(),
                      builder: (dbcontroller) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GetBuilder<PlayListController>(
                                init: PlayListController(),
                                builder: (playlistcont) {
                                  return GestureDetector(
                                    onTap: () async {
                                      playlistcont
                                          .adingToRecentFromPlayList(index);

                                      // dbSongController.recent1 =
                                      //     dbSongController.box.get('recent1')!;
                                      // final isinrecent = dbSongController.recent1
                                      //     .where(((element) =>
                                      //         element.id.toString() ==
                                      //         dbSongController.playlistsongs1[index].id
                                      //             .toString()))
                                      //     .toList();
                                      // if (isinrecent.isEmpty) {
                                      //   dbSongController.recent1
                                      //       .add(dbSongController.playlistsongs1[index]);
                                      //   dbSongController.recent1 =
                                      //       dbSongController.recent1.reversed.toList();
                                      //   if (dbSongController.recent1.length >= 5) {
                                      //     dbSongController.recent1.removeLast();
                                      //   }
                                      //   dbSongController.recent1 =
                                      //       dbSongController.recent1.reversed.toList();
                                      //   await dbSongController.box
                                      //       .put('recent1', dbSongController.recent1);
                                      //   // recent = box.get('recent1')!.toList();
                                      // }

                                      showBottomSheet(
                                        backgroundColor:
                                            const Color(0xFF52796F),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20))),
                                        context: context,
                                        builder: (ctx) => SizedBox(
                                            height: screenhight / 9,
                                            child: MiniPlayer()),
                                      );
                                      playlistcont.playListSongPlay(index);
                                      // for (var element
                                      //     in dbSongController.playlistsongs1) {
                                      //   playlistaudio
                                      //       .add(Audio.file(element.uri.toString(),
                                      //           metas: Metas(
                                      //             title: element.title,
                                      //             id: element.id.toString(),
                                      //             artist: element.artist,
                                      //             album: element.duration.toString(),
                                      //           )));
                                      // }

                                      // await AssetAudioPlay(
                                      //         audioconvertedsongs: playlistaudio,
                                      //         index: index)
                                      //     .songPlayNow(playlistaudio, index);

                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: ((context) => DetailSong(
                                      //               audioPlayer: audioplayer,
                                      //               index: index,
                                      //             ))));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 5, 15, 5),
                                      child: Card(
                                        color: Colors.white.withOpacity(.1),
                                        child: GetBuilder<DbSongController>(
                                            init: DbSongController(),
                                            builder: (dbc) {
                                              return ListTile(
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
                                                          id: dbc
                                                              .playlistsongs1[
                                                                  index]
                                                              .id,
                                                          type: ArtworkType
                                                              .AUDIO)),
                                                ),
                                                title: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
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
                                                              screenwidth / 3,
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 13),
                                                          child: Text(
                                                            dbc
                                                                .playlistsongs1[
                                                                    index]
                                                                .title!,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                        ),
                                                        Container(
                                                          width:
                                                              screenwidth / 3,
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 13),
                                                          child: dbc
                                                                      .playlistsongs1[
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
                                                                  dbc
                                                                      .playlistsongs1[
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
                                                    dbc.playlistsongs1
                                                        .removeAt(index);

                                                    await playlistbox.put(
                                                        playlistname,
                                                        dbSongController
                                                            .playlistsongs1);
                                                    // setState(() {});
                                                  },
                                                  child: Icon(
                                                    Icons.delete,
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
                                              );
                                            }),
                                      ),
                                    ),
                                  );
                                });
                          },
                          itemCount: dbcontroller.playlistsongs1.length,
                        );
                      }));
            },
          ),
        ]),
      ),
    );
  }
}



// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_application_1stproject/db/allsongstoringclass.dart';
// import 'package:flutter_application_1stproject/db/audioplay.dart';
// import 'package:flutter_application_1stproject/db/boxinstance.dart';
// import 'package:flutter_application_1stproject/db/dbfetching.dart';
// import 'package:flutter_application_1stproject/db/dbfetching.dart';
// import 'package:flutter_application_1stproject/mainscreen.dart';
// import 'package:flutter_application_1stproject/miniplayer.dart';
// import 'package:flutter_application_1stproject/play%20list/favorite.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// class InsidePlaylist extends StatefulWidget {
//   String playlistname;
//   InsidePlaylist({required this.playlistname, super.key});

//   @override
//   State<InsidePlaylist> createState() => _InsidePlaylistState();
// }

// List<dynamic> playlistsongs1 = [];
// List<Audio> playlistaudio = [];

// class _InsidePlaylistState extends State<InsidePlaylist> {
//   @override
//   void initState() {
//     playlistsongs1 = playlistbox.get(widget.playlistname.toString())!;
//     // TODO: implement initState
//     super.initState();
//     print(playlistsongs1);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenhight = MediaQuery.of(context).size.height;
//     final screenwidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       body: Column(children: [
//         Center(child: Text(widget.playlistname.toString())),
//         ValueListenableBuilder(
//           valueListenable: playlistbox.listenable(),
//           builder: (BuildContext context, Boxes, _) {
//             final playlistsongs1 = playlistbox.get(widget.playlistname)!;
//             return Expanded(
//                 flex: 8,
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     return GestureDetector(
//                       onTap: () {
//                         showBottomSheet(
//                           backgroundColor: Color(0xFF52796F),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(20),
//                                   topRight: Radius.circular(20))),
//                           context: context,
//                           builder: (ctx) => SizedBox(
//                               height: screenhight / 9, child: MiniPlayer()),
//                         );
//                         for (var element in playlistsongs1) {
//                           playlistaudio.add(Audio.file(element.uri.toString(),
//                               metas: Metas(
//                                 title: element.title,
//                                 id: element.id.toString(),
//                                 artist: element.artist,
//                                 album: element.duration.toString(),
//                               )));
//                         }

//                         AssetAudioPlay(
//                                 audioconvertedsongs: playlistaudio,
//                                 index: index)
//                             .songPlayNow(playlistaudio, index);

//                         // Navigator.push(
//                         //     context,
//                         //     MaterialPageRoute(
//                         //         builder: ((context) => DetailSong(
//                         //               audioPlayer: audioplayer,
//                         //               index: index,
//                         //             ))));
//                       },
//                       child: ListTile(
//                         leading: Container(
//                           // padding: EdgeInsets.only(
//                           //     top: screenwidth / 50, bottom: screenwidth / 50),
//                           width: 50,

//                           child: ClipRRect(
//                               borderRadius: BorderRadius.circular(50),
//                               child: QueryArtworkWidget(
//                                   nullArtworkWidget: Image.asset(
//                                     "assets/best-rap-songs-1583527287.png",
//                                   ),
//                                   id: playlistsongs1[index].id,
//                                   type: ArtworkType.AUDIO)),
//                         ),
//                         title: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Column(
//                               mainAxisSize: MainAxisSize.min,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   width: 150,
//                                   margin: EdgeInsets.only(right: 13),
//                                   child: Text(
//                                     playlistsongs1[index].title!,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ),
//                                 Container(
//                                   margin: EdgeInsets.only(right: 13),
//                                   child: playlistsongs1[index].artist ==
//                                           '<unknown>'
//                                       ? Text(
//                                           'unknown artist',
//                                           style: TextStyle(
//                                               fontSize: 12,
//                                               color: Colors.white),
//                                         )
//                                       : Text(
//                                           playlistsongs1[index].artist!,
//                                           style: TextStyle(
//                                               fontSize: 12,
//                                               color: Colors.white),
//                                         ),
//                                 )
//                               ],
//                             ),
//                           ],
//                         ),

//                         trailing: GestureDetector(
//                           //
//                           //onTap:
//                           // () async {
//                           //   setState(() {
//                           //     favoritesongs!.removeAt(index);

//                           //     favoritebox.put('favorite', favoritesongs!);
//                           //   });
//                           // },
//                           child: Icon(
//                             Icons.delete,
//                             color: Colors.white,
//                           ),
//                         ),
//                         // trailing: GestureDetector(
//                         //   onTap: () => Dialogbox2(context),
//                         //   child: Row(
//                         //     mainAxisSize: MainAxisSize.min,
//                         //     children: [
//                         //       Icon(
//                         //         Icons.fiber_manual_record,
//                         //         size: 10,
//                         //       ),
//                         //       Icon(
//                         //         Icons.fiber_manual_record,
//                         //         size: 10,
//                         //       ),
//                         //     ],
//                         //   ),
//                         // ),
//                       ),
//                     );
//                   },
//                   itemCount: playlistsongs1.length,
//                 ));
//           },
//         ),
//       ]),
//     );
//   }
// }
