import 'package:flutter/material.dart';
//import 'mm_feed.dart';
import '../Widgets/v_feed.dart';
import '../logout.dart';

class vHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<vHome> {
  // the default location which the user will be in:
  int _currentIndex = 1;
  String _title = "الصفحة الرئيسية";

  // nav bar redirection:
  final List<Widget> _children = [
    logout(),
    v_feed(),
    //searchPage(),
    //ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffededed),
        appBar: AppBar(
          title: Text(
            _title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff334856),
              fontWeight: FontWeight.w700,
              fontFamily: 'Tajawal',
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
                    icon: new Icon(Icons.logout),
                    label: "تسجيل الخروج",
                  ),

                  // BottomNavigationBarItem(
                  //   icon: new Icon(Icons.search),
                  //   label: "البحث",
                  // ),
                  BottomNavigationBarItem(
                    icon: new Icon(Icons.home),
                    label: "الصفحة الرئيسية",
                  ),
                ]),
          ),
        ));
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0:
          {
            _title = 'الصفحة الرئيسية';
          }
          break;
        // case 1:
        //   {
        //     _title = 'البحث';
        //   }
        //   break;
        case 1:
          {
            _title = 'تسجيل الخروج';
          }
          break;
      }
    });
  }
}
