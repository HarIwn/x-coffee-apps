import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';

class AuthController with ChangeNotifier {
  String? _message;
  String? get message => _message;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _token;
  String? get token => _token;

  // Ambil nama pengguna
  String? _userName;
  String? get userName => _userName;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Register User
  Future<void> register(
    String name,
    String email,
    String phone,
    String password,
  ) async {
    _setLoading(true);
    final res = await ApiServices.registerUser(name, email, phone, password);
    _message = res["message"] ?? res.toString();
    notifyListeners();
    _setLoading(false);
  }

  /// Login User
  Future<void> login(String email, String password) async {
    _setLoading(true);
    final res = await ApiServices.loginUser(email, password);
    _message = res["message"] ?? res.toString();

    if (res["user"] != null) {
      _userName = res["user"]["name"];
      await _saveUserName(_userName!); // simpan ke local storage
    }

    notifyListeners();
    _setLoading(false);
  }

  /// simpan nama ke local storage
  Future<void> _saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("user_name", name);
  }

  Future<String?> getUserName() async {
    if (_userName != null) return _userName;
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("user_name");
  }

  /// Verifikasi OTP
  Future<void> verifyOtp(String email, String otp, String type) async {
    _setLoading(true);
    final res = await ApiServices.verifyOtp(email, otp, type);

    _message = res["message"] ?? res.toString();

    if (res["token"] != null) {
      _token = res["token"];
      await _saveToken(_token!); // simpan token ke local storage
    }

    if (res["user"] != null) {
      _userName = res["user"]["name"];
      print("Nama pengguna setelah OTP: $_userName");
    }

    notifyListeners();
    _setLoading(false);
  }

  /// Logout
  Future<void> logout() async {
    final res = await ApiServices.userLogout();

    if (res["message"] != null) {
      _message = "Berhasil logout (token: $_token)";
    } else {
      _message = res.toString();
    }

    _token = null;
    await _clearToken(); // hapus dari local storage
    notifyListeners();
  }

  /// Resend OTP
  Future<void> resendOtp(String email, String type) async {
    _setLoading(true);

    try {
      final response = await http.post(
        Uri.parse("http://127.0.0.1:8000/api/resend-otp"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "type": type}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _message = data["message"] ?? "Kode OTP berhasil dikirim ulang.";
      } else {
        _message = data["message"] ?? "Gagal mengirim ulang OTP.";
      }
    } catch (e) {
      _message = "Terjadi kesalahan: $e";
    }

    _setLoading(false);
  }

  /// Token Handler

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("auth_token", token);
  }

  Future<String?> getToken() async {
    if (_token != null) return _token;
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("auth_token");
  }

  Future<void> _clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("auth_token");
  }

  void setLoading(bool bool) {}
}
