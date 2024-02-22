import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart'; // Import the package
import 'package:pari_gsc/views/home.dart';
import 'package:pari_gsc/views/cart_view.dart';
import 'package:pari_gsc/views/favorites_view.dart';
import 'package:pari_gsc/views/userScreen.dart';
import 'package:pari_gsc/views/user_profile_view.dart';

class BaseView extends StatefulWidget {
  BaseView({Key? key}) : super(key: key);

  @override
  _BaseViewState createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  int _selectedIndex = 1;

  final List<Widget> _pages = [
    FavoritesView(),
    HomeView(),
    UserProfileView(),
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
        index: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        color: Theme.of(context).primaryColor,
        items: [
          Icon(Icons.home),
          Icon(Icons.favorite),
          Icon(Icons.person),
        ],
      ),
    );
  }
}
