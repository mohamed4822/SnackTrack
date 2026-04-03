import 'package:flutter/material.dart';
import 'package:health_assistant/services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService;

  AuthViewModel(this._authService);

  bool isLoading = false;

  Future<void> login(String email, String password) async {
    isLoading = true;
    notifyListeners();

    await _authService.login(email, password);

    isLoading = false;
    notifyListeners();
  }
}