/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'form_carrier_page.dart';
import 'form_employer_page.dart';

class CategorySelectionPage extends StatelessWidget {
  const CategorySelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kategori Seçimi')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.to(() => FormCarrierPage()); // Taşıyıcı formuna yönlendir
              },
              child: Text('Taşıyıcı'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => FormEmployerPage()); // İş veren formuna yönlendir
              },
              child: Text('İş Veren'),
            ),
          ],
        ),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'form_carrier_page.dart';
import 'form_employer_page.dart';

class CategorySelectionPage extends StatelessWidget {
  const CategorySelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategori Seçimi'),
        backgroundColor: Colors.teal[400], // Pastel yeşil bir renk
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.teal[50]!,
              Colors.blueGrey[50]!
            ], // Soft ve uyumlu tonlar
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCategoryButton(
                context,
                'Taşıyıcı',
                Icons.local_shipping,
                Colors.teal[300]!,
                () => Get.to(() => FormCarrierPage()),
              ),
              const SizedBox(height: 20),
              _buildCategoryButton(
                context,
                'İş Veren',
                Icons.business,
                Colors.lightBlue[300]!,
                () => Get.to(() => FormEmployerPage()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryButton(BuildContext context, String title, IconData icon,
      Color color, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 28, color: Colors.white),
      label: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 4,
        shadowColor: Colors.grey[300],
      ),
    );
  }
}
