import 'package:flutter/material.dart';
import 'mm_feed.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    mm_feed(),
    //searchPage(),
    //ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "الصفحة الرئيسية",
            style: TextStyle(
              color: const Color(0xff334856),
              fontWeight: FontWeight.w700,
              fontFamily: 'Noto Sans Oriya',
              fontSize: 24,
            ),
          ),
          backgroundColor: const Color(0xdeedd03c),
        ),
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            onTap: onTabTapped,
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                title: new Text("Home"),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.add),
                title: new Text("Post"),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.account_circle),
                title: new Text("Profile"),
              ),
            ]),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
