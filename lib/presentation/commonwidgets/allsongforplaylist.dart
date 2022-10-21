import 'package:flutter/material.dart';
import 'package:music_pro_1/db/boxinstance.dart';
import 'package:music_pro_1/db/dbfetching.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AllSongs3 extends StatefulWidget {
  String playlistname1;
  AllSongs3({required this.playlistname1, Key? key}) : super(key: key);

  @override
  State<AllSongs3> createState() => _AllSongs3State();
}

//List<dynamic> reverserecent = [];
List<dynamic> playlistsong6 = [];

class _AllSongs3State extends State<AllSongs3> {
  @override
  Widget build(BuildContext context) {
    final box1 = Boxes.getInstance();
    playlistsong6 = box1.get(widget.playlistname1)!;
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
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  final ispresent = playlistsong6.where((element) =>
                      element.id.toString() == dbsongs[index].id.toString());

                  if (ispresent.isEmpty) {
                    setState(() {
                      playlistsong6.add(dbsongs[index]);
                    });

                    await box1.put(widget.playlistname1, playlistsong6);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 12, top: 2, right: 12, bottom: 2),
                  child: Card(
                    color: Colors.white.withOpacity(.1),
                    child: playlist_tile(index, screenwidth),
                  ),
                ),
              );
            },
            itemCount: audioconvertedsongs.length,
          ),
        ),
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

  ListTile playlist_tile(int index, double screenwidth) {
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
                id: int.parse(audioconvertedsongs[index].metas.id.toString()),
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
                  audioconvertedsongs[index].metas.title!,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: screenwidth / 3,
                margin: const EdgeInsets.only(right: 13),
                child: audioconvertedsongs[index].metas.artist == '<unknown>'
                    ? const Text(
                        overflow: TextOverflow.ellipsis,
                        'unknown artist',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      )
                    : Text(
                        overflow: TextOverflow.ellipsis,
                        audioconvertedsongs[index].metas.artist!,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.white),
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
  }
}
