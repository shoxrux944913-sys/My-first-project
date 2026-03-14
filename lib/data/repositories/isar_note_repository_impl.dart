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
    // Превращаем модели базы данных в чистые сущности Domain
    return models.map((m) => Note(id: m.id, text: m.text)).toList();
  }

  @override
  Future<void> addNote(String title, String text) async {
    final newNote = NoteModel()..text = text ..title = title;
    await isar.writeTxn(() => isar.noteModels.put(newNote));
  }

  @override
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.noteModels.delete(id));
  }
}

