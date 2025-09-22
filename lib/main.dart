import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:x_coffee_app/controllers/auth_controller.dart';
import 'package:x_coffee_app/pages/Auth/auth_page.dart';
import 'package:x_coffee_app/pages/home/home_page.dart';

import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("token");

  // Buat instance AuthController
  final authController = AuthController();

  // Overlay system
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xFFD71313), // Merah
      statusBarIconBrightness: Brightness.light, // Icon putih
      systemNavigationBarColor: Colors.white, // NavBar putih
      systemNavigationBarIconBrightness: Brightness.dark, // Icon hitam
    ),
  );

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthController())],
      child: MyApp(
        initialRoute: token != null ? "/home" : "/auth",
        authController: authController,
        token: token,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  final String? token;
  final AuthController authController;

  const MyApp({
    super.key,
    required this.initialRoute,
    this.token,
    required this.authController,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      routes: {
        "/auth": (_) => HomePage(),
        "/home": (_) => HomePage(token: token),
      },
    );
  }
}
