import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HeatmapPage extends StatefulWidget {
  const HeatmapPage({Key? key}) : super(key: key);

  @override
  State<HeatmapPage> createState() => _HeatmapPageState();
}

class _HeatmapPageState extends State<HeatmapPage> {
  late GoogleMapController _mapController;
  final Set<Marker> _markers = {};
  final Set<Circle> _circles = {};

  @override
  void initState() {
    super.initState();
    _fetchJobListings();
  }

  /// Firebase'den verileri çek ve haritada göster
  Future<void> _fetchJobListings() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Firebase'den tüm iş ilanlarını al
      QuerySnapshot snapshot = await firestore.collection('jobListings').get();

      setState(() {
        for (var doc in snapshot.docs) {
          final data = doc.data() as Map<String, dynamic>;

          // currentLocation veya destination verisini kontrol et
          final locationField =
              data['currentLocation'] ?? data['destination'];
          if (locationField != null) {
            final coords = (locationField as String).split(',');
            if (coords.length == 2) {
              final double latitude = double.parse(coords[0].trim());
              final double longitude = double.parse(coords[1].trim());
              final LatLng position = LatLng(latitude, longitude);

              // Marker ekle
              _markers.add(
                Marker(
                  markerId: MarkerId(doc.id),
                  position: position,
                  infoWindow: InfoWindow(
                    title: data['type'] ?? 'Bilinmeyen Tip',
                    snippet: data['loadType'] ?? 'Yük bilgisi yok',
                  ),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    data['type'] == 'Nakliyeci'
                        ? BitmapDescriptor.hueBlue
                        : BitmapDescriptor.hueOrange,
                  ),
                ),
              );

              // Circle ekle (Isı Haritası)
              _circles.add(
                Circle(
                  circleId: CircleId(doc.id),
                  center: position,
                  radius: 500,
                  fillColor: Colors.red.withOpacity(0.3),
                  strokeColor: Colors.red,
                  strokeWidth: 1,
                ),
              );
            }
          }
        }
      });
    } catch (e) {
      print('Hata oluştu: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Harita ve İş İlanları'),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(41.0082, 28.9784), // İstanbul
          zoom: 12.0,
        ),
        markers: _markers,
        circles: _circles,
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mapController.animateCamera(
            CameraUpdate.newLatLng(
              const LatLng(41.0082, 28.9784), // İstanbul
            ),
          );
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
