import 'package:Islands/pages/calendar_page.dart';
import 'package:Islands/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:Islands/pages/favorite_page.dart';
import 'package:Islands/pages/home_page.dart';
import 'package:ionicons/ionicons.dart';

class NavigatorBarController extends StatefulWidget {
  const NavigatorBarController({Key? key}) : super(key: key);

  @override
  _NavigatorBarControllerState createState() => _NavigatorBarControllerState();
}

class _NavigatorBarControllerState extends State<NavigatorBarController> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    const CalendarPage(),
    const SearchPage(),
    const FavoritePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.grey.shade700,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.grey.shade400,
              tabs: const [
                GButton(
                  icon: Ionicons.home_outline,
                  text: 'Inicio',
                ),
                GButton(
                  icon: Ionicons.calendar_outline,
                  text: 'Calendario',
                ),
                GButton(
                  icon: Ionicons.search_outline,
                  text: 'Buscar',
                ),
                GButton(
                  icon: Ionicons.heart_outline,
                  text: 'Favoritos',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}