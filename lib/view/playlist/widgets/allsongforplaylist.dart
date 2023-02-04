import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:music_pro_1/models/db/boxinstance.dart';
import 'package:music_pro_1/controller/dbsongcontroller/dbsongcontroller.dart';
import 'package:music_pro_1/main.dart';
import 'package:music_pro_1/controller/playlistcontroller/playlistcontroller.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class AllSongs3 extends StatelessWidget {
  String playlistname1;
  AllSongs3({required this.playlistname1, Key? key}) : super(key: key);
  List<dynamic> playlistsong6 = [];
  @override
  Widget build(BuildContext context) {
    final box1 = Boxes.getInstance();
    playlistsong6 = box1.get(playlistname1)!;
    final double screenhight = MediaQuery.of(context).size.height;
    final double screenwidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          height: screenhight / 100,
        ),
        Text(
          'All Songs',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: screenhight / 100,
        ),
        Expanded(
            child: GetBuilder<DbSongController>(
                init: DbSongController(),
                builder: (dbcontroller1) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GetBuilder<PlayListController>(
                          init: PlayListController(),
                          builder: (playlistcontroller1) {
                            return GestureDetector(
                              onTap: () async {
                                playlistcontroller1.playlistSongAdd(
                                    playlistsong6, index, box1, playlistname1);
                                // final ispresent = playlistsong6.where((element) =>
                                //     element.id.toString() ==
                                //     dbSongController.dbsongs[index].id.toString());

                                // if (ispresent.isEmpty) {
                                //   setState(() {
                                //     playlistsong6.add(dbSongController.dbsongs[index]);
                                //   });

                                //   await box1.put(widget.playlistname1, playlistsong6);
                                // }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, top: 2, right: 12, bottom: 2),
                                child: Card(
                                    color: Colors.white.withOpacity(.1),
                                    child: playlist_tile(index, screenwidth)),
                              ),
                            );
                          });
                    },
                    itemCount: dbcontroller1.audioconvertedsongs.length,
                  );
                })),
      ],
    );
    // return Expanded(
    //   flex: 8,
    //   child: FutureBuilder<List<SongModel>>(
    //     future: audioquery.querySongs(
    //         sortType: null,
    //         orderType: OrderType.ASC_OR_SMALLER,
    //         uriType: UriType.EXTERNAL,
    //         ignoreCase: true),
    //     builder: (context, item) {
    //       if (item.data == null) {
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       } else if (item.data!.isEmpty) {
    //         return Center(
    //           child: Text('No songs fount'),
    //         );
    //       } else {
    //         return ListView.builder(
    //           shrinkWrap: true,
    //           itemBuilder: (context, index) {
    //             return GestureDetector(
    //               onTap: () => Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                       builder: ((context) => DetailSong(
    //                             audioPlayer: audioplayer,
    //                             index: index,
    //                           )))),
    //               child: ListTile(
    //                 leading: SizedBox(
    //                   width: 45,
    //                   child: ClipRRect(
    //                       borderRadius: BorderRadius.circular(8.0),
    //                       child: Image.asset(
    //                           "assets/best-rap-songs-1583527287.png")),
    //                 ),
    //                 title: Row(
    //                   mainAxisSize: MainAxisSize.min,
    //                   children: [
    //                     Column(
    //                       mainAxisSize: MainAxisSize.min,
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text(
    //                           item.data![index].displayNameWOExt,
    //                           style: TextStyle(color: Colors.white),
    //                         ),
    //                         Text(
    //                           item.data![index].artist!,
    //                           style: TextStyle(
    //                               color: Colors.grey.shade500,
    //                               fontFamily: 'Montserrat',
    //                               fontSize: 13),
    //                         )
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //                 trailing: GestureDetector(
    //                   onTap: () => Dialogbox2(context),
    //                   child: Row(
    //                     mainAxisSize: MainAxisSize.min,
    //                     children: [
    //                       Icon(
    //                         Icons.fiber_manual_record,
    //                         size: 10,
    //                       ),
    //                       Icon(
    //                         Icons.fiber_manual_record,
    //                         size: 10,
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             );
    //           },
    //           itemCount: dbsongs!.length,
    //         );
    //       }
    //     },
    //   ),
    // );
  }

  playlist_tile(int index, double screenwidth) {
    return GetBuilder<DbSongController>(
        init: DbSongController(),
        builder: (dbs) {
          return ListTile(
            contentPadding: EdgeInsets.all(6),
            leading: Container(
              width: 50,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: QueryArtworkWidget(
                      nullArtworkWidget: Image.asset(
                        "assets/best-rap-songs-1583527287.png",
                      ),
                      id: int.parse(
                          dbs.audioconvertedsongs[index].metas.id.toString()),
                      type: ArtworkType.AUDIO)),
            ),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: screenwidth / 3,
                      margin: const EdgeInsets.only(right: 13),
                      child: Text(
                        dbs.audioconvertedsongs[index].metas.title!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      width: screenwidth / 3,
                      margin: const EdgeInsets.only(right: 13),
                      child: dbs.audioconvertedsongs[index].metas.artist ==
                              '<unknown>'
                          ? const Text(
                              overflow: TextOverflow.ellipsis,
                              'unknown artist',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            )
                          : Text(
                              overflow: TextOverflow.ellipsis,
                              dbs.audioconvertedsongs[index].metas.artist!,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.white),
                            ),
                      // child: Text(
                      //   audioconvertedsongs[index].metas.artist!,
                      //   overflow: TextOverflow.ellipsis,
                      //   style: TextStyle(
                      //       color: Colors.grey.shade500,
                      //       fontFamily: 'Montserrat',
                      //       fontSize: 13),
                      // ),
                    )
                  ],
                ),
              ],
            ),
            trailing: Icon(Icons.add),
          );
        });
  }
}

//List<dynamic> reverserecent = [];

