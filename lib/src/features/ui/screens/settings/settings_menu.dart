import 'package:flutter/material.dart';
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
  int _selectedIndex = 4; // Ayarlar sekmesi için 4. index

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HesapBilgiPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Bildirimler'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BildirimlerPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.security),
            title: Text('Güvenlik'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GuvenlikPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Dil Tercihi'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DilTercihiPage()),
              );
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
