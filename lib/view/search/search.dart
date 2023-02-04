import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:music_pro_1/models/db/audioplay.dart';
import 'package:music_pro_1/main.dart';
import 'package:music_pro_1/view/detailsongs/miniplayer.dart';
import 'package:music_pro_1/controller/searchcontroller/searchcontroller.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SearchingList extends StatelessWidget {
  const SearchingList({super.key});
  @override
  Widget build(BuildContext context) {
    final screenhieght = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenhieght / 1.5,
      color: Color.fromARGB(255, 63, 80, 66),
      child: GetBuilder<SearchController>(
          init: SearchController(),
          builder: (searchcontrollermain) {
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.all(screenwidth / 45),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey),
                  child: GetBuilder<SearchController>(
                      init: SearchController(),
                      builder: (searchcontroller) {
                        return TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: searchcontroller.controller1,
                          onChanged: (value) {
                            // final valeu1 = value;
                            searchcontroller.findingSong(value);
                            // setState(() {
                            // listsearch = dbSongController.dbsongs
                            //       .where((element) => element.title!
                            //           .toLowerCase()
                            //           .contains(value.toLowerCase()))
                            //       .toList();
                            // });
                          },
                          decoration: InputDecoration(
                            // enabledBorder: OutlineInputBorder(
                            //   borderSide: BorderSide(
                            //     width: 20,
                            //     color: Colors.grey,
                            //   ),
                            // ),
                            hintText: '  search',
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search_outlined,
                              color: Color.fromARGB(255, 63, 62, 62),
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: screenhieght / 50,
                ),
                searchcontrollermain.controller1.text.isNotEmpty
                    ? Expanded(
                        flex: 8,
                        child: searchcontrollermain.listsearch.isEmpty
                            ? Container(
                                height: screenhieght / 3.5,
                                child: Center(
                                    child: GradientText(
                                  colors: const [
                                    Color.fromARGB(255, 125, 184, 170),
                                    Color.fromARGB(255, 116, 91, 91)
                                  ],
                                  'Not Here',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      showBottomSheet(
                                        backgroundColor: Color(0xFF52796F),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20))),
                                        context: context,
                                        builder: (ctx) => SizedBox(
                                            height: screenhieght / 9,
                                            child: MiniPlayer()),
                                      );
                                      for (var element
                                          in searchcontrollermain.listsearch) {
                                        searchcontrollermain.listsearch1.add(
                                            Audio.file(element.uri.toString(),
                                                metas: Metas(
                                                  title: element.title,
                                                  id: element.id.toString(),
                                                  artist: element.artist,
                                                  album: element.duration
                                                      .toString(),
                                                )));
                                      }

                                      AssetAudioPlay(
                                              audioconvertedsongs:
                                                  searchcontrollermain
                                                      .listsearch1,
                                              index: index)
                                          .songPlayNow(
                                              searchcontrollermain.listsearch1,
                                              index);

                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: ((context) => DetailSong(
                                      //               audioPlayer: audioplayer,
                                      //               index: index,
                                      //             ))));
                                    },
                                    child: ListTile(
                                      leading: Container(
                                        // padding: EdgeInsets.only(
                                        //     top: screenwidth / 50, bottom: screenwidth / 50),
                                        width: 50,

                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: QueryArtworkWidget(
                                                nullArtworkWidget: Image.asset(
                                                  "assets/best-rap-songs-1583527287.png",
                                                ),
                                                id: int.parse(
                                                    searchcontrollermain
                                                        .listsearch[index].id
                                                        .toString()),
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
                                                margin:
                                                    EdgeInsets.only(right: 13),
                                                child: Text(
                                                  searchcontrollermain
                                                      .listsearch[index].title!,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(right: 13),
                                                child: searchcontrollermain
                                                            .listsearch[index]
                                                            .artist ==
                                                        '<unknown>'
                                                    ? Text(
                                                        'unknown artist',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.white),
                                                      )
                                                    : Container(
                                                        width: 70,
                                                        child: Text(
                                                          searchcontrollermain
                                                              .listsearch[index]
                                                              .artist!,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),

                                      // trailing: GestureDetector(
                                      //   onTap: () async {
                                      //     setState(() {
                                      //       favoritesongs!.removeAt(index);

                                      //       favoritebox.put('favorite', favoritesongs!);
                                      //     });
                                      //   },
                                      //   child: Icon(
                                      //     Icons.favorite,
                                      //     color: Colors.white,
                                      //   ),
                                      // ),
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
                                  );
                                },
                                itemCount:
                                    searchcontrollermain.listsearch.length,
                              ))
                    : Container(
                        height: screenhieght / 3.5,
                        child: Center(
                            child: GradientText(
                          colors: const [
                            Color.fromARGB(255, 125, 184, 170),
                            Color.fromARGB(255, 116, 91, 91)
                          ],
                          'Just Search It',
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                      )
              ],
            );
          }),
    );
  }
}
