import 'package:flutter/material.dart';
import 'package:flutter_application_2_dars/data/repositories/firestore_note_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/providers/note_provider.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Инициализация Isar
  //final dir = await getApplicationDocumentsDirectory();
  //final isar = await Isar.open([NoteModelSchema], directory: dir.path);

  runApp(
    ProviderScope(
      overrides: [
        // «Впрыскиваем» реальную реализацию репозитория
        noteRepositoryProvider.overrideWithValue(FirestoreNoteRepositoryImpl()),
      ],
      child: const MaterialApp(home: HomePage()),
    ),
  );
}


