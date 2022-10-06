import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

import 'package:music_pro_1/play%20list/addplaylist.dart';
import 'package:music_pro_1/play%20list/favorite.dart';
import 'package:music_pro_1/play%20list/recent.dart';
import 'package:music_pro_1/settings.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Drawer1 extends StatelessWidget {
  const Drawer1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenhieght = MediaQuery.of(context).size.height;
    final double screenwidth = MediaQuery.of(context).size.width;
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 33, 50, 52),
      child: ListView(
        children: [
          SizedBox(
            height: screenhieght / 20,
          ),
          Center(
            child: GradientText(
              'MUSIC PRO',
              colors: const [
                Color.fromARGB(255, 125, 184, 170),
                Color.fromARGB(255, 116, 91, 91)
              ],
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: screenhieght / 20,
          ),
          GestureDetector(
            onTap: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: ((context) => const Recent1()))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.white.withOpacity(.1),
                child: const ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 76, 114, 118),
                    child: Icon(Icons.recent_actors),
                  ),
                  title: Text(
                    'Recent',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: ((context) => const AddPlayList()))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.white.withOpacity(.1),
                child: const ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 76, 114, 118),
                    child: Icon(Icons.playlist_add),
                  ),
                  title: Text(
                    'PlayList',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: ((context) => const Favorites()))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.white.withOpacity(.1),
                child: const ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 76, 114, 118),
                    child: Icon(Icons.favorite),
                  ),
                  title: Text(
                    'Favorite',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: ((context) => const Settings()))),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                color: Colors.white.withOpacity(.1),
                child: const ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 76, 114, 118),
                    child: Icon(Icons.settings),
                  ),
                  title: Text(
                    'Settings',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
