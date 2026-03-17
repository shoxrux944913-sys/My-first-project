import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/note.dart';
import '../../domain/repositories/note_repository.dart';

class FirestoreNoteRepositoryImpl implements NoteRepository {
  // Подключаемся к коллекции в облаке Firebase
  final CollectionReference _collection = 
      FirebaseFirestore.instance.collection('notes');

  @override
  Future<List<Note>> getAllNotes() async {
    final snapshot = await _collection.get();
    return snapshot.docs.map((doc) {
      // Используем тот самый fromMap, который мы написали в Note
      return Note.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  @override
  Future<void> addNote(String title, String text) async {
    // Отправляем данные в облако
    await _collection.add({
      'title': title,
      'text': text,
      'createdAt': FieldValue.serverTimestamp(), // Бонус: время создания
    });
  }

  @override
  Future<void> deleteNote(String id) async {
    // Удаляем документ по его String ID
    await _collection.doc(id).delete();
  }
}