import 'package:get/state_manager.dart';
import 'package:music_pro_1/funtion.dart';

class MainScreenController extends GetxController {
  final SongList = [
    Songs1(
        title: 'Favorite',
        image:
            //'assets/black-brick-wall-background-600w-709530229.webp'
            "assets/unnamed.jpg"),
    Songs1(
        title: 'Play List',
        image:
            // 'assets/black-brick-wall-background-600w-709530229.webp'
            "assets/headphone-music-hd-wallpaper-for-mobile-3831409.png"),
    Songs1(
        title: 'Recents',
        image:
            //'assets/black-brick-wall-background-600w-709530229.webp'
            "assets/photo-1531651008558-ed1740375b39.jpg"),
  ].obs;
}
