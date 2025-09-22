import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x_coffee_app/controllers/auth_controller.dart';
import 'package:x_coffee_app/pages/favorite/favorite_page.dart';
import 'package:x_coffee_app/pages/home/widgets/ads_swiper.dart';
import 'package:x_coffee_app/pages/home/widgets/card_produk.dart';
import 'package:x_coffee_app/pages/home/widgets/category_produk.dart';
import 'package:x_coffee_app/pages/menu/menu_page.dart';
import 'package:x_coffee_app/pages/order/order_page.dart';
import 'package:x_coffee_app/pages/user/user_page.dart';
import 'package:x_coffee_app/pages/widget/bottom_nav.dart';

class HomePage extends StatefulWidget {
  final String? token;
  const HomePage({super.key, this.token});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeContent(),
    MenuPage(),
    OrderPage(),
    FavoritePage(),
    UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: _pages[_selectedIndex]),
      bottomNavigationBar: BottomNav(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthController>(context);
    final userName = (auth.userName != null && auth.userName!.isNotEmpty)
        ? auth.userName
        : "Kopians";

    final products = [
      {
        "image": "assets/images/product/produk.png",
        "title": "Hazelnut Latte",
        "stock": 10,
        "rating": 4.5,
        "price": 8000,
      },
      {
        "image": "assets/images/product/produk.png",
        "title": "Caramel Macchiato",
        "stock": 5,
        "rating": 4.7,
        "price": 12000,
      },
      {
        "image": "assets/images/product/produk.png",
        "title": "Cappuccino",
        "stock": 8,
        "rating": 4.3,
        "price": 10000,
      },
      {
        "image": "assets/images/product/produk.png",
        "title": "X Siganture",
        "stock": 8,
        "rating": 4.3,
        "price": 10000,
      },
    ];

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        SizedBox(
          height: 180, // tinggi area stack
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Background merah + pattern
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFD71313),
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/pattern/pattern_coffee_1.png',
                    ),
                    fit: BoxFit.cover,
                    repeat: ImageRepeat.repeat,
                    opacity: 1,
                  ),
                ),
              ),

              // Lokasi + Notifikasi
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                child: Positioned(
                  top: 20,
                  child: Row(
                    children: [
                      // Lokasi (memanjang)
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "lokasi kamu...",
                            prefixIcon: const Icon(
                              Icons.location_on,
                              color: Colors.red,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Notifikasi
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.white,
                        child: const Icon(
                          Icons.notifications,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Card
              Positioned(
                left: 10,
                right: 10,
                top: 90,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Color(0xFFD71313), width: 5),
                  ),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // Teks dan progress
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hi, ${userName}!",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "Poin saya : 0/100 ",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            backgroundColor: Colors.white,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                    top: Radius.circular(16),
                                                  ),
                                            ),
                                            builder: (_) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 24,
                                                    ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Center(
                                                      child: Container(
                                                        width: 80,
                                                        height: 4,
                                                        decoration: BoxDecoration(
                                                          color:
                                                              Colors.grey[400],
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                2,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 26),
                                                    const Text(
                                                      "Tentang Xcoffee Point",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    const Text(
                                                      "Poin Anda akan bertambah setiap kali melakukan transaksi. "
                                                      "Setelah mencapai jumlah tertentu, Anda bisa menukarnya dengan hadiah menarik!",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 24),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: const Icon(
                                          Icons.info_outline,
                                          size: 16,
                                          color: Color(0xFFD71313),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: LinearProgressIndicator(
                                  value: 0, // Progres poin (0-1) config
                                  minHeight: 8,
                                  backgroundColor: Colors.grey[300],
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                        Color(0xFFD71313),
                                      ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                "Tukar poin dengan hadiah yang menarik!",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFD71313),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                ),
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.card_giftcard,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                label: const Text(
                                  "Tukar Sekarang",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 16),

                        // Gambar di kanan
                        Container(
                          width: 64,
                          height: 64,
                          decoration: const BoxDecoration(
                            color: Color(0xFFD71313),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(
                            'assets/images/icon/xcoffee_point_icon.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 120),
        const AdsSwiper(),
        const SizedBox(height: 36),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ProductCategory(
            categories: const [
              "Best Seller",
              "Coffee",
              "Non Coffee",
              "Cemilan",
              "Promo",
            ],
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 220,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            separatorBuilder: (_, __) => const SizedBox(width: 2),
            itemBuilder: (context, index) {
              final p = products[index];
              return ProductCard(
                imageUrl: p["image"] as String,
                title: p["title"] as String,
                stock: p["stock"] as int,
                rating: p["rating"] as double,
                price: p["price"] as int,
              );
            },
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
