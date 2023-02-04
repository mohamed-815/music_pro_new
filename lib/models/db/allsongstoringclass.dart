import 'package:hive/hive.dart';
part 'allsongstoringclass.g.dart';

@HiveType(typeId: 0)
class AllSongs extends HiveObject {
  @HiveField(0)
  String? uri;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? artist;
  @HiveField(3)
  int? duration;
  @HiveField(4)
  int? id;
  AllSongs({
    required this.uri,
    required this.title,
    required this.artist,
    required this.duration,
    required this.id,
  });
}
