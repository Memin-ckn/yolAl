import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorilerim'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: _buildFavorites(),
    );
  }

  Widget _buildFavorites() {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('favorites').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('Henüz favorilere eklenmiş ilan yok.'));
        }

        final favoriteDocs = snapshot.data!.docs;

        return ListView(
          children: favoriteDocs.map((favoriteDoc) {
            final docId = favoriteDoc['docId'];

            return FutureBuilder<DocumentSnapshot>(
              future: firestore.collection('jobListings').doc(docId).get(),
              builder: (context, jobSnapshot) {
                if (!jobSnapshot.hasData || !jobSnapshot.data!.exists) {
                  return const SizedBox.shrink(); // İlan silinmişse gösterme
                }

                final jobData = jobSnapshot.data!.data() as Map<String, dynamic>;

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Icon(
                      jobData['type'] == 'Nakliyeci' ? Icons.local_shipping : Icons.business,
                      color: jobData['type'] == 'Nakliyeci' ? Colors.teal : Colors.blue,
                    ),
                    title: Text('${jobData['type']} İlanı'),
                    subtitle: Text(jobData['loadType'] ?? jobData['vehicleType'] ?? 'Detay yok'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await firestore.collection('favorites').doc(docId).delete();
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}
