import 'package:flutter/material.dart';
import 'package:flutter_application_2_dars/data/repositories/firestore_note_repository_impl.dart';
import 'package:flutter_application_2_dars/presentation/pages/auth_gate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/providers/note_provider.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'presentation/providers/auth_provider.dart';
import 'data/repositories/firebase_auth_repository_impl.dart';
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
         noteRepositoryProvider.overrideWithValue(FirestoreNoteRepositoryImpl()),

         authRepositoryProvider.overrideWithValue(FirebaseAuthRepositoryImpl()),
      ], 
      child: const MaterialApp(home: AuthGate()),
    ),
  );
}


