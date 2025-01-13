import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/job_controller.dart';
import '../models/job_model.dart';

class FormEmployerPage extends StatelessWidget {
  final JobController jobController = Get.put(JobController());
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController materialTypeController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();

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
}
