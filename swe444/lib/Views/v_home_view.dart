import 'package:flutter/material.dart';
//import 'mm_feed.dart';
import '../Widget/v_feed.dart';


class vHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<vHome> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    v_feed(),
    //searchPage(),
    //ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffededed),
        appBar: AppBar(
          title: const Text(
            "الصفحة الرئيسية",
            style: TextStyle(
              color: Color(0xff334856),
              fontWeight: FontWeight.w700,
              fontFamily: 'Noto Sans Oriya',
              fontSize: 24,
            ),
          ),
          backgroundColor: const Color(0xdeedd03c),
          bottomOpacity: 30,
          // elevation: 1,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50),
            ),
          ),
        ),
        body: _children[_currentIndex],
        extendBody: true,
        bottomNavigationBar: Container(
          // height: 90,
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
                iconSize: 30,
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
                    label: "الصفحة الرئيسية",
                  ),
                  BottomNavigationBarItem(
                    icon: new Icon(Icons.search),
                    label: "البحث",
                  ),
                  BottomNavigationBarItem(
                    icon: new Icon(Icons.account_circle),
                    label: "الصفحة الشخصية",
                  ),
                ]),
          ),
        ));
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
