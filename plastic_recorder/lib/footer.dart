import 'package:flutter/material.dart';
import 'package:plastic_recorder/calender.dart';
import 'package:plastic_recorder/login_screen.dart';
import 'package:plastic_recorder/today_screen.dart';

class footer extends StatefulWidget {
  const footer({Key? key}) : super(key: key);

  @override
  State<footer> createState() => _footerState();
}

class _footerState extends State<footer> {
  var now = new DateTime.now();
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      
    });
    Navigator.pushNamed(context, path[_selectedIndex]);
  }

  final path = ['/today', '/add', '/calender'];


  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/appIcon.png"),
              size: 45,
              color: Colors.grey,
            ),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle_outline,
              size: 43,
              color: Colors.grey,
            ),
            label: 'Add Record',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_month,
              size: 43,
              color: Colors.grey,
            ),
            label: 'Calendar',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.grey[700],
        onTap: _onItemTapped,
      ),
    );
  }
}
