import 'package:flutter/material.dart';
import 'package:music_pro_1/db/allsongstoringclass.dart';
import 'package:music_pro_1/db/boxinstance.dart';
import 'package:music_pro_1/db/dbfetching.dart';
import 'package:music_pro_1/play%20list/insideplaylist.dart';
import 'package:music_pro_1/widjet1/showdialogbox.dart';
import 'package:music_pro_1/widjet1/snackbars.dart';

class PlayListlist extends StatefulWidget {
  AllSongs? songtoplaylist;
  PlayListlist({this.songtoplaylist, super.key});

  @override
  State<PlayListlist> createState() => _PlayListlistState();
}

class _PlayListlistState extends State<PlayListlist> {
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
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: playlistkeys.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  if (widget.songtoplaylist != null) {}

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => InsidePlaylist(
                                playlistname: playlistkeys[index],
                              ))));
                },
                child: playlistkeys[index] != 'favorite' &&
                        playlistkeys[index] != 'totalsongs' &&
                        playlistkeys[index] != 'recent1'
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
                              playlistkeys[index].toString(),
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
                                  totalSongs(name: playlistkeys[index]),
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
                                                playlistcurrentname:
                                                    playlistkeys[index]);
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
                                                    BorderRadius.circular(20)),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 26, 105, 85),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              height: screenheight / 4,
                                              padding: EdgeInsets.all(30),
                                              child: Column(children: [
                                                Card(
                                                  color: Colors.white
                                                      .withOpacity(.1),
                                                  child: Container(
                                                    height: screenheight / 35,
                                                    width: screenwidth / 6,
                                                    child: Center(
                                                      child: Text(
                                                        'Delete',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: screenheight / 13),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(0, 0, 8, 0),
                                                      child: TextButton(
                                                          onPressed: () async {
                                                            if (playlistbox.keys.toList() != 'favorite' ||
                                                                playlistbox.keys
                                                                        .toList() !=
                                                                    'totalsongs' ||
                                                                playlistbox.keys
                                                                        .toList() !=
                                                                    'recent1') {
                                                              await playlistbox
                                                                  .delete(
                                                                      playlistkeys[
                                                                          index]);
                                                            }

                                                            setState(() {
                                                              playlistkeys =
                                                                  playlistbox
                                                                      .keys
                                                                      .toList();
                                                              // playlistkeys.removeWhere((element) =>
                                                              //     element.toString() ==
                                                              //     playlistkeys[index].toString());
                                                            });
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar1()
                                                                        .playlistdeleted);
                                                          },
                                                          child: Text(
                                                            'delete',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          )),
                                                    ),
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.of(ctx)
                                                              .pop();
                                                        },
                                                        child: Text('close',
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
                                    color: Color.fromARGB(255, 55, 53, 53),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container());
          }),
    );
    // : Container();
  }

  String totalSongs({required name}) {
    final playBox = Boxes.getInstance();
    final list = playBox.get(name);
    final temp = list!.length.toString();
    return temp;
  }
}
