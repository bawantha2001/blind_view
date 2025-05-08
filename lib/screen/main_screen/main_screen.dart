import 'package:blind_view/screen/cart_screen/cart_screen.dart';
import 'package:flutter/material.dart';

import '../../services/voice_service.dart';
import '../list_screen/list_screen.dart';
import '../shop_screen/mobileScanner_Screen/scanner_screen.dart';
import '../shop_screen/shop_screen.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    VoiceService().speak("Welcome to Shop Eyes");
  }

  List<Widget> screens = [
    ShopScreen(),
    ListScreen(),
    CartScreen(),
    ScannerScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[current_screen],
      bottomNavigationBar: BottomNavigationBar(
          onTap: _onItemTapped,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items:[
            BottomNavigationBarItem(icon: Icon(Icons.shopify_rounded),label: "Shop" ),
            BottomNavigationBarItem(icon: Icon(Icons.list),label: "List" ),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_rounded),label: "Cart" ),
            BottomNavigationBarItem(icon: Icon(Icons.qr_code_2_rounded),label: "Qr" ),
          ],
        enableFeedback: true,
        currentIndex: current_screen,
      ),
      
    );

  }
}
