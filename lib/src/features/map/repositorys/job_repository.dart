import '../models/job_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JobRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<JobModel>> fetchJobs() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('Jobs').get();

      return snapshot.docs.map((doc) => JobModel.fromJson(doc.data())).toList();
    } catch (e) {
      print('Error fetching jobs: $e');
      return [];
    }
  }
}
