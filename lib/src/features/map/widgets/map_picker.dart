import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geocoding; 
//import 'package:flutter_google_places/flutter_google_places.dart';
//import 'package:google_maps_webservice/places.dart' as places; 

class MapPicker extends StatefulWidget {
  final Function(LatLng) onLocationSelected;
  final LatLng? initialLocation;

  const MapPicker({
    super.key,
    required this.onLocationSelected,
    this.initialLocation,
  });

  @override
  State<MapPicker> createState() => _MapPickerState();
}

class _MapPickerState extends State<MapPicker> {
  LatLng? selectedLocation;
  late GoogleMapController mapController;

  @override
  void initState() {
    super.initState();
    selectedLocation = widget.initialLocation;
  }

  void _searchAddress(String address) async {
    try {
      List<geocoding.Location> locations = await geocoding.locationFromAddress(address);
      if (locations.isNotEmpty) {
        final location = locations.first;
        final newPosition = LatLng(location.latitude, location.longitude);

        mapController.animateCamera(
          CameraUpdate.newLatLng(newPosition),
        );

        setState(() {
          selectedLocation = newPosition;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Adres bulunamadı!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: selectedLocation ?? LatLng(41.0082, 28.9784), 
                zoom: 12.0,
              ),
              markers: selectedLocation != null
                  ? {
                      Marker(
                        markerId: const MarkerId('selected-location'),
                        position: selectedLocation!,
                      ),
                    }
                  : {},
              onTap: (LatLng position) {
                setState(() {
                  selectedLocation = position;
                });
              },
              onMapCreated: (controller) {
                mapController = controller;
              },
            ),
            Positioned(
              top: 10,
              left: 10,
              right: 10,
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Adres Ara',
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (value) {
                  _searchAddress(value); 
                },
              ),
            ),
            Positioned(
              bottom: 10,
              left: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedLocation != null) {
                    widget.onLocationSelected(selectedLocation!);
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Lütfen bir konum seçin!')),
                    );
                  }
                },
                child: const Text('Konumu Seç'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
