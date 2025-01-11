import 'package:flutter/material.dart';
import '../models/is_model.dart';

class GecmisIslerPage extends StatelessWidget {
  final List<IsModel> isler = [
    IsModel(
      baslik: "İş Başlığı 1",
      tarih: "15.04.2024",
      durum: "Tamamlandı",
    ),
    IsModel(
      baslik: "İş Başlığı 2",
      tarih: "14.04.2024",
      durum: "Tamamlandı",
    ),
    // ... diğer işler
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Geçmiş İşler"),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: isler.length,
        itemBuilder: (context, index) {
          final is_ = isler[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Icon(Icons.work,
                  color: is_.durum == "Tamamlandı" ? Colors.blue : Colors.red),
              title: Text(is_.baslik),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Tarih: ${is_.tarih}"),
                  Text(
                    "Durum: ${is_.durum}",
                    style: TextStyle(
                      color:
                          is_.durum == "Tamamlandı" ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
