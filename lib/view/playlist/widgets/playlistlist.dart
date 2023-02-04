import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_pro_1/models/db/allsongstoringclass.dart';

import 'package:music_pro_1/view/playlist/insideplaylist.dart';
import 'package:music_pro_1/view/playlist/widgets/showdialogbox.dart';
import 'package:music_pro_1/view/commonwidgets/snackbars.dart';
import 'package:music_pro_1/controller/playlistcontroller/playlistcontroller.dart';

class PlayListlist extends StatelessWidget {
  AllSongs? songtoplaylist;
  PlayListlist({this.songtoplaylist, super.key});
  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    // playlistkey = playlistkeys
    //     .where((element) =>
    //         playlistkeys.contains('favorite') ||
    //         playlistkeys.contains('totalsongs'))
    //     .toList();

    return
        // playlistkeys.contains('favorite') ||
        //         playlistkeys.contains('totalsongs')
        //  ?
        Flexible(
      flex: 2,
      child: GetBuilder<PlayListController>(
          init: PlayListController(),
          builder: (c) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: c.playlistkeys.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        // if (widget.songtoplaylist != null) {}

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => InsidePlaylist(
                                      playlistname: c.playlistkeys[index],
                                    ))));
                      },
                      child: c.playlistkeys[index] != 'favorite' &&
                              c.playlistkeys[index] != 'totalsongs' &&
                              c.playlistkeys[index] != 'recent1'
                          ? Padding(
                              padding: const EdgeInsets.all(5),
                              child: Card(
                                color: const Color.fromARGB(255, 66, 84, 70),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(10),
                                  leading: CircleAvatar(
                                    child: Image.asset(
                                      'assets/crop_480x480_1623441.jpg',
                                      // width: 150,
                                      // height: 150,
                                    ),
                                  ),
                                  title: Text(
                                    c.playlistkeys[index].toString(),
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  subtitle: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        'Songs',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: screenwidth / 50,
                                      ),
                                      Text(
                                        c.totalSongs(
                                            name: c.playlistkeys[index]),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (ctx) {
                                                  return ShowdialogeEdit(
                                                      playlistcurrentname: c
                                                          .playlistkeys[index]);
                                                });
                                          },
                                          child: Icon(
                                            Icons.edit,
                                            size: 20,
                                          )),
                                      SizedBox(
                                        width: screenwidth / 50,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          await showDialog(
                                              context: context,
                                              builder: (ctx) {
                                                return Dialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Color.fromARGB(
                                                            255, 26, 105, 85),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    height: screenheight / 7,
                                                    padding: EdgeInsets.all(3),
                                                    child: Column(children: [
                                                      Card(
                                                        color: Colors.white
                                                            .withOpacity(.1),
                                                        child: Container(
                                                          height:
                                                              screenheight / 35,
                                                          width:
                                                              screenwidth / 6,
                                                          child: Center(
                                                            child: Text(
                                                              'Delete',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          height: screenheight /
                                                              60),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          TextButton(
                                                              onPressed:
                                                                  () async {
                                                                c.playListDelete(
                                                                    index);
                                                                // if (playlistbox.keys
                                                                //             .toList() !=
                                                                //         'favorite' ||
                                                                //     playlistbox.keys
                                                                //             .toList() !=
                                                                //         'totalsongs' ||
                                                                //     playlistbox.keys
                                                                //             .toList() !=
                                                                //         'recent1') {
                                                                //   await playlistbox.delete(
                                                                //    c
                                                                //               .playlistkeys[
                                                                //           index]);
                                                                // }

                                                                // setState(() {
                                                                //        c
                                                                //           .playlistkeys =
                                                                //       playlistbox.keys
                                                                //           .toList();
                                                                //   // playlistkeys.removeWhere((element) =>
                                                                //   //     element.toString() ==
                                                                //   //     playlistkeys[index].toString());
                                                                // });
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        SnackBar1()
                                                                            .playlistdeleted);
                                                                Navigator.of(
                                                                        ctx)
                                                                    .pop();
                                                              },
                                                              child: Text(
                                                                'delete',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              )),
                                                          SizedBox(
                                                            width: screenwidth /
                                                                30,
                                                          ),
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        ctx)
                                                                    .pop();
                                                              },
                                                              child: Text(
                                                                  'close',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white)))
                                                        ],
                                                      )
                                                    ]),
                                                  ),
                                                );
                                              });
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color:
                                              Color.fromARGB(255, 55, 53, 53),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Container());
                });
          }),
    );
    // : Container();
  }
}
