import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_pro_1/db/dbfetching.dart';
import 'package:music_pro_1/db/dbsongcontroller/dbsongcontroller.dart';
import 'package:music_pro_1/db/dbsongcontroller/dbsongcontroller.dart';
import 'package:music_pro_1/main.dart';
import 'package:music_pro_1/presentation/commonwidgets/snackbars.dart';
import 'package:music_pro_1/presentation/favorite/favoritecontroller.dart';
import 'package:music_pro_1/presentation/playlist/playlistcontroller.dart';

class ShowdialogeEdit extends StatelessWidget {
  String? playlistcurrentname;
  ShowdialogeEdit({required this.playlistcurrentname, super.key});

  //final formkey = GlobalKey<FormState>();

  String? changingvaleu;

  @override
  Widget build(BuildContext context) {
    //final TextEditingController controller = TextEditingController();

    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return Dialog(
      backgroundColor: const Color.fromARGB(255, 44, 82, 71),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Container(
          width: screenwidth / 10,
          height: screenheight / 4,
          child: GetBuilder<PlayListController>(
              init: PlayListController(),
              builder: (c) {
                if (playlistcurrentname != null) {
                  c.controller.text = playlistcurrentname!;
                }

                return Column(
                  children: [
                    Form(
                      key: c.formkey,
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: c.controller,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(30)),
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 202, 202, 202)),
                          hintText: playlistcurrentname,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 155, 122, 122),
                              width: 2.0,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          changingvaleu = value.trim();
                        },
                        validator: (value) {
                          List keys = playlistbox.keys.toList();
                          if (value!.trim() == '') {
                            return "Name required";
                          }
                          if (keys
                              .where((element) => element == value.trim())
                              .isNotEmpty) {
                            return "This name is already exists";
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: screenheight / 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: screenwidth / 4.5,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                onPressed: () {
                                  c.submit1(playlistcurrentname, context);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar1().playlistedited);
                                },
                                child: const Text(
                                  'Create',
                                  style: TextStyle(color: Colors.black),
                                )),
                          ),
                          SizedBox(
                            width: screenwidth / 4.5,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.black),
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }

  // void submit(TextEditingController controller) async {
  //   //playlistName = controller.text;
  //   //List<AllSongs1> librayry = [];

  //   List<dynamic> freelist =
  //       playlistbox.get(widget.playlistcurrentname)!.toList();
  //   List? excistingName = [];
  //   if (dbSongController.playlists.isNotEmpty) {
  //     excistingName = dbSongController.playlists
  //         .where((element) => element == controller.text)
  //         .toList();
  //   }

  //   if (controller.text != '' &&
  //       excistingName.isEmpty &&
  //       formkey.currentState!.validate()) {
  //     await playlistbox.put(controller.text, freelist);
  //     await playlistbox.delete(widget.playlistcurrentname);
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
