import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../controllers/auth_controller.dart';
import 'otp_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final identifierCtrl = TextEditingController(); // login: email / phone
  final passCtrl = TextEditingController();
  final confirmPassCtrl = TextEditingController();

  bool _obscurePass = true;
  bool _obscureConfirmPass = true;
  bool _agreePolicy = false;

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
  }

  Future<void> _handleLogin(AuthController auth) async {
    if (identifierCtrl.text.isEmpty || passCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Isi Email/No HP dan Password")),
      );
      return;
    }

    await auth.login(identifierCtrl.text, passCtrl.text);

    if (!mounted) return;

    if (auth.message != null && auth.message!.toLowerCase().contains("otp")) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => OtpPage(email: identifierCtrl.text, type: "login"),
        ),
      );
    } else if (auth.message != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(auth.message!)));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Login gagal")));
    }
  }

  Future<void> _handleRegister(AuthController auth) async {
    if (nameCtrl.text.isEmpty ||
        emailCtrl.text.isEmpty ||
        phoneCtrl.text.isEmpty ||
        passCtrl.text.isEmpty ||
        confirmPassCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Harap lengkapi semua data")),
      );
      return;
    }

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(emailCtrl.text)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Format email tidak valid")));
      return;
    }

    if (passCtrl.text != confirmPassCtrl.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Konfirmasi password tidak cocok")),
      );
      return;
    }

    if (!_agreePolicy) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Anda harus menyetujui Syarat & Kebijakan X-COFFEE"),
        ),
      );
      return;
    }

    await auth.register(
      nameCtrl.text,
      emailCtrl.text,
      phoneCtrl.text,
      passCtrl.text,
    );

    if (!mounted) return;

    if (auth.message != null && auth.message!.toLowerCase().contains("otp")) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => OtpPage(email: emailCtrl.text, type: "register"),
        ),
      );
    } else if (auth.message != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(auth.message!)));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Registrasi gagal")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthController>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            SizedBox(
              width: double.infinity,
              height: 200,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/pattern_coffee_1.png',
                    fit: BoxFit.cover,
                  ),
                  Container(color: const Color(0xFFD32F2F).withOpacity(0.9)),
                  const Center(
                    child: Text(
                      "#GetXcited\nWithXcoffee",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Tab Masuk / Daftar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 60),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => isLogin = true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isLogin
                              ? const Color(0xFFD32F2F)
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          "Masuk",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isLogin ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => isLogin = false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: !isLogin
                              ? const Color(0xFFD32F2F)
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          "Daftar",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: !isLogin ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Form
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  if (!isLogin) ...[
                    _buildTextField(
                      controller: nameCtrl,
                      hint: "Nama Lengkap",
                      icon: Icons.person_outline,
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: emailCtrl,
                      hint: "E-mail",
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: phoneCtrl,
                      hint: "No. Handphone",
                      icon: Icons.phone_android,
                      keyboardType: TextInputType.phone,
                    ),
                  ],

                  if (isLogin)
                    _buildTextField(
                      controller: identifierCtrl,
                      hint: "No. Handphone / E-mail",
                      icon: Icons.account_circle_outlined,
                      keyboardType: TextInputType.text,
                    ),

                  const SizedBox(height: 15),
                  _buildTextField(
                    controller: passCtrl,
                    hint: "Kata Sandi",
                    icon: Icons.lock_outline,
                    obscure: _obscurePass,
                    onToggle: () {
                      setState(() => _obscurePass = !_obscurePass);
                    },
                  ),

                  if (!isLogin) ...[
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: confirmPassCtrl,
                      hint: "Konfirmasi Kata Sandi",
                      icon: Icons.lock_outline,
                      obscure: _obscureConfirmPass,
                      onToggle: () {
                        setState(
                          () => _obscureConfirmPass = !_obscureConfirmPass,
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: _agreePolicy,
                          activeColor: const Color(0xFFD32F2F),
                          onChanged: (value) {
                            setState(() => _agreePolicy = value ?? false);
                          },
                        ),
                        Expanded(
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black87,
                              ),
                              children: [
                                TextSpan(
                                  text: "Saya menyatakan setuju terhadap ",
                                ),
                                TextSpan(
                                  text: "Syarat Ketentuan",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                                TextSpan(text: " dan "),
                                TextSpan(
                                  text: "Kebijakan Privasi",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                                TextSpan(text: " X-COFFEE"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Tombol Login / Daftar
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD32F2F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: auth.isLoading
                    ? null
                    : () async {
                        if (isLogin) {
                          await _handleLogin(auth);
                        } else {
                          await _handleRegister(auth);
                        }
                      },
                child: auth.isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        isLogin ? "Masuk" : "Daftar",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 20),

            // Footer
            GestureDetector(
              onTap: () => setState(() => isLogin = !isLogin),
              child: Text.rich(
                TextSpan(
                  text: isLogin ? "Belum punya akun? " : "Sudah punya akun? ",
                  style: const TextStyle(color: Colors.black87),
                  children: [
                    TextSpan(
                      text: isLogin ? "Daftar" : "Masuk",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
    TextInputType keyboardType = TextInputType.text,
    VoidCallback? onToggle,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.grey),
        suffixIcon: onToggle != null
            ? IconButton(
                icon: Icon(
                  obscure ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: onToggle,
              )
            : null,
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
