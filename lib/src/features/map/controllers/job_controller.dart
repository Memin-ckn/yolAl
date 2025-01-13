import 'package:get/get.dart';
import '../repositorys/form_job_repository.dart';
import '../models/job_model.dart';

class JobController extends GetxController {
  final FormJobRepository _repository = FormJobRepository();

  Future<void> submitJob(JobModel job) async {
    await _repository.addJob(job);
    Get.snackbar('Başarılı', 'Form başarıyla kaydedildi!');
  }
}
