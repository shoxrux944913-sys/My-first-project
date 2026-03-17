import 'package:isar/isar.dart';
import '../../domain/entities/note.dart';
import '../../domain/repositories/note_repository.dart';
import '../models/note_model.dart';

class IsarNoteRepositoryImpl implements NoteRepository {
  final Isar isar;
  IsarNoteRepositoryImpl(this.isar);

  @override
  Future<List<Note>> getAllNotes() async {
    final models = await isar.noteModels.where().findAll();
    return models.map((m) => Note(
      id: m.id.toString(), // ПРЕВРАЩАЕМ int В String
      text: m.text, 
      title: m.title, // Добавил заголовок
    )).toList();
  }

  @override
  Future<void> addNote(String title, String text) async {
    final newNote = NoteModel()..text = text ..title = title;
    await isar.writeTxn(() => isar.noteModels.put(newNote));
  }

  @override
  Future<void> deleteNote(String id) async {
    // ПРЕВРАЩАЕМ String ОБРАТНО В int ДЛЯ ISAR
    final intId = int.tryParse(id); 
    if (intId != null) {
      await isar.writeTxn(() => isar.noteModels.delete(intId));
    }
  }
}

