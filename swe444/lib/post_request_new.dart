import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostRequest extends StatefulWidget {
  const PostRequest({Key? key}) : super(key: key);
  @override
  _PostRequestState createState() => _PostRequestState();
}

class _PostRequestState extends State<PostRequest> {
  final _formKey = GlobalKey<FormState>();

  int _currentIndex = 1;
  String? type;
  String? postedBy;
  int amount = 0;
  String? description;
  String? title;
  final List<String> items = ['Funds'];

  Widget _buildType(bool orientation) {
    double h1 = 0;
    if (orientation == true) {
      h1 = 10;
    } else
      h1 = 60;

    return Container(
      child: Row(
        children: [
          Column(
            children: [
              Stack(
                children: <Widget>[
                  Container(
                    width: orientation == true ? 190.w : 180.w,
                    height: orientation == true ? 32.h : 70.h,
                    padding: EdgeInsets.symmetric(horizontal: h1, vertical: 0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Color(0xffffffff),
                        border: Border.all(
                            width: 0.5, color: const Color(0xffdfdfdf)),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x29000000),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 0.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: type,
                            items: items.map<DropdownMenuItem<String>>(
                                (dropdownMenuItem) {
                              return DropdownMenuItem(
                                value: dropdownMenuItem,
                                child: Text(dropdownMenuItem),
                              );
                            }).toList(),
                            onChanged: (value) =>
                                setState(() => this.type = value),
                            hint: Text("Select item"),
                            icon: Icon(Icons.arrow_drop_down_circle),
                            isExpanded: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(width: orientation == true ? 40.w : 30.w),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              ),
              Text(
                "نوع الطلب",
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: const Color(0xff334856),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Tajawal',
                  fontSize: 15,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTitle(bool orientation) {
    double h1 = 0;
    if (orientation == true) {
      h1 = 10;
    } else
      h1 = 60;

    return Container(
      child: Row(
        children: [
          Column(
            children: [
              Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 25),
                    width: orientation == true ? 190.w : 180.w,
                    height: orientation == true ? 32.h : 70.h,
                    padding: EdgeInsets.symmetric(horizontal: h1, vertical: 0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Color(0xffffffff),
                        border: Border.all(
                            width: 0.5, color: const Color(0xffdfdfdf)),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x29000000),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 0.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter title',
                              contentPadding:
                                  EdgeInsets.fromLTRB(0, 0, 0, 13.5),
                              hintStyle: TextStyle(fontSize: 16)),
                          onChanged: (_val) {
                            title = _val;
                          }, // onchanged
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(30)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(width: orientation == true ? 40.w : 30.w),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30),
              ),
              Text(
                "عنوان الطلب",
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: const Color(0xff334856),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Tajawal',
                  fontSize: 15,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildDescription(bool orientation) {
    double h1 = 0;
    if (orientation == true) {
      h1 = 10;
    } else
      h1 = 60;

    return Container(
      child: Column(
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                    ),
                    Text(
                      "تفاصيل الطلب",
                      style: TextStyle(
                        color: const Color(0xff334856),
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Tajawal',
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(width: orientation == true ? 11.w: 29.w ),
                  ],
                )
              ]),
          Row(
            children: [
              Column(
                children: [
                  Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        width: orientation == true ? 140.w : 150.w,
                        height: orientation == true ? 32.h : 70.h,
                        padding:
                            EdgeInsets.symmetric(horizontal: h1, vertical: 0),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Color(0xffffffff),
                            border: Border.all(
                                width: 0.5, color: const Color(0xffdfdfdf)),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x29000000),
                                offset: Offset(0, 3),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(38, 0, 0, 0),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Amount',
                                  contentPadding:
                                  EdgeInsets.fromLTRB(0, 0, 0, 16),
                                  hintStyle: TextStyle(fontSize: 13)),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(30),
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                              ],
                              keyboardType: TextInputType.number,
                              onChanged: (_val) {
                                var _val2 = int.parse(_val), amount = _val2;
                              }, // onchanged
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(width: orientation == true ? 10.w : 0.w),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                  ),
                  Text(
                    "المبلغ",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: const Color(0xff334856),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Tajawal',
                      fontSize: 15,
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceOrientation = MediaQuery.of(context).orientation;
    bool portrait = true;

    if (deviceOrientation == Orientation.landscape) portrait = false;

    return Scaffold(
      backgroundColor: const Color(0xffededed),
      appBar: AppBar(
        title: Text(
          "إضافة طلب جديد",
          style: TextStyle(
            color: const Color(0xff334856),
            fontWeight: FontWeight.w700,
            fontFamily: 'Tajawal',
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 22),
              ),
              Text(
                'نموذج إضافة طلب جديد',
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff334856),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 28.h),
              Container(
                height: portrait == true ? 400.h : 600.h,
                width: portrait == true ? 330.w : 280.w,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Color(0xffffffff),
                  border:
                      Border.all(width: 0.5, color: const Color(0xffdfdfdf)),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      _buildType(portrait),
                      _buildTitle(portrait),
                      _buildDescription(portrait),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
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
      ),
    );
  }

  void add() async {
    // save to db
    CollectionReference ref = FirebaseFirestore.instance.collection('Requests');

    var data = {
      'title': title,
      'type': type,
      'posted_by': postedBy,
      'description': description,
      'amount': amount,
    };

    ref.add(data);

    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => PostRequest(),
      ),
    )
        .then((value) {
      print("Calling Set State !");
      setState(() {});
    });

    _formKey.currentState?.reset();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
