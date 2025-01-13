import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA), // @color/background
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 75.0),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
              const SizedBox(height: 16.0),
              Image.asset(
                'assets/forgot_password.png', // @drawable/forgot_password
                height: 300.0,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 50.0),
              _buildTextField(
                hintText: 'Lütfen e-postanızı girin',
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  // Kod gönderme işlemi
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(14.0),
                  textStyle: const TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Poppins',
                  ),
                ),
                child: const Text('Kod Gönder'),
              ),
              const SizedBox(height: 32.0),
              Center(
                child: Text(
                  'Kalan Süre 03:00',
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required IconData prefixIcon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle:
            const TextStyle(color: Color(0xFF9E9E9E)), // @color/soft_tertiary
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(prefixIcon, color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(20.0),
      ),
      style: const TextStyle(
        fontSize: 19.0,
        color: Colors.black,
        fontFamily: 'Poppins',
      ),
    );
  }
}
