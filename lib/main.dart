import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'data/models/note_model.dart';
import 'data/repositories/isar_note_repository_impl.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/providers/note_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Инициализация Isar
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([NoteModelSchema], directory: dir.path);

  runApp(
    ProviderScope(
      overrides: [
        // «Впрыскиваем» реальную реализацию репозитория
        noteRepositoryProvider.overrideWithValue(IsarNoteRepositoryImpl(isar)),
      ],
      child: const MaterialApp(home: HomePage()),
    ),
  );
}


