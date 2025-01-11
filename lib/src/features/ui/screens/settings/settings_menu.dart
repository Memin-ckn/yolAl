import 'package:flutter/material.dart';
import 'Settings/bildirim.dart';
import 'Settings/güvenlik.dart';
import 'Settings/diltercihi.dart';
import 'Settings/hesapbilgiler.dart';

class AyarlarPage extends StatelessWidget {
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
    );
  }
}
