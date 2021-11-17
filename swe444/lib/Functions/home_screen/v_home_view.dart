import 'package:flutter/material.dart';
import 'package:swe444/Functions/home_screen/search_requests.dart';
import 'package:swe444/Functions/profile/ProfilePage1.dart';
import '../SubscribedList.dart';
import 'home.dart';
import 'moneyVFeed.dart';
import '../logout.dart';

class vHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<vHome> {
  // the default location which the user will be in:
  int _currentIndex = 3;
  String _title = "الصفحة الرئيسية";

  // nav bar redirection:
  final List<Widget> _children = [
    ProfilePage(),
    SubscribedList(),
    SearchPage(),
    vhome(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffededed),
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
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
          //automaticallyImplyLeading: false,
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
                    icon: new Icon(Icons.person),
                    label: "الملف الشخصي",
                  ),
                  BottomNavigationBarItem(
                    icon: new Icon(Icons.article_outlined),
                    label: "المتابَعين",
                  ),
                  BottomNavigationBarItem(
                    icon: new Icon(Icons.search),
                    label: "البحث",
                  ),
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
            _title = "الملف الشخصي";
          }
          break;
        case 1:
          {
            _title = 'قائمة المتابَعين';
          }
          break;
        case 2:
          {
            _title = 'البحث';
          }
          break;
        case 3:
            _title = 'الصفحة الرئيسية';
          }
          break;
      }
    });
  }
}
