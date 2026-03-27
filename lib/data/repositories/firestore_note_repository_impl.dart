import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/note.dart';
import '../../domain/repositories/note_repository.dart';

class FirestoreNoteRepositoryImpl implements NoteRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Вспомогательный метод, чтобы получать путь к личным заметкам юзера
  CollectionReference get _userNotes {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('Пользователь не авторизован');
    }
    // Путь: users / {ID_ЮЗЕРА} / notes
    return _firestore.collection('users').doc(user.uid).collection('notes');
  }

  @override
  Future<List<Note>> getAllNotes() async {
    try {
      final snapshot = await _userNotes.get();
      return snapshot.docs.map((doc) {
        return Note.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      print('Ошибка при получении заметок: $e');
      return [];
    }
  }

  @override
  Future<void> addNote(String title, String text) async {
    try {
      await _userNotes.add({
        'title': title,
        'text': text,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Ошибка при добавлении заметки: $e');
    }
  }

  @override
  Future<void> deleteNote(String id) async {
    try {
      await _userNotes.doc(id).delete();
    } catch (e) {
      print('Ошибка при удалении заметки: $e');
    }
  }
}