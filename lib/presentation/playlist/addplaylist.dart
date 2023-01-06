import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:music_pro_1/db/dbfetching.dart';
import 'package:music_pro_1/db/dbsongcontroller/dbsongcontroller.dart';

import 'package:music_pro_1/funtion.dart';
import 'package:music_pro_1/main.dart';
import 'package:music_pro_1/presentation/home/mainscreen.dart';

import 'package:music_pro_1/presentation/home/widget/allsongs.dart';
import 'package:music_pro_1/presentation/playlist/widgets/playlistlist.dart';
import 'package:music_pro_1/presentation/commonwidgets/snackbars.dart';
import 'package:music_pro_1/presentation/playlist/playlistcontroller.dart';

import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

import '../detailsongs/miniplayer.dart';

class AddPlayList extends StatelessWidget {
  const AddPlayList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenhight = MediaQuery.of(context).size.height;
    final double screenwidth = MediaQuery.of(context).size.width;
    return ScaffoldGradientBackground(
      gradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color.fromARGB(255, 91, 123, 115),
          Color.fromARGB(255, 26, 105, 85)
        ],
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
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    height: screenhight / 3.5,
                    width: screenwidth / 2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image:
                                AssetImage('assets/8d-Technology-Audio.webp'))),
                  ),
                ),
              ),
              SizedBox(
                height: screenhight / 35,
              ),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    await showDialog(
                        context: context,
                        builder: (ctx) {
                          return GetBuilder<PlayListController>(
                              init: PlayListController(),
                              builder: (c) {
                                return Dialog(
                                  backgroundColor:
                                      const Color.fromARGB(255, 44, 82, 71),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: Container(
                                      width: screenwidth / 10,
                                      height: screenhight / 4,
                                      child: Column(
                                        children: [
                                          Form(
                                            key: c.formkey,
                                            child: TextFormField(
                                              textCapitalization:
                                                  TextCapitalization.sentences,
                                              controller: c.controller,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                Colors.white)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .white,
                                                                width: 2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                hintStyle: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 202, 202, 202)),
                                                hintText: 'Create a Playlist',
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  borderSide: const BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 155, 122, 122),
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                              onChanged: (value) {
                                                //value1 = value.trim();
                                              },
                                              validator: (value) {
                                                List keys =
                                                    playlistbox.keys.toList();
                                                if (value!.trim() == '') {
                                                  return "Name required";
                                                }
                                                if (keys
                                                    .where((element) =>
                                                        element == value.trim())
                                                    .isNotEmpty) {
                                                  return "This name is already exists";
                                                }
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenhight / 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                SizedBox(
                                                  width: screenwidth / 4.5,
                                                  child: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.white,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20))),
                                                      onPressed: () {
                                                        c.submit(context);
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar1()
                                                                    .playlistcreated);
                                                      },
                                                      child: const Text(
                                                        'Create',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      )),
                                                ),
                                                SizedBox(
                                                  width: screenwidth / 4.5,
                                                  child: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.white,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20))),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        'Cancel',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        });
                  }
                  // onTap: ()
                  // async {
                  //   showDialog(
                  //       context: context,
                  //       builder: (ctx1) {
                  //         final TextEditingController controller =
                  //             TextEditingController();
                  //         final formKey = GlobalKey<FormState>();
                  //         return AlertDialog(
                  //           content: Form(
                  //               key: formKey,
                  //               child: TextFormField(
                  //                   controller: controller,
                  //                   onChanged: (value) {
                  //                     title1 = value.trim();
                  //                   },
                  //                   validator: ((value) {
                  //                     if (value!.trim() == '') {
                  //                       return "name required";
                  //                     }
                  //                     if (playlistkeys
                  //                         .where(
                  //                             (element) => element == value.trim())
                  //                         .isNotEmpty) {
                  //                       return "the name is all ready exist";
                  //                     }
                  //                   }),

                  //                   //  validator: (value) {
                  //                   //          List keys = box.keys.toList();
                  //                   //                                       if (value!.trim() == "") {
                  //                   //                                         return "Name required";
                  //                   //                                       }
                  //                   //                                       if (keys
                  //                   //                                           .where((element) =>
                  //                   //                                               element == value.trim())
                  //                   //                                           .isNotEmpty) {
                  //                   //                                         return "This name is already exists";
                  //                   //                                       }
                  //                   //                                     },

                  //                   decoration: InputDecoration())),

                  //           title:

                  //            Text(
                  //             'Add Play List',
                  //             style:
                  //                 TextStyle(color: Color.fromARGB(255, 44, 66, 61)),
                  //           ),

                  //           actions: [
                  //             TextButton(
                  //                 onPressed: () {
                  //                   Navigator.of(ctx1).pop();
                  //                 },
                  //                 child: const Text(
                  //                   'close',
                  //                   style: TextStyle(
                  //                       color: Color.fromARGB(255, 98, 145, 134)),
                  //                 )),
                  //             TextButton(
                  //                 onPressed: () async {
                  //                   if (controller.text != '' ||
                  //                       playlistkeys
                  //                           .where((element) =>
                  //                               element == controller.text)
                  //                           .toString()
                  //                           .isEmpty ||
                  //                       formkey.currentState!.validate()) {
                  //                     playlistbox.put(
                  //                         controller.text, playlistsongs);
                  //                   }
                  //                   setState(() {
                  //                     playlists = playlistbox.keys.toList();
                  //                   });

                  //                   Navigator.of(ctx1).pop();
                  //                 },
                  //                 child: Text(
                  //                   'Add',
                  //                   style: TextStyle(
                  //                       color: Color.fromARGB(255, 98, 145, 134)),
                  //                 )),
                  //           ],
                  //         );
                  //       });
                  //   ;
                  // },,,
                  ,
                  child: Card(
                    color: Colors.white.withOpacity(.1),
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: const Text(
                        '+ Play List',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenhight / 45,
              ),
              PlayListlist()
            ],
          ),
          Positioned(
            bottom: 0,
            child: PlayerBuilder.isPlaying(
                player: audioplayer,
                builder: (context, isPlaying) {
                  return isPlaying ? MiniPlayer() : Container();
                }),
          )
        ],
      )),
    );
  }

  // void submit() {
  //   //playlistName = controller.text;
  //   List<AllSongs1> librayry = [];
  //   List<dynamic> freelist = [];
  //   List? excistingName = [];
  //   if (dbSongController.playlists.isNotEmpty) {
  //     excistingName = dbSongController.playlists
  //         .where((element) => element == controller.text)
  //         .toList();
  //   }

  //   if (controller.text != '' &&
  //       excistingName.isEmpty &&
  //       formkey.currentState!.validate()) {
  //     playlistbox.put(controller.text, freelist);
  //     Navigator.of(context).pop();

  //     setState(() {
  //       dbSongController.playlistkeys = playlistbox.keys.toList();
  //     });
  //   }

  //   // else {
  //   //   ScaffoldMessenger.of(context).showSnackBar(existingPlaylist);
  //   // }

  //   controller.clear();
  // }

}

//Future<void> Dialogbox1(context) async {}

//submit(GlobalKey<FormState> formkey) {}
