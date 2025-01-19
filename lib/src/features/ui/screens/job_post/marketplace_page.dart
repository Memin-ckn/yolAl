import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({super.key});

  @override
  State<MarketplacePage> createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String selectedFilter = 'Tümü'; // Filtreleme için seçili tür
  String searchQuery = ''; // Arama sorgusu

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marketplace'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Filtreleme Dropdown
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField<String>(
              value: selectedFilter,
              decoration: const InputDecoration(
                labelText: 'Filtrele',
                border: OutlineInputBorder(),
              ),
              items: ['Tümü', 'Nakliyeci', 'İşveren']
                  .map((filter) => DropdownMenuItem(
                        value: filter,
                        child: Text(filter),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedFilter = value!;
                });
              },
            ),
          ),
          // Arama Çubuğu
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value.trim();
                });
              },
              decoration: const InputDecoration(
                labelText: 'Ara',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          // İlanları Listeleme
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _filteredStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('Filtreye uygun ilan bulunamadı.'));
                }

                final jobs = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: jobs.length,
                  itemBuilder: (context, index) {
                    final job = jobs[index];
                    final jobData = job.data() as Map<String, dynamic>;
                    final docId = job.id;

                    return FutureBuilder<DocumentSnapshot>(
                      future: firestore.collection('favorites').doc(docId).get(),
                      builder: (context, favoriteSnapshot) {
                        final isFavorite = favoriteSnapshot.data?.exists ?? false;

                        return ListTile(
                          leading: Icon(
                            jobData['type'] == 'Nakliyeci'
                                ? Icons.local_shipping
                                : Icons.business,
                            color: jobData['type'] == 'Nakliyeci' ? Colors.teal : Colors.blue,
                          ),
                          title: Text('${jobData['type']} İlanı'),
                          subtitle: Text(jobData['loadType'] ?? jobData['vehicleType'] ?? 'Detay Yok'),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.favorite,
                              color: isFavorite ? Colors.red : Colors.grey,
                            ),
                            onPressed: () => _toggleFavorite(docId),
                          ),
                          onTap: () => _showDetailsDialog(context, jobData),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Firebase'den dinamik filtreleme ve arama sorgusu
  Stream<QuerySnapshot> _filteredStream() {
    final collection = firestore.collection('jobListings');
    Query query = collection;

    if (selectedFilter != 'Tümü') {
      query = query.where('type', isEqualTo: selectedFilter);
    }

    if (searchQuery.isNotEmpty) {
      query = query.where('loadType', isGreaterThanOrEqualTo: searchQuery);
    }

    return query.snapshots();
  }

  // Favori Ekleme/Kaldırma
  Future<void> _toggleFavorite(String docId) async {
    final favoriteDoc = firestore.collection('favorites').doc(docId);

    final snapshot = await favoriteDoc.get();

    if (snapshot.exists) {
      await favoriteDoc.delete();
    } else {
      await favoriteDoc.set({'docId': docId});
    }

    setState(() {});
  }

  // Detaylar Dialog
  void _showDetailsDialog(BuildContext context, Map<String, dynamic> job) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('${job['type']} İlanı Detayları'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (job['type'] == 'Nakliyeci') ...[
                _buildDetailRow('Araç Türü', job['vehicleType']),
                _buildDetailRow('Taşıma Kapasitesi', job['maxCapacity']),
                _buildDetailRow('Plaka Numarası', job['plateNumber']),
                _buildDetailRow('Konum', job['currentLocation']),
              ],
              if (job['type'] == 'İşveren') ...[
                _buildDetailRow('Taşınacak Yük', job['loadType']),
                _buildDetailRow('Madde Türü', job['materialType']),
                _buildDetailRow('Gideceği Yer', job['destination']),
              ],
              _buildDetailRow('Eklenme Tarihi',
                  (job['timestamp'] as Timestamp?)?.toDate().toString() ?? 'Belirtilmedi'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Kapat'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value ?? 'Belirtilmedi'),
          ),
        ],
      ),
    );
  }
}
