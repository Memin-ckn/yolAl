import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../map/widgets/map_picker.dart'; 

class FormCarrierPage extends StatefulWidget {
  const FormCarrierPage({super.key});

  @override
  State<FormCarrierPage> createState() => _FormCarrierPageState();
}

class _FormCarrierPageState extends State<FormCarrierPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final TextEditingController vehicleTypeController = TextEditingController();
  final TextEditingController maxCapacityController = TextEditingController();
  final TextEditingController plateNumberController = TextEditingController();
  LatLng? currentLocation; // Seçilen konum için değişken

  bool isSubmitting = false; // Gönderim işlemi kontrolü

  Future<void> submitForm() async {
    if (isSubmitting) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Zaten bir ilan gönderdiniz!')),
      );
      return;
    }

    final data = {
      'type': 'Nakliyeci',
      'vehicleType': vehicleTypeController.text.trim(),
      'maxCapacity': maxCapacityController.text.trim(),
      'plateNumber': plateNumberController.text.trim(),
      'currentLocation': currentLocation != null
          ? '${currentLocation!.latitude}, ${currentLocation!.longitude}'
          : 'Konum Belirtilmedi',
      'timestamp': FieldValue.serverTimestamp(),
    };

    try {
      // Veri tabanında aynı ilanı kontrol et
      final querySnapshot = await firestore
          .collection('jobListings')
          .where('type', isEqualTo: 'Nakliyeci')
          .where('vehicleType', isEqualTo: data['vehicleType'])
          .where('maxCapacity', isEqualTo: data['maxCapacity'])
          .where('plateNumber', isEqualTo: data['plateNumber'])
          .where('currentLocation', isEqualTo: data['currentLocation'])
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Bu ilan zaten mevcut!')),
        );
        return;
      }

      setState(() {
        isSubmitting = true; // Gönderim işlemini kilitle
      });

      await firestore.collection('jobListings').add(data);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nakliyeci ilanı başarıyla gönderildi!')),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hata oluştu: $e')),
      );
    } finally {
      setState(() {
        isSubmitting = false; // Gönderim kilidini kaldır
      });
    }
  }

  Future<void> _pickLocation() async {
    await showDialog(
      context: context,
      builder: (context) => MapPicker(
        onLocationSelected: (LatLng location) {
          setState(() {
            currentLocation = location;
          });
        },
        initialLocation: currentLocation,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taşıyıcı Formu'),
        backgroundColor: Colors.teal[300],
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildInputField('Araç Türü', vehicleTypeController),
            const SizedBox(height: 20),
            _buildInputField('Maksimum Yük Kapasitesi', maxCapacityController),
            const SizedBox(height: 20),
            _buildInputField('Plaka Numarası', plateNumberController),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickLocation,
              child: Text(
                currentLocation != null
                    ? 'Seçilen Konum: ${currentLocation!.latitude}, ${currentLocation!.longitude}'
                    : 'Şu Anki Konumu Seç',
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[300],
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
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
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
