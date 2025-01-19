import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormEmployerPage extends StatefulWidget {
  const FormEmployerPage({super.key});

  @override
  State<FormEmployerPage> createState() => _FormEmployerPageState();
}

class _FormEmployerPageState extends State<FormEmployerPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final TextEditingController loadTypeController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();

  String selectedMaterialType = 'Katı'; // Varsayılan seçim
  bool isSubmitting = false; // Gönderme işlemi kontrolü

  Future<void> submitForm() async {
    if (isSubmitting) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Zaten bir ilan gönderdiniz!')),
      );
      return;
    }

    final data = {
      'type': 'İşveren',
      'loadType': loadTypeController.text.trim(),
      'materialType': selectedMaterialType,
      'destination': destinationController.text.trim(),
      'timestamp': FieldValue.serverTimestamp(),
    };

    try {
      // Veri tabanında aynı ilanı kontrol et
      final querySnapshot = await firestore
          .collection('jobListings')
          .where('type', isEqualTo: 'İşveren')
          .where('loadType', isEqualTo: data['loadType'])
          .where('materialType', isEqualTo: data['materialType'])
          .where('destination', isEqualTo: data['destination'])
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
        const SnackBar(content: Text('İşveren ilanı başarıyla gönderildi!')),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('İşveren Formu'),
        backgroundColor: Colors.blue[400],
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildInputField('Taşınacak Yük', loadTypeController),
            const SizedBox(height: 20),
            _buildDropdownField('Madde Türü', ['Katı', 'Sıvı']),
            const SizedBox(height: 20),
            _buildInputField('Gideceği Yer', destinationController),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[400],
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

  Widget _buildDropdownField(String label, List<String> items) {
    return DropdownButtonFormField<String>(
      value: selectedMaterialType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        filled: true,
        fillColor: Colors.white,
      ),
      items: items
          .map((item) => DropdownMenuItem(
                value: item,
                child: Text(item),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedMaterialType = value!;
        });
      },
    );
  }
}
