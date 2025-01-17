/*import 'package:flutter/material.dart';
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

  FormCarrierPage({super.key});

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
*/
import 'package:flutter/material.dart';

class FormCarrierPage extends StatelessWidget {
  const FormCarrierPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taşıyıcı Formu'),
        backgroundColor: Colors.teal[300]!, // Yumuşak yeşil ton
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green[50]!, Colors.lime[50]!], // Soft uyumlu tonlar
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildInputField('Araç Türü', Icons.local_shipping),
              const SizedBox(height: 20),
              _buildInputField('Maksimum Yük Kapasitesi', Icons.line_weight),
              const SizedBox(height: 20),
              _buildInputField('Plaka Numarası', Icons.directions_car),
              const SizedBox(height: 20),
              _buildInputField('Şu Anki Konum', Icons.location_on),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Form gönderme işlemi
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[300]!,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  elevation: 4,
                  shadowColor: Colors.grey[300],
                ),
                child: const Text(
                  'Gönder',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, IconData icon) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.teal[300]!),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
