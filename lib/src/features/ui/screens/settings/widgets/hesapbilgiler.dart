import 'package:flutter/material.dart';

class HesapBilgiPage extends StatefulWidget {
  const HesapBilgiPage({super.key});

  @override
  HesapBilgiPageState createState() => HesapBilgiPageState();
}

class HesapBilgiPageState extends State<HesapBilgiPage> {
  late Future<Map<String, String>> _kullaniciBilgileri;

  @override
  void initState() {
    super.initState();
    _kullaniciBilgileri =
        _veriGetir(); // Kullanıcı verilerini simüle eden fonksiyon
  }

  // Simüle edilmiş bir veri getirme fonksiyonu
  Future<Map<String, String>> _veriGetir() async {
    await Future.delayed(Duration(seconds: 2)); // Simüle edilen gecikme
    return {
      "ad": "",
      "soyad": "",
      "kullaniciAdi": "",
      "email": "",
      "telefon": "",
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hesap Bilgileri"),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<Map<String, String>>(
        future: _kullaniciBilgileri,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Hata: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            final kullanici = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Ad: ${kullanici["ad"]}",
                      style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Text("Soyad: ${kullanici["soyad"]}",
                      style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Text("Kullanıcı Adı: ${kullanici["kullaniciAdi"]}",
                      style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Text("E-posta: ${kullanici["email"]}",
                      style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Text("Telefon: ${kullanici["telefon"]}",
                      style: TextStyle(fontSize: 18)),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Bilgi güncelleme ya da başka bir işlem yapılabilir
                      print("Bilgiler güncellenecek");
                    },
                    child: Text("Bilgileri Güncelle"),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text("Bilgi bulunamadı."));
          }
        },
      ),
    );
  }
}
