import 'package:flutter/material.dart';

class SnackBar1 {
  final favoriteadd = SnackBar(
    backgroundColor: const Color.fromARGB(255, 27, 40, 37),
    duration: const Duration(seconds: 1),
    content: const Text(
      'Added to favorite',
      style: TextStyle(
          fontFamily: "poppinz",
          fontWeight: FontWeight.bold,
          color: Colors.white),
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
  );

  final removefavorite = SnackBar(
    backgroundColor: const Color.fromARGB(255, 27, 40, 37),
    duration: const Duration(seconds: 1),
    content: const Text(
      'removed from favorite',
      style: TextStyle(fontFamily: "poppinz", fontWeight: FontWeight.bold),
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
  );
  final addedtoplaylist = SnackBar(
    backgroundColor: const Color.fromARGB(255, 27, 40, 37),
    duration: const Duration(seconds: 1),
    content: const Text(
      'added to playlist',
      style: TextStyle(fontFamily: "poppinz", fontWeight: FontWeight.bold),
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
  );

  final removedfromplaylist = SnackBar(
    backgroundColor: const Color.fromARGB(255, 27, 40, 37),
    duration: const Duration(seconds: 1),
    content: const Text(
      'removed from favorite',
      style: TextStyle(fontFamily: "poppinz", fontWeight: FontWeight.bold),
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
  );

  final notificationenabled = SnackBar(
    backgroundColor: const Color.fromARGB(255, 27, 40, 37),
    duration: const Duration(seconds: 1),
    content: const Text(
      'notification enabled',
      style: TextStyle(fontFamily: "poppinz", fontWeight: FontWeight.bold),
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
  );

  final notificationdisabled = SnackBar(
    backgroundColor: const Color.fromARGB(255, 27, 40, 37),
    duration: const Duration(seconds: 1),
    content: const Text(
      'removed from favorite',
      style: TextStyle(fontFamily: "poppinz", fontWeight: FontWeight.bold),
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
  );

  final playlistcreated = SnackBar(
    backgroundColor: const Color.fromARGB(255, 27, 40, 37),
    duration: const Duration(seconds: 1),
    content: const Text(
      'playlist created',
      style: TextStyle(fontFamily: "poppinz", fontWeight: FontWeight.bold),
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
  );

  final playlistdeleted = SnackBar(
    backgroundColor: const Color.fromARGB(255, 27, 40, 37),
    duration: const Duration(seconds: 1),
    content: const Text(
      'deleted successfully',
      style: TextStyle(fontFamily: "poppinz", fontWeight: FontWeight.bold),
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
  );
  final playlistedited = SnackBar(
    backgroundColor: const Color.fromARGB(255, 27, 40, 37),
    duration: const Duration(seconds: 1),
    content: const Text(
      'play list edited',
      style: TextStyle(fontFamily: "poppinz", fontWeight: FontWeight.bold),
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
  );
}
