import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/bildirim.dart';
import 'widgets/güvenlik.dart';
import 'widgets/diltercihi.dart';
import 'widgets/hesapbilgiler.dart';

class AyarlarPage extends StatefulWidget {
  const AyarlarPage({super.key});

  @override
  State<AyarlarPage> createState() => _AyarlarPageState();
}

class _AyarlarPageState extends State<AyarlarPage> {

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
      )
    );
  }
}
