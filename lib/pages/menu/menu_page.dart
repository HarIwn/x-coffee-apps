import 'package:flutter/material.dart';
import 'package:x_coffee_app/pages/menu/widgets/category_filter.dart';
import 'package:x_coffee_app/pages/menu/widgets/product_card.dart';
import 'package:x_coffee_app/pages/menu/widgets/search_bar.dart';
import 'package:x_coffee_app/pages/menu/product/detail_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String selectedCategory = "Kopi";

  // Dummy data produk
  final List<Map<String, dynamic>> products = [
    {
      "title": "Hazelnut Latte",
      "price": 8000,
      "stock": 10,
      "rating": 4.5,
      "image":
          "https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=500",
    },
    {
      "title": "Americano",
      "price": 8000,
      "stock": 10,
      "rating": 4.5,
      "image":
          "https://images.unsplash.com/photo-1559056199-641a0ac8b55e?w=500",
    },
    {
      "title": "Coffee Milk",
      "price": 8000,
      "stock": 10,
      "rating": 4.5,
      "image":
          "https://awsimages.detik.net.id/community/media/visual/2024/05/06/kopi-susu-1.jpeg?w=1200",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black,
        elevation: 2.0,
        backgroundColor: const Color(0xFFD71313),
        title: const Text("Menu", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: SearchBarWidget(),
            ),
        
            // Filter kategori
            CategoryFilter(
              categories: const ["Kopi", "Snack", "Non kopi"],
              selected: selectedCategory,
              onSelected: (c) {
                setState(() {
                  selectedCategory = c;
                });
              },
            ),
        
            const SizedBox(height: 16),
        
            // Grid produk
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 kolom
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    final p = products[index];
                    return ProductCard(
                      title: p["title"],
                      price: p["price"],
                      stock: p["stock"],
                      rating: p["rating"],
                      imageUrl: p["image"],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailPage(product: p),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
