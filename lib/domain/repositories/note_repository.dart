import '../entities/note.dart';

// Интерфейс. Мы просто говорим, ЧТО приложение должно уметь.
abstract class NoteRepository {
  Future<List<Note>> getAllNotes();
  Future<void> addNote(String title, String text);
  Future<void> deleteNote(int id);
} 

