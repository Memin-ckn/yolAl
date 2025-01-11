import 'package:flutter/material.dart';
import '../profile/profile_screen.dart';
import '../settings/settings_menu.dart';
import '../widgets/bottom_nav_bar.dart';

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    Center(child: Text('İş Koyma')),
    Center(child: Text('Pazar Yeri')),
    Center(child: Text('Harita')),
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
