import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repositories/auth_repository.dart';

class FirebaseAuthRepositoryImpl implements AuthRepository {
  // Наш "пульт управления" от Firebase Auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<void> signUp(String email, String password) async {
    // Команда Firebase: создай юзера с такой почтой и паролем
    await _auth.createUserWithEmailAndPassword(
      email: email, 
      password: password,
    );
  }

  @override
  Future<void> signIn(String email, String password) async {
    // Команда Firebase: проверь почту и пароль и впусти
    await _auth.signInWithEmailAndPassword(
      email: email, 
      password: password,
    );
  }

  @override
  Future<void> signOut() async {
    // Команда Firebase: выйти из аккаунта
    await _auth.signOut();
  }
}