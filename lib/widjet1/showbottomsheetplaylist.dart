import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import 'package:music_pro_1/db/dbfetching.dart';
import 'package:music_pro_1/widjet1/allsongs.dart';
import 'package:music_pro_1/widjet1/snackbars.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ShowbottomList extends StatefulWidget {
  Audio? songaddplaylist;

  ShowbottomList({required this.songaddplaylist, super.key});

  @override
  State<ShowbottomList> createState() => _ShowbottomListState();
}

class _ShowbottomListState extends State<ShowbottomList> {
  @override
  late TextEditingController controller;
  final formkey = GlobalKey<FormState>();
  @override
  void initState() {
    controller = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    final screenhieght = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        SizedBox(
          height: screenhieght / 50,
        ),
        ListTile(
          title: GradientText(
            colors: const [
              Color.fromARGB(255, 125, 184, 170),
              Color.fromARGB(255, 116, 91, 91)
            ],
            'PLAY LIST',
            style: const TextStyle(
                color: Colors.white, fontSize: 23, fontWeight: FontWeight.w600),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () async {
                  await showDialog(
                      context: context,
                      builder: (ctx) {
                        return Dialog(
                          backgroundColor:
                              const Color.fromARGB(255, 44, 82, 71),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              width: screenwidth / 10,
                              height: screenhieght / 4,
                              child: Column(
                                children: [
                                  Form(
                                    key: formkey,
                                    child: TextFormField(
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      controller: controller,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: const BorderSide(
                                                color: Colors.white)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        hintStyle: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 202, 202, 202)),
                                        hintText: 'Create a Playlist',
                                        focusedBorder: OutlineInputBorder(
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
                                        value1 = value.trim();
                                      },
                                      validator: (value) {
                                        List keys = playlistbox.keys.toList();
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
                                    height: screenhieght / 20,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          width: screenwidth / 4.5,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20))),
                                              onPressed: () {
                                                submit();
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar1()
                                                        .playlistcreated);
                                              },
                                              child: const Text(
                                                'Create',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              )),
                                        ),
                                        SizedBox(
                                          width: screenwidth / 4.5,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20))),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                'Cancel',
                                                style: TextStyle(
                                                    color: Colors.black),
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
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(
                    //   width: screenwidth / 3,
                    // ),
                    Center(
                        child: Card(
                            color: Colors.white.withOpacity(.1),
                            child: const Icon(
                              Icons.add,
                              size: 30,
                            ))),
                    // SizedBox(
                    //   width: screenwidth / 6,
                    // )
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: screenhieght / 70,
        ),
        ...playlistkeys
            .map((e) => e != 'totalsongs' && e != 'favorite' && e != 'recent1'
                ? Padding(
                    padding: const EdgeInsets.all(8),
                    child: Card(
                      color: const Color.fromARGB(255, 72, 92, 77),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10),
                        onTap: () async {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar1().addedtoplaylist);
                          playlistsongs1 = playlistbox.get(e)!;
                          List? existingsongname = [];
                          existingsongname = playlistsongs1
                              .where((element) =>
                                  element.id.toString() ==
                                  widget.songaddplaylist!.metas.id.toString())
                              .toList();

                          if (existingsongname.isEmpty) {
                            final temp = dbsongs.firstWhere((element) =>
                                element.id.toString() ==
                                widget.songaddplaylist!.metas.id.toString());

                            playlistsongs1.add(temp);

                            await playlistbox.put(e, playlistsongs1);
                          }
                        },
                        leading: CircleAvatar(
                          child: Image.asset(
                            'assets/crop_480x480_1623441.jpg',
                            width: 130,
                            height: 130,
                          ),
                        ),
                        title: Text(
                          e.toString(),
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
                        ),
                        trailing: GestureDetector(
                          onTap: () async {
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 26, 105, 85),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      height: screenhieght / 7.5,
                                      padding: EdgeInsets.all(10),
                                      child: Column(children: [
                                        Card(
                                          color: Colors.white.withOpacity(.1),
                                          child: Container(
                                            height: screenhieght / 35,
                                            width: screenwidth / 6,
                                            child: Center(
                                              child: Text(
                                                'Delete',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 8, 0),
                                              child: TextButton(
                                                  onPressed: () async {
                                                    if (playlistbox.keys
                                                                .toList() !=
                                                            'favorite' ||
                                                        playlistbox.keys
                                                                .toList() !=
                                                            'totalsongs') {
                                                      await playlistbox
                                                          .delete(e);
                                                    }

                                                    setState(() {
                                                      playlistkeys = playlistbox
                                                          .keys
                                                          .toList();
                                                      // playlistkeys.removeWhere((element) =>
                                                      //     element.toString() ==
                                                      //     playlistkeys[index].toString());
                                                    });
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar1()
                                                            .playlistdeleted);
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    'delete',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(ctx).pop();
                                                },
                                                child: Text('close',
                                                    style: TextStyle(
                                                        color: Colors.white)))
                                          ],
                                        )
                                      ]),
                                    ),
                                  );
                                });
                          },
                          child: const Icon(
                            Icons.delete,
                            color: Color.fromARGB(255, 55, 53, 53),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container())
            .toList()
      ],
    );
  }

  void submit() {
    //playlistName = controller.text;
    List<AllSongs1> librayry = [];
    List<dynamic> freelist = [];
    List? excistingName = [];
    if (playlists.isNotEmpty) {
      excistingName =
          playlists.where((element) => element == controller.text).toList();
    }

    if (controller.text != '' &&
        excistingName.isEmpty &&
        formkey.currentState!.validate()) {
      playlistbox.put(controller.text, freelist);
      Navigator.of(context).pop();

      setState(() {
        playlistkeys = playlistbox.keys.toList();
      });
    }

    // else {
    //   ScaffoldMessenger.of(context).showSnackBar(existingPlaylist);
    // }

    controller.clear();
  }
}
