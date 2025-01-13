import 'package:flutter/material.dart';
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
}
