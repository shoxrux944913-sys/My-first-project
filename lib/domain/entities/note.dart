// Чистая сущность. Просто данные.
class Note {
  final String id;
  final String title;
  final String text;

  Note({
    required this.id, 
    required this.text, 
    required this.title,
  });

  // ВАЖНО: Эти методы должны быть ВНУТРИ класса до последней скобки }
  
  // Создаем заметку из данных Firebase
  factory Note.fromMap(Map<String, dynamic> map, String documentId) {
    return Note(
      id: documentId,
      text: map['text'] ?? '',
      title: map['title'] ?? '',
    );
  }

  // Превращаем заметку в формат для отправки в Firebase
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'text': text,
    };
  }
} // Вот эта скобка должна быть в самом конце файла


