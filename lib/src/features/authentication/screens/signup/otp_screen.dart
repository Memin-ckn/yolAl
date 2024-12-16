import 'package:flutter/material.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose(); // Controller'ı temizle
    super.dispose();
  }

  void _verifyOTP() {
    final otp = _otpController.text.trim();
    if (otp.isNotEmpty) {
      // Burada OTP doğrulama işlemi yapılır
      print('Girilen OTP: $otp');
      // Firebase OTP doğrulama kodu buraya eklenebilir
    } else {
      // Hata mesajı göster
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen OTP kodunu giriniz!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Doğrulama'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Lütfen telefonunuza gönderilen OTP kodunu girin:',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'OTP Kodu',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _verifyOTP,
              child: const Text('Doğrula'),
            ),
          ],
        ),
      ),
    );
  }
}
