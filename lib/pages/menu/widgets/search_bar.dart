import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Warna shadow
            spreadRadius: 2, // Jarak shadow
            blurRadius: 5, // Efek blur shadow
            offset: Offset(0, 3), // Posisi shadow (horizontal, vertical)
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Mau cari apa? ...",
          prefixIcon: const Icon(Icons.search, color: Colors.red),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
