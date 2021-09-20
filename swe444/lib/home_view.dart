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
          backgroundColor: const Color(0xffededed),
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
            bottomOpacity: 30,
            // elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(50),
              ),
            ),
          ),
          body: _children[_currentIndex],
          extendBody: true,
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50), topLeft: Radius.circular(50)),
              boxShadow: [
                BoxShadow(
                    color: Color(0xffededed), spreadRadius: 0, blurRadius: 10),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              child: BottomNavigationBar(
                  backgroundColor: Colors.white,
                  iconSize: 40,
                  selectedItemColor: const Color(0xdeedd03c),
                  unselectedItemColor: const Color(0xff334856),
                  selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  onTap: onTabTapped,
                  currentIndex: _currentIndex,
                  items: [
                    BottomNavigationBarItem(
                      icon: new Icon(Icons.home),
                      title: new Text("الصفحة الرئيسية"),
                    ),
                    BottomNavigationBarItem(
                      icon: new Icon(Icons.add),
                      title: new Text("إضافة طلب"),
                    ),
                    BottomNavigationBarItem(
                      icon: new Icon(Icons.account_circle),
                      title: new Text("الصفحة الشخصية"),
                    ),
                  ]),
            ),
          )),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
