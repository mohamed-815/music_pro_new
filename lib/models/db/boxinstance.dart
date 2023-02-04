import 'package:hive/hive.dart';

class Boxes {
  static Box<List>? _box;
  static Box<List> getInstance() {
    return _box = Hive.box('db_totalsongs');
  }
}
