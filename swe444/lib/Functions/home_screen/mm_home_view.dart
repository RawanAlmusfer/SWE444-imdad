import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'logout.dart';
import 'feed_view_model.dart';
import 'mm_feed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../logout.dart';
import '../post_request/post_request_view.dart';

class mmHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<mmHome> {
  // the default location which the user will be in:
  int _currentIndex = 3;
  String _title = "الصفحة الرئيسية";

  // nav bar redirection:
  final List<Widget> _children = [
    logout(),
    PostRequest(),
    PostRequest(),
    MosqueMangerFeed(),
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
        body:
            // MultiProvider(providers: [
            //   ChangeNotifierProvider(
            //     create: (_) => FeedViewModel(),
            //   )
            // ], child:
            _children[_currentIndex],
        // ),
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
                  BottomNavigationBarItem(
                    icon: new Icon(Icons.notifications),
                    label: "الاشعارات",
                  ),
                  BottomNavigationBarItem(
                    icon: new Icon(Icons.add),
                    label: "إضافة طلب",
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
            _title = 'تسجيل الخروج';
          }
          break;
        case 1:
          {
            _title = 'الاشعارات';
          }
          break;
        case 2:
          {
            _title = 'إضافة طلب';
          }
          break;

        case 3:
          {
            _title = 'الصفحة الرئيسية';
          }
          break;
      }
    });
  }
}
