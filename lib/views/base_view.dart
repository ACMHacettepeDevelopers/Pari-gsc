import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart'; // Import the package
import 'package:pari_gsc/views/chat_view.dart';
import 'package:pari_gsc/views/home.dart';
import 'package:pari_gsc/views/cart_view.dart';
import 'package:pari_gsc/views/notifications_view.dart';
import 'package:pari_gsc/views/settings_view.dart';

class BaseView extends StatefulWidget {
  BaseView({Key? key}) : super(key: key);

  @override
  _BaseViewState createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeView(),
    ChatView(),
    CartView(),
    NotificationsView(),
    SettingsView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        // Replace GNav with CurvedNavigationBar
        index: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        color: Theme.of(context).primaryColor,
        items: [
          Icon(Icons.home),
          Icon(Icons.chat_bubble),
          Icon(Icons.shopping_cart),
          Icon(Icons.notifications),
          Icon(Icons.settings),
        ],
      ),
    );
  }
}
