import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_pro_1/db/allsongstoringclass.dart';
import 'package:music_pro_1/db/boxinstance.dart';
import 'package:music_pro_1/db/dbfetching.dart';
import 'package:music_pro_1/db/dbsongcontroller/dbsongcontroller.dart';
import 'package:music_pro_1/presentation/favorite/favorite.dart';
import 'package:music_pro_1/presentation/playlist/playlistcontroller.dart';
import 'package:music_pro_1/presentation/splashscreen/spalashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

PlayListController playListController = Get.put(PlayListController());
DbSongController dbSongController = Get.put(DbSongController());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await ScreenUtil.ensureScreenSize();
  Hive.registerAdapter(AllSongsAdapter());
  await Hive.openBox<List>('db_totalsongs');
  await dbSongController.fetchSongs();
  final favoritebox = Boxes.getInstance();
  List<dynamic> favBox = favoritebox.keys.toList();
  if (!favBox.contains("favorite")) {
    List<dynamic> favMusic = [];
    await favoritebox.put("favorite", favMusic);
  }
  if (!favBox.contains("recent1")) {
    List<dynamic> favMusic = [];
    await favoritebox.put("recent1", favMusic);
  }

  favoriteController.favoritesongs = favoritebox.get('favorite')!;
  final playlistbox = Boxes.getInstance();
  // final pref = await SharedPreferences.getInstance();
  // await pref.setBool('isturnon', false);

  // final Pref1 = await SharedPreferences.getInstance();
  // final notificationon = Pref1.getBool('isturnon')!;
  await dbSongController.sheredprefenrenceinitialseting();
  dbSongController.sheredprefenrenceinitial();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
