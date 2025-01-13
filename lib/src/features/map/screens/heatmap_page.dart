import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../controllers/heatmap_controller.dart';
import '../repositorys/job_repository.dart';

class HeatMapPage extends StatelessWidget {
  final HeatmapController heatmapController =
      Get.put(HeatmapController(jobRepository: JobRepository()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Isı Haritası')),
      body: Obx(() {
        if (heatmapController.jobs.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        // Koordinatlar listesi
        List<LatLng> positions = heatmapController.jobs.map((job) {
          return LatLng(job.latitude, job.longitude);
        }).toList();

        return GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(41.0082, 28.9784), // İstanbul
            zoom: 12.0,
          ),
          markers: positions.map((position) {
            return Marker(
              markerId: MarkerId(position.toString()),
              position: position,
            );
          }).toSet(),
        );
      }),
    );
  }
}
