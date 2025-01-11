import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DilTercihiPage(),
    );
  }
}

class DilTercihiPage extends StatefulWidget {
  @override
  _DilTercihiPageState createState() => _DilTercihiPageState();
}

class _DilTercihiPageState extends State<DilTercihiPage> {
  String _seciliDil = "Türkçe"; // Varsayılan dil Türkçe

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dil Tercihi"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Lütfen bir dil seçin:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Türkçe seçeneği
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _seciliDil = "Türkçe";
                    });
                  },
                  child: Container(
                    width: 150,
                    height: 100,
                    decoration: BoxDecoration(
                      color: _seciliDil == "Türkçe"
                          ? Colors.blue
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Türkçe",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _seciliDil == "Türkçe"
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                // İngilizce seçeneği
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _seciliDil = "English";
                    });
                  },
                  child: Container(
                    width: 150,
                    height: 100,
                    decoration: BoxDecoration(
                      color: _seciliDil == "English"
                          ? Colors.blue
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "English",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _seciliDil == "English"
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Seçilen Dil: $_seciliDil",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
