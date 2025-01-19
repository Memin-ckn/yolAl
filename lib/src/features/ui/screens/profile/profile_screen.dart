import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yol_al/src/features/ui/screens/job_post/category_selection_page.dart';
import '../../../../common_widgets/bottom_nav_bar.dart';
import '../profile/edit_listing_page.dart';

class HesabimPage extends StatefulWidget {
  const HesabimPage({super.key});

  @override
  State<HesabimPage> createState() => HesabimPageState();
}

class HesabimPageState extends State<HesabimPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  int _selectedIndex = 3; // Profile tab index

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    switch (index) {
      case 0:
        Get.offAll(() => CategorySelectionPage());
        break;
      case 2:
        Get.toNamed('/heatmap');
        break;
      case 4:
        Get.toNamed('/settings');
        break;
    }
  }

  Future<void> _deleteListing(String docId) async {
    try {
      await firestore.collection('jobListings').doc(docId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('İlan başarıyla silindi.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hata: $e')),
      );
    }
  }

  void _editListing(String docId, Map<String, dynamic> currentData) {
    // Düzenleme sayfasına yönlendirme
    Get.to(() => EditListingPage(docId: docId, currentData: currentData));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hesabım"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          // Kullanıcı Profili Bölümü
          Container(
            color: Colors.blueGrey,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/profile.png'),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Kullanıcı Adı",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "example@gmail.com",
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Telefon Numarası:",
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          // İlanlarım ve Favoriler Bölümü
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "İlanlarım",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ),
          _buildMyListings(),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Favorilerim",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ),
          _buildFavorites(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildMyListings() {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('jobListings').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('Henüz bir ilanınız yok.'));
        }

        final myListings = snapshot.data!.docs;

        return Column(
          children: myListings.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                title: Text(data['type'] ?? 'İlan'),
                subtitle: Text(data['loadType'] ?? data['vehicleType'] ?? 'Detay yok'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _editListing(doc.id, data),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteListing(doc.id),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
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

        final favorites = snapshot.data!.docs;

        return Column(
          children: favorites.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                title: Text(data['type'] ?? 'İlan'),
                subtitle: Text(data['loadType'] ?? data['vehicleType'] ?? 'Detay yok'),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
