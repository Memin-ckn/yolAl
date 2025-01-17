import 'package:flutter/material.dart';
import 'package:yol_al/src/features/map/screens/heatmap_page.dart';
import '../profile/profile_screen.dart';
import '../settings/settings_menu.dart';
import '../../../../common_widgets/bottom_nav_bar.dart';
import '../../../map/screens/category_selection_page.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  AnaSayfaState createState() => AnaSayfaState();
}

class AnaSayfaState extends State<AnaSayfa> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    CategorySelectionPage(),
    Center(child: Text('Pazar Yeri')),
    HeatMapPage(),
    HesabimPage(),
    AyarlarPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
