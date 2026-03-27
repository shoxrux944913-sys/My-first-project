import 'package:flutter/material.dart';
import '../providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Для ConsumerStatefulWidget
// Обязательно этот импорт, чтобы увидеть authStateProvider

// Заменяем StatefulWidget на ConsumerStatefulWidget
class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Слушаем состояние регистрации (загрузка, ошибка или успех)
    final authState = ref.watch(authNotifierProvider);

    // Слушаем ошибки и показываем SnackBar
    ref.listen<AsyncValue<void>>(authNotifierProvider, (previous, next) {
      next.whenOrNull(
        error: (e, st) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: $e')),
        ),
        data: (_) {
          // Если регистрация прошла успешно — переходим на главную
          Navigator.of(context).pushReplacementNamed('/home');
        },
      );
    });

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView( // Добавляем, чтобы клавиатура не закрывала поля
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email')),
              TextField(controller: _passwordController, decoration: const InputDecoration(labelText: 'Password')),
              const SizedBox(height: 20),
              
              // Если идет загрузка — кнопка исчезает, появляется крутилка
              authState.maybeWhen(
                loading: () => const CircularProgressIndicator(),
                orElse: () => ElevatedButton(
                  onPressed: () {
                    ref.read(authNotifierProvider.notifier).signUp(
                      _emailController.text.trim(),
                      _passwordController.text.trim(),
                    );
                  },
                  child: const Text('Зарегистрироваться'),
                ),
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }
}