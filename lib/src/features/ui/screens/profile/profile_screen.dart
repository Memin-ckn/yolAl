import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yol_al/src/features/ui/screens/job_post/category_selection_page.dart';
import 'widgets/gecmis_isler.dart';
import '../../../../common_widgets/bottom_nav_bar.dart';

class HesabimPage extends StatefulWidget {
  const HesabimPage({super.key});

  @override
  State<HesabimPage> createState() => HesabimPageState();
}

class HesabimPageState extends State<HesabimPage> {
  final gecmisIsler = GecmisIslerPage().isler;
  int _selectedIndex = 3; // Set to 3 since this is the profile tab

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hesabım"),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.blueGrey,
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/profile.png'),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Kullanıcı Adı",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "example@gmail.com",
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Telefon Numarası:",
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.add_task),
            title: Text("Geçmiş İşler"),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Get.to(() => GecmisIslerPage());
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Son İşleriniz",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ),
          // Son 3 iş kartı
          ...gecmisIsler
              .take(3)
              .map((is_) => Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      leading: Icon(Icons.work,
                          color: is_.durum == "Tamamlandı"
                              ? Colors.blue
                              : Colors.red),
                      title: Text(is_.baslik),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Tarih: ${is_.tarih}"),
                          Text(
                            "Durum: ${is_.durum}",
                            style: TextStyle(
                              color: is_.durum == "Tamamlandı"
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
              ,
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
