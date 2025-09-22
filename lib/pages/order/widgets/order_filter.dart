import 'package:flutter/material.dart';

class OrderFilter extends StatelessWidget {
  final String selected;
  final Function(String) onSelected;

  const OrderFilter({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final filters = ["Semua Transaksi", "Diproses", "Dikirim", "Selesai"];

    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final f = filters[index];
          final isActive = f == selected;
          return GestureDetector(
            onTap: () => onSelected(f),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFFD71313) : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text(
                f,
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
