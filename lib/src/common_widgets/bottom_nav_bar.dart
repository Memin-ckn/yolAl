import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.add_business),
          label: 'İlan Ver',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Keşfet',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on_outlined),
          label: 'Harita',
        ),
        BottomNavigationBarItem(
          icon: CircleAvatar(
            radius: 14,
            backgroundImage: AssetImage('assets/images/profile.png'),
          ),
          label: 'Profil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Ayarlar',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      onTap: onItemTapped,
    );
  }
}
