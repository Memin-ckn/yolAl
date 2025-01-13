import 'package:flutter/material.dart';


class GuvenlikPage extends StatefulWidget {
  const GuvenlikPage({super.key});

  @override
  GuvenlikPageState createState() => GuvenlikPageState();
}

class GuvenlikPageState extends State<GuvenlikPage> {
  final _formKey = GlobalKey<FormState>();

  // TextEditingController'lar
  final _mevcutSifreController = TextEditingController();
  final _yeniSifreController = TextEditingController();
  final _sifreTekrarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Güvenlik"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Form anahtarı
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Mevcut Şifre
              TextFormField(
                controller: _mevcutSifreController,
                decoration: InputDecoration(
                  labelText: "Mevcut Şifre",
                ),
                obscureText: true, // Şifreyi gizler
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mevcut şifre alanı boş olamaz';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Yeni Şifre
              TextFormField(
                controller: _yeniSifreController,
                decoration: InputDecoration(
                  labelText: "Yeni Şifre",
                ),
                obscureText: true, // Şifreyi gizler
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Yeni şifre alanı boş olamaz';
                  }
                  if (value.length < 6) {
                    return 'Şifre en az 6 karakter olmalıdır';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Şifreyi Tekrarla
              TextFormField(
                controller: _sifreTekrarController,
                decoration: InputDecoration(
                  labelText: "Şifreyi Tekrarla",
                ),
                obscureText: true, // Şifreyi gizler
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Şifreyi tekrar giriniz';
                  }
                  if (value != _yeniSifreController.text) {
                    return 'Şifreler eşleşmiyor';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Kaydet Butonu
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Şifre doğrulama işlemleri
                    print("Mevcut Şifre: ${_mevcutSifreController.text}");
                    print("Yeni Şifre: ${_yeniSifreController.text}");
                    print("Şifreler Eşleşti");

                    // Şifre güncelleme işlemi yapılabilir
                  }
                },
                child: Text("Şifreyi Güncelle"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
