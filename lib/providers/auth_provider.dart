import 'package:flutter/material.dart';
import '../db/database_helper.dart';

class AuthProvider with ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  bool _isAuthenticated = false;
  int? _userId;
  String? _loggedUserEmail;

  bool get isAuthenticated => _isAuthenticated;

  int? get userId => _userId;

  String? get loggedUserEmail => _loggedUserEmail;

  Future<bool> registerUser(Map<String, dynamic> usuario) async {
    try {
      await _databaseHelper.insertUser(usuario);
      return true;
    } catch (e) {
      print('Erro ao registrar usuário: $e');
      return false;
    }
  }

  Future<bool> login(String email, String senha) async {
    try {
      final user = await _databaseHelper.getUserByEmail(email);

      if (user != null && user['password'] == senha) {
        _isAuthenticated = true;
        _userId = user['id'];
        _loggedUserEmail = email;
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Erro no login: $e');
      return false;
    }
  }

  void logout() {
    _isAuthenticated = false;
    _userId = null;
    _loggedUserEmail = null;
    notifyListeners();
  }
}
