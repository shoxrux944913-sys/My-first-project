import 'package:isar/isar.dart';
part 'note_model.g.dart';

@Collection()
class NoteModel {
  Id id = Isar.autoIncrement;
  late String title;
  late String text;
}

