import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'form_carrier_page.dart';
import 'form_employer_page.dart';
import '../../../../common_widgets/bottom_nav_bar.dart';

class CategorySelectionPage extends StatefulWidget {
  const CategorySelectionPage({super.key});

  @override
  CategorySelectionPageState createState() => CategorySelectionPageState();
}

class CategorySelectionPageState extends State<CategorySelectionPage> {
  final int _selectedIndex = 0;

  void _onItemTapped(int index) {
  if (index == _selectedIndex) return;
  
  switch (index) {
    case 1:
      Get.toNamed('/marketplace');
      break;
    case 2:
      Get.toNamed('/heatmap');
      break;
    case 3:
      Get.toNamed('/profile');
      break;
    case 4:
      Get.toNamed('/settings');
      break;
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategori Seçimi'),
        backgroundColor: Colors.teal[400],
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal[50]!, Colors.blueGrey[50]!],
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
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
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
