/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/job_controller.dart';
import '../models/job_model.dart';

class FormEmployerPage extends StatelessWidget {
  final JobController jobController = Get.put(JobController());
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController materialTypeController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();

  FormEmployerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('İş Veren Formu')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Taşınacak Yük'),
            ),
            TextField(
              controller: materialTypeController,
              decoration: InputDecoration(labelText: 'Madde Türü (Katı/Sıvı)'),
            ),
            TextField(
              controller: destinationController,
              decoration: InputDecoration(labelText: 'Gideceği Yer'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final job = JobModel(
                  id: '1', // İş veren ID
                  category: 'employer',
                  description: descriptionController.text,
                  materialType: materialTypeController.text,
                  destination: destinationController.text, 
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
}*/
import 'package:flutter/material.dart';

class FormEmployerPage extends StatelessWidget {
  const FormEmployerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('İşveren Formu'),
        backgroundColor: Colors.blue[400], // Yumuşak mavi ton
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue[50]!,
              Colors.lightBlue[50]!
            ], // Soft mavi tonları
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildInputField('Taşınacak Yük', Icons.inventory),
              const SizedBox(height: 20),
              _buildDropdownField('Madde Türü', ['Katı', 'Sıvı']),
              const SizedBox(height: 20),
              _buildInputField('Gideceği Yer', Icons.location_city),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Form gönderme işlemi
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[400],
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
        prefixIcon: Icon(icon, color: Colors.blue[400]),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> items) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        filled: true,
        fillColor: Colors.white,
      ),
      items: items
          .map((item) => DropdownMenuItem(
                value: item,
                child: Text(item),
              ))
          .toList(),
      onChanged: (value) {
        // Dropdown seçimi işlemi
      },
    );
  }
}
