import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: Colors.white, // seluruh page putih
      appBar: AppBar(
        backgroundColor: const Color(0xFFD71313),
        elevation: 2,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          product["title"],
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Gambar produk
          SizedBox(
            height: 220,
            child: PageView(
              children: [
                Image.network(product["image"], fit: BoxFit.cover),
                Image.network(product["image"], fit: BoxFit.cover),
                Image.network(product["image"], fit: BoxFit.cover),
              ],
            ),
          ),

          // Info produk
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product["title"],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      Text(
                        product["rating"].toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Terjual 4",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        "Rp. ${product["price"]}",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Tab bar Deskripsi & Review
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.black,
              tabs: const [
                Tab(text: "Deskripsi"),
                Tab(text: "Review"),
              ],
            ),
          ),

          // Konten Tab
          Expanded(
            child: Container(
              color: Colors.white,
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Tab Deskripsi
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: const Text(
                      "description",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ),

                  // Tab Review
                  Container(
                    color: Colors.white,
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        _buildReviewItem(
                          "Anonymous",
                          "5.0",
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                          "1 hari yang lalu",
                        ),
                        _buildReviewItem(
                          "Anonymous",
                          "4.0",
                          "Vestibulum ante ipsum primis in faucibus orci luctus.",
                          "3 hari yang lalu",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Tombol aksi
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.black12)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border),
                  label: const Text(
                    "Favorit",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(width: 50),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.share),
                  label: const Text(
                    "Bagikan",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFD71313),
                  minimumSize: const Size(double.infinity, 48),
                ),
                onPressed: () {},
                child: const Text(
                  "Tambahkan ke keranjang",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewItem(
    String user,
    String rating,
    String review,
    String time,
  ) {
    return Card(
      color: Colors.white, // pastikan card putih
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=3"),
        ),
        title: Row(
          children: [
            Text(user, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            Text(
              "$rating ★",
              style: const TextStyle(fontSize: 12, color: Colors.amber),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(review),
            const SizedBox(height: 4),
            Text(
              time,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
