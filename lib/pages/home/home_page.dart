import 'package:flutter/material.dart';
import 'package:sound_bridge_app/pages/home/tabs/home_tab.dart';
import 'package:sound_bridge_app/pages/home/tabs/map_tab.dart';
import 'package:sound_bridge_app/pages/home/tabs/profile_tab.dart';
import 'package:sound_bridge_app/pages/home/tabs/venue_tab.dart';
import 'package:sound_bridge_app/shared/constants/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const HomeTab(),
    const MapTab(),
    const VenueTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _tabs),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        selectedFontSize: 12,
        unselectedFontSize: 10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            activeIcon: Icon(Icons.home, size: 28),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            activeIcon: Icon(Icons.map, size: 28),
            label: '지도',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city),
            activeIcon: Icon(Icons.location_city, size: 28),
            label: '공연장',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            activeIcon: Icon(Icons.person, size: 28),
            label: '프로필',
          ),
        ],
      ),
    );
  }
}
