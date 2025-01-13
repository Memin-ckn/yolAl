import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/job_controller.dart';
import '../models/job_model.dart';

class FormCarrierPage extends StatelessWidget {
  final JobController jobController = Get.put(JobController());
  final TextEditingController vehicleTypeController = TextEditingController();
  final TextEditingController maxLoadController = TextEditingController();
  final TextEditingController plateNumberController = TextEditingController();
  final TextEditingController currentLocationController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Taşıyıcı Formu')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: vehicleTypeController,
              decoration: InputDecoration(labelText: 'Araç Türü'),
            ),
            TextField(
              controller: maxLoadController,
              decoration: InputDecoration(labelText: 'Maksimum Yük Kapasitesi'),
            ),
            TextField(
              controller: plateNumberController,
              decoration: InputDecoration(labelText: 'Plaka Numarası'),
            ),
            TextField(
              controller: currentLocationController,
              decoration: InputDecoration(labelText: 'Şu Anki Konum'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final job = JobModel(
                  id: '2', // Taşıyıcı ID
                  category: 'carrier',
                  description: 'Taşıyıcı Formu',
                  vehicleType: vehicleTypeController.text,
                  maxLoadCapacity: double.tryParse(maxLoadController.text) ?? 0,
                  plateNumber: plateNumberController.text,
                  currentLocation: currentLocationController.text,
                  title: '',
                );
                jobController.submitJob(job);
              },
              child: Text('Kaydet'),
            ),
          ],
        ),
      ),
    );
  }
}
