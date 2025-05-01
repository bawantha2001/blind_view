import 'package:blind_view/screen/cart_screen/cart_screen.dart';
import 'package:blind_view/screen/history_screen/history_screen.dart';
import 'package:blind_view/screen/scan_screen/scan_screen.dart';
import 'package:blind_view/screen/settings_screen/settings_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int current_screen = 0;

  void _onItemTapped(int index){
    setState(() {
      current_screen = index;
    });
  }

  List<Widget> screens = [
    ScanScreen(),
    CartScreen(),
    HistoryScreen(),
    SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[current_screen],
      bottomNavigationBar: BottomNavigationBar(
          onTap: _onItemTapped,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          items:[
            BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner_rounded),label: "Scan" ),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined),label: "Cart" ),
            BottomNavigationBarItem(icon: Icon(Icons.history),label: "History" ),
            BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Settings" ),
          ],
        enableFeedback: true,
        currentIndex: current_screen,
      ),
      
    );

  }
}
