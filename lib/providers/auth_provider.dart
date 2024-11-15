import 'package:flutter/material.dart';
import '../db/database_helper.dart';

class AuthProvider with ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  bool _isAuthenticated = false;
  int? _userId; // Armazena o ID do usuário logado
  String? _loggedUserEmail;

  bool get isAuthenticated => _isAuthenticated;
  int? get userId => _userId; // Getter para o ID do usuário
  String? get loggedUserEmail => _loggedUserEmail;

  /// Registrar um novo usuário com e-mail e senha.
  Future<bool> registerUser(Map<String, dynamic> usuario) async {
    try {
      await _databaseHelper.insertUser(usuario);
      return true;
    } catch (e) {
      print('Erro ao registrar usuário: $e');
      return false;
    }
  }

  /// Fazer login com e-mail e senha.
  Future<bool> login(String email, String senha) async {
    try {
      final user = await _databaseHelper.getUserByEmail(email);

      if (user != null && user['password'] == senha) {
        _isAuthenticated = true;
        _userId = user['id']; // Armazena o ID do usuário
        _loggedUserEmail = email;
        notifyListeners();
        return true;
      } else {
        return false; // Login falhou
      }
    } catch (e) {
      print('Erro no login: $e');
      return false;
    }
  }

  /// Sair da sessão.
  void logout() {
    _isAuthenticated = false;
    _userId = null;
    _loggedUserEmail = null;
    notifyListeners();
  }
}
