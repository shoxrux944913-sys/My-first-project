import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/note.dart';
import '../../domain/repositories/note_repository.dart';

// 1. Провайдер для Репозитория (чтобы его можно было легко подменить)
final noteRepositoryProvider = Provider<NoteRepository>((ref) {
  throw UnimplementedError(); // Инициализируем в main.dart
});

// 2. Нотификатор, который работает ТОЛЬКО с репозиторием
class NoteNotifier extends AsyncNotifier<List<Note>> {
  @override
  Future<List<Note>> build() async {
    return ref.read(noteRepositoryProvider).getAllNotes();
  }

  Future<void> addNote(String title, String text) async {
    state = const AsyncLoading();
    await ref.read(noteRepositoryProvider).addNote(title, text);
    state = AsyncData(await ref.read(noteRepositoryProvider).getAllNotes());
  }

  Future<void> deleteNote(String id) async {
    await ref.read(noteRepositoryProvider).deleteNote(id);
    state = AsyncData(await ref.read(noteRepositoryProvider).getAllNotes());
  }
}

final notesProvider = AsyncNotifierProvider<NoteNotifier, List<Note>>(NoteNotifier.new);

