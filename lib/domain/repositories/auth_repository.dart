abstract class AuthRepository {
  // Метод для создания нового аккаунта
  Future<void> signUp(String email, String password);

  // Метод для входа в существующий аккаунт
  Future<void> signIn(String email, String password);

  // Метод для выхода из системы
  Future<void> signOut();
}