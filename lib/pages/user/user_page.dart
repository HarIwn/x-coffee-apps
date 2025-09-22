import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x_coffee_app/controllers/auth_controller.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthController>(context);
    final userName = (auth.userName != null && auth.userName!.isNotEmpty)
        ? auth.userName
        : "Kopians";

    final screenWidth = MediaQuery.of(context).size.width;

    // Skala font responsif berdasarkan lebar layar
    double scaleFont(double size) => size * (screenWidth / 375);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Bagian atas pakai Stack
              Stack(
                children: [
                  // Background merah + pattern
                  Container(
                    height: 180,
                    decoration: const BoxDecoration(color: Color(0xFFD71313)),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Opacity(
                            opacity: 1,
                            child: Image.asset(
                              "assets/images/pattern/pattern_coffee_1.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Konten profil
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 24,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Foto profil
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              radius: 36,
                              backgroundImage: Image.asset(
                                "assets/images/img_09-21-25.png",
                              ).image,
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Info user
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "$userName",
                                  style: TextStyle(
                                    fontSize: scaleFont(18),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.phone,
                                      size: 14,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      "0812 3455 7891",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: scaleFont(12),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Poin saya : 0/100",
                                  style: TextStyle(
                                    fontSize: scaleFont(12),
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                LinearProgressIndicator(
                                  value: 0,
                                  backgroundColor: Colors.white24,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                ),
                              ],
                            ),
                          ),

                          // Tombol Tukar Hadiah
                          // Tombol Tukar Hadiah
                          SizedBox(
                            height: 32,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.red,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 2,
                              ),
                              onPressed: () {},
                              child: Text(
                                "Tukar Hadiah",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: scaleFont(11),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Bagian bawah menu
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildMenuItem(Icons.settings, "Pengaturan Akun", scaleFont),
                  _buildMenuItem(
                    Icons.notifications,
                    "Sesuaikan Notifikasi",
                    scaleFont,
                  ),
                  _buildMenuItem(
                    Icons.description,
                    "Syarat & Ketentuan",
                    scaleFont,
                  ),
                  _buildMenuItem(Icons.star, "Beri nilai kami!", scaleFont),
                  _buildMenuItem(
                    Icons.support_agent,
                    "Pusat Bantuan X-COFFEE",
                    scaleFont,
                  ),
                  _buildMenuItem(Icons.shield, "Kebijakan Privasi", scaleFont),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      "Keluar",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red[700],
                        fontSize: scaleFont(16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title,
    double Function(double) scaleFont,
  ) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.black87),
          title: Text(title, style: TextStyle(fontSize: scaleFont(14))),
          onTap: () {},
        ),
        const Divider(height: 1),
      ],
    );
  }
}
