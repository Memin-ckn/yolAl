import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditListingPage extends StatefulWidget {
  final String docId; // Düzenlenecek belgenin ID'si
  final Map<String, dynamic> currentData; // Mevcut veri

  const EditListingPage({super.key, required this.docId, required this.currentData});

  @override
  State<EditListingPage> createState() => _EditListingPageState();
}

class _EditListingPageState extends State<EditListingPage> {
  late TextEditingController loadTypeController;
  late TextEditingController materialTypeController;
  late TextEditingController destinationController;
  late TextEditingController vehicleTypeController;
  late TextEditingController maxCapacityController;
  late TextEditingController plateNumberController;
  late TextEditingController currentLocationController;

  @override
  void initState() {
    super.initState();
    // Mevcut verileri kontrolcülere atama
    loadTypeController = TextEditingController(text: widget.currentData['loadType'] ?? '');
    materialTypeController = TextEditingController(text: widget.currentData['materialType'] ?? '');
    destinationController = TextEditingController(text: widget.currentData['destination'] ?? '');
    vehicleTypeController = TextEditingController(text: widget.currentData['vehicleType'] ?? '');
    maxCapacityController = TextEditingController(text: widget.currentData['maxCapacity'] ?? '');
    plateNumberController = TextEditingController(text: widget.currentData['plateNumber'] ?? '');
    currentLocationController = TextEditingController(text: widget.currentData['currentLocation'] ?? '');
  }

  Future<void> _updateListing() async {
    final updatedData = {
      if (widget.currentData['type'] == 'Nakliyeci') ...{
        'vehicleType': vehicleTypeController.text.trim(),
        'maxCapacity': maxCapacityController.text.trim(),
        'plateNumber': plateNumberController.text.trim(),
        'currentLocation': currentLocationController.text.trim(),
      },
      if (widget.currentData['type'] == 'İşveren') ...{
        'loadType': loadTypeController.text.trim(),
        'materialType': materialTypeController.text.trim(),
        'destination': destinationController.text.trim(),
      },
    };

    try {
      await FirebaseFirestore.instance
          .collection('jobListings')
          .doc(widget.docId)
          .update(updatedData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('İlan başarıyla güncellendi!')),
      );
      Navigator.pop(context); // Düzenleme sonrası geri dön
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hata: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.currentData['type']} İlanını Düzenle'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (widget.currentData['type'] == 'Nakliyeci') ...[
                _buildInputField('Araç Türü', vehicleTypeController),
                const SizedBox(height: 16),
                _buildInputField('Maksimum Yük Kapasitesi', maxCapacityController),
                const SizedBox(height: 16),
                _buildInputField('Plaka Numarası', plateNumberController),
                const SizedBox(height: 16),
                _buildInputField('Konum', currentLocationController),
              ],
              if (widget.currentData['type'] == 'İşveren') ...[
                _buildInputField('Taşınacak Yük', loadTypeController),
                const SizedBox(height: 16),
                _buildInputField('Madde Türü', materialTypeController),
                const SizedBox(height: 16),
                _buildInputField('Gideceği Yer', destinationController),
              ],
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _updateListing,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
                child: const Text(
                  'Kaydet',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
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
        fillColor: Colors.grey[200],
      ),
    );
  }
}
