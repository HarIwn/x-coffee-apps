import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:x_coffee_app/controllers/auth_controller.dart';
import 'package:x_coffee_app/pages/home/home_page.dart';

class OtpPage extends StatefulWidget {
  final String email;
  final String type; // "login" atau "register"

  const OtpPage({super.key, required this.email, required this.type});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final otpCtrl = TextEditingController();
  String otpCode = "";
  int _seconds = 60;
  Timer? _timer;
  bool _isResending = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    setState(() => _seconds = 60);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        setState(() => _seconds--);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    otpCtrl.dispose();
    super.dispose();
  }

  Future<void> _resendOtp(BuildContext context) async {
    setState(() => _isResending = true);

    final auth = Provider.of<AuthController>(context, listen: false);
    await auth.resendOtp(widget.email, widget.type);

    setState(() => _isResending = false);

    if (auth.message != null && auth.message!.contains("berhasil")) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(auth.message!)));
      _startTimer();
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(auth.message ?? "Gagal mengirim ulang OTP")),
      );
    }
  }

  Future<void> _verifyOtp(BuildContext context) async {
    if (otpCode.length < 6) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Kode OTP harus 6 digit")));
      return;
    }

    final auth = Provider.of<AuthController>(context, listen: false);

    print(
      "Verifikasi OTP ($otpCode) untuk ${widget.email} (${widget.type})",
    );

    await auth.verifyOtp(widget.email, otpCode, widget.type);

    // Wajib hapus di production
    print("Token setelah verify: ${auth.token}");
    print("Message: ${auth.message}");
    print("Username: ${auth.userName}");

    if (auth.token != null) {
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => HomePage(token: auth.token!)),
        (route) => false,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(auth.message ?? "Berhasil diverifikasi")),
      );
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(auth.message ?? "Verifikasi gagal")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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

          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            decoration: BoxDecoration(
              color: const Color(0xFFD32F2F),
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Text(
              "Input Kode OTP",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Info pengiriman otp email
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  height: 1.5,
                ),
                children: [
                  const TextSpan(text: "Kami mengirimkan kode ke "),
                  TextSpan(
                    text: widget.email,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const TextSpan(
                    text: "\nPastikan alamat email yang diinput telah sesuai!",
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Input OTP
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: PinCodeTextField(
              appContext: context,
              length: 6,
              controller: otpCtrl,
              animationType: AnimationType.fade,
              keyboardType: TextInputType.number,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(8),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Colors.grey[200],
                selectedFillColor: Colors.grey[200],
                inactiveFillColor: Colors.grey[200],
                activeColor: Colors.grey,
                selectedColor: Colors.red,
                inactiveColor: Colors.grey,
              ),
              enableActiveFill: true,
              onChanged: (value) => setState(() => otpCode = value),
            ),
          ),

          const SizedBox(height: 30),

          // Verifikasi
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD32F2F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () => _verifyOtp(context),
                    child: const Text(
                      "Verifikasi",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Timer / Resend kode otp
                _seconds > 0
                    ? Text(
                        "Kode verifikasi akan kadaluwarsa 00:${_seconds.toString().padLeft(2, '0')}",
                        style: const TextStyle(fontSize: 12),
                      )
                    : GestureDetector(
                        onTap: _isResending ? null : () => _resendOtp(context),
                        child: _isResending
                            ? const SizedBox(
                                height: 15,
                                width: 15,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                "Kirim ulang kode",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
