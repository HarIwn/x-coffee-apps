import 'package:flutter/material.dart';
import 'package:x_coffee_app/pages/order/widgets/order_filter.dart';
import 'package:x_coffee_app/pages/order/widgets/order_card.dart';
import 'package:x_coffee_app/pages/order/utils/order_dummy.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  String selectedFilter = "Semua Transaksi";

  @override
  Widget build(BuildContext context) {
    // Filter data sesuai tab
    final filteredOrders = selectedFilter == "Semua Transaksi"
        ? dummyOrders
        : dummyOrders.where((o) => o["status"] == selectedFilter).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFD71313),
        title: const Text(
          "Transaksi",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 2,
        shadowColor: Colors.black,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            // Filter Tabs
            OrderFilter(
              selected: selectedFilter,
              onSelected: (f) {
                setState(() {
                  selectedFilter = f;
                });
              },
            ),
            const SizedBox(height: 8),

            // List Transaksi
            Expanded(
              child: filteredOrders.isEmpty
                  ? Center(
                      child: Text(
                        "Tidak ada yang ${selectedFilter.toLowerCase()}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: filteredOrders.length,
                      itemBuilder: (context, index) {
                        return OrderCard(order: filteredOrders[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
