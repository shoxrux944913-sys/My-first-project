import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'register_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      // Слушаем состояние: вошел юзер или нет
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Если в snapshot есть данные — юзер залогинен
        if (snapshot.hasData) {
          return const HomePage();
        }
        // Если данных нет — отправляем на регистрацию
        return const RegisterPage();
      },
    );
  }
}