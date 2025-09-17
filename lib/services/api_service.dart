import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  /// Register user
  static Future<Map<String, dynamic>> registerUser(
    String fullName,
    String email,
    String phone,
    String password,
  ) async {
    final url = Uri.parse('$baseUrl/register');
    final body = {
      'name': fullName,
      'email': email,
      'phone': phone,
      'password': password,
    };

    print("Register Request: $body");

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    print("Register Response [${response.statusCode}]: ${response.body}");

    return jsonDecode(response.body);
  }

  /// Login user (email atau phone)
  static Future<Map<String, dynamic>> loginUser(
    String identifier, // bisa email atau no HP
    String password,
  ) async {
    final url = Uri.parse('$baseUrl/login');
    final body = {
      'identifier': identifier,
      'password': password,
    };

    print("Login Request: $body");

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    print("Login Response [${response.statusCode}]: ${response.body}");

    return jsonDecode(response.body);
  }

  /// Verifikasi OTP
  static Future<Map<String, dynamic>> verifyOtp(
    String email,
    String otp,
    String type,
  ) async {
    final url = Uri.parse("$baseUrl/verify-otp");
    final body = {"email": email, "otp": otp, "type": type};

    print("Verify OTP Request: $body");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    print("Verify OTP Response [${response.statusCode}]: ${response.body}");

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data["token"] != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", data["token"]);
      print("Token saved: ${data["token"]}");
    }

    return data;
  }

  /// Ambil token dari local storage
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    print("Get Token: $token");
    return token;
  }

  /// Logout user
  static Future<Map<String, dynamic>> userLogout() async {
    final token = await getToken();
    final url = Uri.parse("$baseUrl/logout");

    print("Logout Request with token: $token");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print("Logout Response [${response.statusCode}]: ${response.body}");

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove("token");
      print("Token removed from local storage");
    }

    return data;
  }
}
