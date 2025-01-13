import 'package:get/get.dart';
import '../models/job_model.dart';
import '../repositorys/job_repository.dart';

class HeatmapController extends GetxController {
  final JobRepository jobRepository;

  HeatmapController({required this.jobRepository});

  var jobs = <JobModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchJobs();
  }

  void fetchJobs() async {
    var fetchedJobs = await jobRepository.fetchJobs();
    jobs.value = fetchedJobs;
  }
}
