import 'package:flutter/material.dart';

class SpalshScreen extends StatelessWidget {
  const SpalshScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD71313), 
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/images/icon/xcoffee_splash_icon.png',
              width: 240, 
              height: 240, 
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}