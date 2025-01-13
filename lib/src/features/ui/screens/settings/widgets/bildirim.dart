import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BildirimlerPage(),
    );
  }
}

class BildirimlerPage extends StatefulWidget {
  @override
  _BildirimlerPageState createState() => _BildirimlerPageState();
}

class _BildirimlerPageState extends State<BildirimlerPage> {
  bool _bildirimAcik = false; // Başlangıçta bildirimler kapalı

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bildirimler"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text("Bildirimleri Aç/Kapat"),
              trailing: Switch(
                value: _bildirimAcik,
                onChanged: (value) {
                  setState(() {
                    _bildirimAcik = value;
                  });
                  // Bildirim durumu değiştiğinde yapılacak işlemler
                  if (_bildirimAcik) {
                    print("Bildirimler Açık");
                  } else {
                    print("Bildirimler Kapalı");
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              _bildirimAcik ? "Bildirimler açık." : "Bildirimler kapalı.",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
