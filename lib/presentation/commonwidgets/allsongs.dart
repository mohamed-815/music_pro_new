import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:music_pro_1/db/audioplay.dart';
import 'package:music_pro_1/db/dbfetching.dart';
import 'package:music_pro_1/main.dart';
import 'package:music_pro_1/presentation/commonwidgets/miniplayer.dart';
import 'package:music_pro_1/presentation/favorite/favorite.dart';
import 'package:music_pro_1/presentation/commonwidgets/showbottomsheetplaylist.dart';
import 'package:music_pro_1/presentation/commonwidgets/snackbars.dart';
import 'package:music_pro_1/presentation/favorite/favoritecontroller.dart';
import 'package:music_pro_1/presentation/home/mainscreen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AllSongs1 extends StatefulWidget {
  const AllSongs1({Key? key}) : super(key: key);

  @override
  State<AllSongs1> createState() => _AllSongs1State();
}

List<dynamic> reverserecent = [];

class _AllSongs1State extends State<AllSongs1> {
  @override
  Widget build(BuildContext context) {
    final double screenhight = MediaQuery.of(context).size.height;
    final double screenwidth = MediaQuery.of(context).size.width;
    return Flexible(
        flex:
            //nowplay ? 4 :
            7,
        child: Obx(() => ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Obx(() => GestureDetector(
                      onTap: () async {
                        // dbSongController.recent1 = dbSongController.box.get('recent1')!;
                        // final isinrecent = dbSongController.recent1
                        //     .where(((element) =>
                        //         element.id.toString() ==
                        //         dbSongController.dbsongs[index].id.toString()))
                        //     .toList();
                        // if (isinrecent.isEmpty) {
                        //   dbSongController.recent1.add(dbSongController.dbsongs[index]);
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
                        mainScreenController.addingToRecentfromhome(index);

                        // AssetAudioPlay(
                        //         audioconvertedsongs:
                        //             dbSongController.audioconvertedsongs,
                        //         index: index)
                        //     .songPlayNow(dbSongController.audioconvertedsongs, index);
                        mainScreenController.mainScreenaudioplay(index);

                        showBottomSheet(
                            backgroundColor:
                                const Color.fromARGB(255, 55, 72, 67),
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            context: context,
                            builder: (ctx) => SizedBox(
                                height: screenhight / 9,
                                child: MiniPlayer(
                                  index: index,
                                  dbsong1: dbSongController.dbsongs,
                                )),
                            enableDrag: true);

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
                            contentPadding: EdgeInsets.all(6),
                            //  contentPadding:
                            //     EdgeInsets.symmetric(vertical: 5, horizontal: 2),
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
                                      id: int.parse(dbSongController
                                          .audioconvertedsongs[index].metas.id
                                          .toString()),
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
                                        dbSongController
                                            .audioconvertedsongs[index]
                                            .metas
                                            .title!,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                    Container(
                                      width: screenwidth / 3,
                                      margin: const EdgeInsets.only(right: 13),
                                      child: dbSongController
                                                  .audioconvertedsongs[index]
                                                  .metas
                                                  .artist ==
                                              '<unknown>'
                                          ? const Text(
                                              overflow: TextOverflow.ellipsis,
                                              'unknown artist',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white),
                                            )
                                          : Text(
                                              overflow: TextOverflow.ellipsis,
                                              dbSongController
                                                  .audioconvertedsongs[index]
                                                  .metas
                                                  .artist!,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white),
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
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                favoriteController.favoritesongs!
                                        .where(
                                          (element) =>
                                              element.id.toString() ==
                                              dbSongController
                                                  .dbsongs[index].id!
                                                  .toString(),
                                        )
                                        .isEmpty
                                    ? IconButton(
                                        onPressed: () async {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                                  SnackBar1().favoriteadd);

                                          mainScreenController.addTofav(index);
                                          //   favoriteController.favoritesongs
                                          //       ?.add(dbSongController.dbsongs[index]);
                                          //   await favoritebox.put('favorite',
                                          //       favoriteController.favoritesongs!);
                                          //   setState(() {
                                          //     favoriteController.favoritesongs!.value =
                                          //         favoritebox.get('favorite')!;
                                          //   });
                                        },
                                        icon: const Icon(
                                          Icons.favorite,
                                        ))
                                    : IconButton(
                                        onPressed: () async {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                                  SnackBar1().removefavorite);

                                          // favoriteController.favoritesongs?.removeWhere(
                                          //   (element) =>
                                          //       element.id.toString() ==
                                          //       dbSongController.dbsongs[index].id
                                          //           .toString(),
                                          // );
                                          // await favoritebox.put('favorite',
                                          //     favoriteController.favoritesongs!);
                                          // setState(() {
                                          //   favoriteController.favoritesongs!.value =
                                          //       favoritebox.get('favorite')!;
                                          // });

                                          mainScreenController
                                              .removeFromfav(index);
                                        },
                                        icon: const Icon(
                                          Icons.favorite,
                                          color: Colors.white,
                                        )),
                                GestureDetector(
                                  onTap: () {
                                    showBottomSheet(
                                        backgroundColor: const Color.fromARGB(
                                            255, 55, 72, 67),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20))),
                                        context: context,
                                        builder: (ctx) {
                                          return SizedBox(
                                            height: screenhight / 2.5,
                                            child: ShowbottomList(
                                                songaddplaylist: dbSongController
                                                        .audioconvertedsongs[
                                                    index]),
                                          );
                                        });
                                  },
                                  child: const Icon(
                                    Icons.playlist_add,
                                    size: 35,
                                  ),
                                ),
                                // Icon(
                                //   Icons.fiber_manual_record,
                                //   size: 10,
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ));
              },
              itemCount: dbSongController.audioconvertedsongs.length,
            ))
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
        );
  }

  // @override
  // void didChangeDependencies() {
  //   favoritesongs = favoritebox.get('favorite');
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  // }
}
