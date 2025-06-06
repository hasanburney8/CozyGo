import 'package:demo/ui/profile_page.dart';
import 'package:demo/ui/wishlists.dart';
import 'package:flutter/material.dart';

import 'explore_screen.dart';
import 'message.dart';

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  int selectedIndex = 0;

  late final List<Widget> page;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    page = [
      ExploreScreen(),
      Wishlists(),
      Scaffold(),
      MessageScreen(),
      ProfilePage(),
    ];
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 5, iconSize: 32, selectedItemColor: Color(0xFF12d68f),
          unselectedItemColor: Colors.black,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          onTap: (index){
            setState(() {
              selectedIndex = index ;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.search_outlined),
                label: "Explore"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border_outlined),
                label: "Wish List"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_pin),
                label: "Trip"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.message_outlined),
                label: "Message"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_2_outlined),
                label: "Profile"
            ),
          ]
      ),
      body: page[selectedIndex],
    );
  }
}
