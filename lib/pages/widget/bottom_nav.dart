import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.red[700],
        // borderRadius: const BorderRadius.only(
        //   topLeft: Radius.circular(30),
        //   topRight: Radius.circular(30),
        // ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            splashFactory: NoSplash.splashFactory, // hilangkan ripple
            highlightColor: Colors.transparent,    // hilangkan highlight
            hoverColor: Colors.transparent,        // hilangkan hover hitam
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.red[700],
            currentIndex: currentIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.red[200],
            showSelectedLabels: true,
            showUnselectedLabels: true,
            enableFeedback: false, // hilangkan suara/vibrasi klik
            selectedIconTheme: const IconThemeData(size: 24),
            unselectedIconTheme: const IconThemeData(size: 24),
            selectedLabelStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
            onTap: onTap,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
              BottomNavigationBarItem(icon: Icon(Icons.fastfood), label: "Produk"),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long),
                label: "Pesanan",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: "Disukai",
              ),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: "Akun"),
            ],
          ),
        ),
      ),
    );
  }
}