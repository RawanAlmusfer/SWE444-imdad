import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swe444/Functions/home_screen/mm_feed.dart';
import 'package:swe444/Functions/request/post_request_view.dart';
import '../logout.dart';
import 'edit_request_form.dart';
import 'post_request_form.dart';
import '../home_screen/mm_home_view.dart';

class EditRequest extends StatefulWidget {
  EditRequest.ensureInitialized();
  const EditRequest({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _EditRequestState();
  }
}

class _EditRequestState extends State<EditRequest> {
  int _currentIndex = 2;
  String _title = "تعديل الطلب";

  // nav bar redirection:
  final List<Widget> _children = [
    logout(),
    PostRequest(),
    MosqueMangerFeed(),
  ];

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
            _title = 'إضافة طلب';
          }
          break;
        case 2:
          {
            _title = 'الصفحة الرئيسية';
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceOrientation = MediaQuery.of(context).orientation;
    bool portrait = true;

    if (deviceOrientation == Orientation.landscape) portrait = false;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
          appBar: AppBar(
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
          backgroundColor: const Color(0xffededed),
          body: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                    ),
                    Text(
                      'نموذج تعديل طلب',
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff334856),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: portrait == true ? 15.h : 20.h),
                    Container(
                      // height: portrait == true ? 580.h : 1100.h,
                      width: portrait == true ? 330.w : 280.w,
                      padding:
                      const EdgeInsets.only(left: 12, right: 12, top: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Color(0xffffffff),
                        border: Border.all(
                            width: 0.5, color: const Color(0xffdfdfdf)),
                      ),
                      child: EditRequestForm(),
                    ),
                    SizedBox(height: portrait == true ? 120.h : 230.h),
                  ],
                ),
              ),
            ),
          ),

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
                      icon: new Icon(Icons.add),
                      label: "إضافة طلب",
                    ),
                    BottomNavigationBarItem(
                      icon: new Icon(Icons.home),
                      label: "الصفحة الرئيسية",
                    ),
                  ]),
            ),
          )),

    );


  }
}
