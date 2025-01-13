import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/job_model.dart';

class FormJobRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addJob(JobModel job) async {
    try {
      await _firestore.collection('jobs').add(job.toJson());
    } catch (e) {
      Get.snackbar('Error', 'Error adding job: $e');
    }
  }
}
