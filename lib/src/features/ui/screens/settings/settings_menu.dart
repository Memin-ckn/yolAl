import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yol_al/src/features/ui/screens/job_post/category_selection_page.dart';
import 'widgets/bildirim.dart';
import 'widgets/güvenlik.dart';
import 'widgets/diltercihi.dart';
import 'widgets/hesapbilgiler.dart';
import '../../../../common_widgets/bottom_nav_bar.dart';

class AyarlarPage extends StatefulWidget {
  const AyarlarPage({super.key});

  @override
  State<AyarlarPage> createState() => _AyarlarPageState();
}

class _AyarlarPageState extends State<AyarlarPage> {
  int _selectedIndex = 4; // Set to 4 since this is the settings tab

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;
    
    switch (index) {
      case 0:
        Get.offAll(() => CategorySelectionPage());
        break;
      case 2:
        Get.toNamed('/heatmap');
        break;
      case 3:
        Get.toNamed('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ayarlar"),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Hesap Bilgileri'),
            onTap: () {
              Get.to(() => HesapBilgiPage());
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Bildirimler'),
            onTap: () {
              Get.to(() => BildirimlerPage());
            },
          ),
          ListTile(
            leading: Icon(Icons.security),
            title: Text('Güvenlik'),
            onTap: () {
              Get.to(() => GuvenlikPage());
            },
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Dil Tercihi'),
            onTap: () {
              Get.to(() => DilTercihiPage());
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Yardım'),
            onTap: () {
              // Yardım sayfasına yönlendirme eklenebilir
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Çıkış Yap'),
            onTap: () {
              // Çıkış yapma işlemi eklenebilir
            },
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
