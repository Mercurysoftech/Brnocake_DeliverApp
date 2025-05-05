import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:task1/earning.dart';
import 'package:task1/history.dart';
import 'package:task1/hometap.dart';
import 'package:task1/profilletap.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isSwitched = false;

  int _selectedIndex = 0;

  final tap = [Myhome(), Earning(), History(), Profilletap()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: tap[_selectedIndex],
      bottomNavigationBar: Container(
        height: 100,
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(0),
          //   topRight: Radius.circular(0),
          // ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        // child: ClipRRect(
        //   borderRadius: BorderRadius.only(
        //     topLeft: Radius.circular(20),
        //     topRight: Radius.circular(20),
        // ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, // Fixed style
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFFED2039), // Active tab color (Red)
          unselectedItemColor: Color(0xFF9D9D9D), // Inactive tab color (Gray)
          currentIndex: _selectedIndex, // Track selected index
          onTap: _onItemTapped, // Change index on tap
          showUnselectedLabels: true, // Show inactive labels
          items: [
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: _selectedIndex == 0
                    ? ColorFilter.mode(Color(0xFFED2039), BlendMode.srcIn)
                    : ColorFilter.mode(Color(0xFF9D9D9D), BlendMode.srcIn),
                child: Image.asset(
                  'assets/homeicon.png',
                  width: 28,
                  height: 28,
                ),
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: _selectedIndex == 1
                    ? ColorFilter.mode(Color(0xFFED2039), BlendMode.srcIn)
                    : ColorFilter.mode(Color(0xFF9D9D9D), BlendMode.srcIn),
                child: Image.asset(
                  'assets/wallaticon.png',
                  width: 28,
                  height: 28,
                ),
              ),
              label: "Earning",
            ),
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: _selectedIndex == 2
                    ? ColorFilter.mode(Color(0xFFED2039), BlendMode.srcIn)
                    : ColorFilter.mode(Color(0xFF9D9D9D), BlendMode.srcIn),
                child: Image.asset(
                  'assets/history.png',
                  width: 28,
                  height: 28,
                ),
              ),
              label: "History",
            ),
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: _selectedIndex == 3
                    ? ColorFilter.mode(Color(0xFFED2039), BlendMode.srcIn)
                    : ColorFilter.mode(Color(0xFF9D9D9D), BlendMode.srcIn),
                child: Image.asset(
                  'assets/profile.png',
                  width: 28,
                  height: 28,
                ),
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
