import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/note_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesAsync = ref.watch(notesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Clean Notes')),
      body: notesAsync.when(
        data: (notes) => ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(notes[index].text),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => ref.read(notesProvider.notifier).deleteNote(notes[index].id),
            ),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Ошибка: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(BuildContext context, WidgetRef ref) {
    final textController = TextEditingController();
    final titleController = TextEditingController();
   showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Новая заметка'),
      content: Column(
        mainAxisSize: MainAxisSize.min, 
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: 'Заголовок'),
          ),
          TextField(
            controller: textController,
            decoration: const InputDecoration(hintText: 'Текст заметки'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            ref.read(notesProvider.notifier).addNote(
                  titleController.text, 
                  textController.text,
                );
            Navigator.pop(context);
          },
          child: const Text('Добавить'),
        ),
      ],
    ),
  );
  }
}