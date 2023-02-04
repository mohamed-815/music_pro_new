import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

import 'package:music_pro_1/controller/funtion.dart';
import 'package:music_pro_1/main.dart';
import 'package:music_pro_1/view/detailsongs/miniplayer.dart';
import 'package:music_pro_1/view/home/mainscreencontroller.dart';
import 'package:music_pro_1/view/playlist/addplaylist.dart';
import 'package:music_pro_1/view/favorite/favorite.dart';
import 'package:music_pro_1/view/recent/recent.dart';
import 'package:music_pro_1/view/home/widget/allsongs.dart';
import 'package:music_pro_1/view/commonwidgets/draw.dart';
import 'package:music_pro_1/view/search/search.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:simple_gradient_text/simple_gradient_text.dart';

MainScreenController mainScreenController = Get.put(MainScreenController());

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenheight = MediaQuery.of(context).size.height;
    final double screenwidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: ScaffoldGradientBackground(
          drawer: const Drawer1(),
          resizeToAvoidBottomInset: false,
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFF52796F), Color.fromARGB(255, 27, 40, 37)],
          ),

          // backgroundColor: Color(0xFF52796F),
          body: Builder(builder: (context) {
            return Stack(
              children: [
                Column(
                  children: [
                    ListTile(
                      leading: GestureDetector(
                        onTap: () => Scaffold.of(context).openDrawer(),
                        child: const Icon(
                          Icons.menu,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      title: Center(
                        child: GradientText('HOME',
                            colors: const [
                              Color.fromARGB(255, 125, 184, 170),
                              Color.fromARGB(255, 116, 91, 91)
                            ],
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          showBottomSheet(
                              context: context,
                              builder: (ctx) {
                                return const SearchingList();
                              });
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(.1),
                          child: const Center(
                              child: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 18,
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenheight / 100,
                    ),
                    Flexible(
                        flex: 4,
                        child: Obx(() => ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: mainScreenController.SongList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    if (mainScreenController
                                            .SongList[index].title ==
                                        'Favorite') {
                                      Get.to(() => const Favorites());
                                    } else if (mainScreenController
                                            .SongList[index].title ==
                                        'Play List') {
                                      Get.to(() => const AddPlayList());
                                    } else if (mainScreenController
                                            .SongList[index].title ==
                                        'Recents') {
                                      Get.to(() => Recent1());
                                    }
                                  },
                                  child: Container(
                                    child: Column(children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 0),
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Container(
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Image.asset(
                                                    mainScreenController
                                                        .SongList[index].image
                                                        .toString(),
                                                    fit: BoxFit.cover,
                                                    width: screenwidth / 2.5,
                                                    height: screenheight * 0.23,
                                                  ),
                                                ),
                                                // decoration: BoxDecoration(
                                                //   borderRadius:
                                                //       BorderRadius.circular(8),
                                                // ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenheight / 100,
                                          ),
                                          Text(
                                            mainScreenController
                                                .SongList[index].title
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      )
                                    ]),
                                  ),
                                );
                              },
                            ))

                        // GridView.count(
                        //   shrinkWrap: true,
                        //   crossAxisCount: 3,
                        //   crossAxisSpacing: 5,
                        //   mainAxisSpacing: 8.0,
                        //   children: List.generate(
                        //       SongList.length,
                        //       (index) => Center(
                        //             child: PlayListCards(
                        //               songlistinorder: SongList[index],
                        //             ),
                        //           )),
                        // ),
                        ),
                    // SizedBox(
                    //   height: screenheight / 50,
                    // ),

                    dbSongController.dbsongs.isEmpty
                        ? GradientText(
                            colors: const [
                              Color.fromARGB(255, 125, 184, 170),
                              Color.fromARGB(255, 116, 91, 91)
                            ],
                            'No Songs',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        : GradientText(
                            colors: const [
                              Color.fromARGB(255, 125, 184, 170),
                              Color.fromARGB(255, 116, 91, 91)
                            ],
                            'All Songs',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                    SizedBox(
                      height: screenheight / 50,
                    ),
                    AllSongs1(),
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
                                // setState(() {
                                //   isPlaying ? nowplay = true : false;
                                // });
                                //  isPlaying ? nowplay = true : false;
                                return isPlaying ? MiniPlayer() : Container();
                              }))),
                ),

                // (
                //   builder: (context) {
                //     return MiniPlayer();
                //   }
                // )
              ],
            );
          })),
    );
  }
}

// class PlayListCards extends StatefulWidget {
//   const PlayListCards({Key? key, required this.songlistinorder})
//       : super(key: key);
//   final Songs1 songlistinorder;

//   @override
//   State<PlayListCards> createState() => _PlayListCardsState();
// }

// class _PlayListCardsState extends State<PlayListCards> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         if (widget.songlistinorder.title == 'Favorite') {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: ((context) => Favorites())),
//           );
//         } else if (widget.songlistinorder.title == 'Play List') {
//           Navigator.push(context,
//               MaterialPageRoute(builder: ((context) => AddPlayList())));
//         } else if (widget.songlistinorder.title == 'Recent') {
//           Navigator.push(
//               context, MaterialPageRoute(builder: ((context) => Recent1())));
//         }
//       },
//       child: Container(
//         margin: EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(7),
//           image: DecorationImage(
//               image: AssetImage(widget.songlistinorder.image!),
//               fit: BoxFit.cover),
//         ),
//         child: Center(
//           child: GradientText(
//             colors: [
//               Color.fromARGB(255, 226, 200, 193),
//               Colors.teal,
//             ],
//             widget.songlistinorder.title!,
//             style: TextStyle(
//                 fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//           ),
//         ),
//       ),
//     );
//   }
// }


