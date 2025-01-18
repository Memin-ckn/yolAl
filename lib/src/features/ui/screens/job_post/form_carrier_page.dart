import 'package:flutter/material.dart';

class FormCarrierPage extends StatelessWidget {
  const FormCarrierPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taşıyıcı Formu'),
        backgroundColor: Colors.teal[300]!, // Yumuşak yeşil ton
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green[50]!, Colors.lime[50]!], // Soft uyumlu tonlar
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildInputField('Araç Türü', Icons.local_shipping),
              const SizedBox(height: 20),
              _buildInputField('Maksimum Yük Kapasitesi', Icons.line_weight),
              const SizedBox(height: 20),
              _buildInputField('Plaka Numarası', Icons.directions_car),
              const SizedBox(height: 20),
              _buildInputField('Şu Anki Konum', Icons.location_on),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Form gönderme işlemi
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[300]!,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  elevation: 4,
                  shadowColor: Colors.grey[300],
                ),
                child: const Text(
                  'Gönder',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, IconData icon) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.teal[300]!),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
