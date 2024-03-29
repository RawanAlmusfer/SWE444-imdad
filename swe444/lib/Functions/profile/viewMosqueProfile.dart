import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:swe444/Functions/donation/items/item_donation.dart';
import 'package:swe444/Functions/home_screen/feed_view_model.dart';
import 'package:swe444/Functions/request/edit_request_view.dart';
import 'package:swe444/Payment/PaymentScreen.dart';
import '../request/request_view_model.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class viewMosqueProfile extends StatelessWidget {
  viewMosqueProfile.ensureInitialized(this.isSubscribed, this.numOfVolunteers,
      this.numOfRequests, this.MosqueName, this.MosqueID);
  final String MosqueName;
  final String MosqueID;
  final bool isSubscribed;
  final String numOfVolunteers;
  final String numOfRequests;

  const viewMosqueProfile({
    Key? key,
    required this.isSubscribed,
    required this.numOfVolunteers,
    required this.numOfRequests,
    required this.MosqueName,
    required this.MosqueID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FeedViewModel>(
        create: (_) => FeedViewModel(),
        child: Container(
            height: 1200,
            width: 450,
            child: MosqueMangerProfile(
              isSubscribed: this.isSubscribed,
              numOfVolunteers: this.numOfVolunteers,
              numOfRequests: this.numOfRequests,
              MosqueID: this.MosqueID,
              MosqueName: this.MosqueName,
            )));
  }
}

class MosqueMangerProfile extends StatefulWidget {
  static String? mmEmailDonated = '';
  static String? mmNameDonated = '';
  static int wholeAmount = 0;
  static int wholeDonated = 0;
  MosqueMangerProfile.ensureInitialized(this.isSubscribed, this.numOfVolunteers,
      this.numOfRequests, this.MosqueName, this.MosqueID);
  final String MosqueName;
  final String MosqueID;
  final bool isSubscribed;
  final String numOfVolunteers;
  final String numOfRequests;

  const MosqueMangerProfile(
      {Key? key,
      required this.isSubscribed,
      required this.numOfVolunteers,
      required this.numOfRequests,
      required this.MosqueName,
      required this.MosqueID})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MosqueProfile();
  }
}

class MosqueProfile extends State<MosqueMangerProfile>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final colorstheme = const Color(0xdeedd03c);

  @override
  void initState() {
    _tabController = new TabController(length: 1, vsync: this, initialIndex: 0)
      ..addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot<Map<String, dynamic>>>? followrs = FirebaseFirestore
        .instance
        .collection('users')
        .doc(widget.MosqueID)
        .collection("subscribedVolunteers")
        .snapshots();

    Stream<QuerySnapshot<Map<String, dynamic>>>? requests = FirebaseFirestore
        .instance
        .collection('requests')
        .orderBy('uplaod_time', descending: true)
        .snapshots();

    // Navigator.pop(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
                icon: Icon(
                  Icons.keyboard_backspace_rounded,
                  textDirection: ui.TextDirection.rtl,
                  size: 30,
                  color: Color(0xff334856),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ),
        ],
      ),
      backgroundColor: const Color(0xffededed),
      body: Container(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Spacer(flex: 1),
                Column(
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.notifications,
                          size: 30,
                          color: widget.isSubscribed
                              ? Color(0xdeedd03c)
                              : Colors.grey,
                        ),
                        onPressed: () async {
                          await subscription(
                              widget.MosqueID, widget.MosqueName);
                        }),
                  ],
                ),
                Spacer(flex: 4),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10, bottom: 20),
                      height: 80,
                      width: 80,
                      child: SvgPicture.string(
                        mosqueImage,
                        allowDrawingOutsideViewBox: true,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
                Spacer(flex: 7),
              ],
            ),
            Text(
              widget.MosqueName,
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: 'Tajawal',
                fontWeight: FontWeight.bold,
                color: Color(0xff334856),
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3.0),
                        child: Text(
                          'المتابِعين',
                          style: TextStyle(
                            color: Color(0xff334856),
                            fontFamily: 'Tajawal',
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        widget.numOfVolunteers,
                        style: TextStyle(
                          color: Color(0xff334856),
                          fontFamily: 'Tajawal',
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 7,
                    ),
                    child: Container(
                      height: 30,
                      width: 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3.0),
                        child: Text(
                          'الطلبات',
                          style: TextStyle(
                            color: Color(0xff334856),
                            fontFamily: 'Tajawal',
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        widget.numOfRequests,
                        style: TextStyle(
                          color: Color(0xff334856),
                          fontFamily: 'Tajawal',
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
            //   child: Container(
            //     decoration: BoxDecoration(
            //       boxShadow: [
            //         BoxShadow(
            //             color: Color(0xffededed),
            //             spreadRadius: 1,
            //             blurRadius: 10),
            //       ],
            //     ),
            //     height: 30,
            //     width: widget.isSubscribed ? 120 : 70,
            //     child: ElevatedButton(
            //       onPressed: () async {
            //         await subscription(widget.document['mmId'],
            //             widget.document['mosque_name']);
            //       },
            //       child: Text(
            //         widget.isSubscribed ? "إلغاء المتابعة" : "تابع",
            //         textAlign: TextAlign.center,
            //         style: TextStyle(
            //             fontFamily: 'Tajawal', color: const Color(0xff334856)),
            //       ),
            //       style: ElevatedButton.styleFrom(
            //         minimumSize: Size(65.w, 30.h),
            //         primary: const Color(0xdeedd03c),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(50),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            TabBar(
                isScrollable: true,
                labelColor: Color(0xff334856),
                unselectedLabelColor: Colors.grey,
                indicatorColor: colorstheme,
                labelStyle: TextStyle(fontSize: 18),
                controller: _tabController,
                tabs: [
                  Text(
                    'الطلبات',
                    style: TextStyle(fontFamily: "Tajawal"),
                  ),
                ]),
            StreamBuilder(
                stream: requests,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return _buildWaitingScreen();
                  return Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount:
                              (snapshot.data! as QuerySnapshot).docs.length,
                          itemBuilder: (BuildContext context, int index) =>
                              buildCards(
                                  context,
                                  (snapshot.data! as QuerySnapshot)
                                      .docs[index]),
                        ),
                        // ListView.builder(
                        //   scrollDirection: Axis.vertical,
                        //   shrinkWrap: true,
                        //   itemCount:
                        //       (snapshot.data! as QuerySnapshot).docs.length,
                        //   itemBuilder: (BuildContext context, int index) =>
                        //       buildCards(
                        //           context,
                        //           (snapshot.data! as QuerySnapshot)
                        //               .docs[index]),
                        // ),
                      ],
                    ),
                  );
                }),
            // Expanded(
            //   child: TabBarView(controller: _tabController, children: [
            //     StreamBuilder(
            //         stream: requests,
            //         builder: (context, snapshot) {
            //           if (!snapshot.hasData) return _buildWaitingScreen();
            //           return ListView.builder(
            //             scrollDirection: Axis.vertical,
            //             shrinkWrap: true,
            //             itemCount:
            //                 (snapshot.data! as QuerySnapshot).docs.length,
            //             itemBuilder: (BuildContext context, int index) =>
            //                 buildCards(context,
            //                     (snapshot.data! as QuerySnapshot).docs[index]),
            //           );
            //         }),
            //     StreamBuilder(
            //         stream: followrs,
            //         builder: (context, snapshot) {
            //           if (!snapshot.hasData) return _buildWaitingScreen();
            //           return ListView.builder(
            //             scrollDirection: Axis.vertical,
            //             shrinkWrap: true,
            //             itemCount:
            //                 (snapshot.data! as QuerySnapshot).docs.length,
            //             itemBuilder: (BuildContext context, int index) =>
            //                 buildCards(context,
            //                     (snapshot.data! as QuerySnapshot).docs[index]),
            //           );
            //         }),
            //   ]),
            // ),
          ],
        ),
      ),
    );
  }

  Widget buildCards(BuildContext context, DocumentSnapshot document) {
    if (document['posted_by'].toString() == widget.MosqueID) {
      if (document['type'].toString() == "تنظيم")
        return buildEventsCards(context, document);
      else if (document['type'].toString() == "موارد")
        return buildItemsCards(context, document);
      else
        return buildFundsCards(context, document);
    } else {
      return Container();
    }
  }

  Widget buildEventsCards(BuildContext context, DocumentSnapshot document) {
    FeedViewModel feedVM = FeedViewModel();
    return Container(
      padding: const EdgeInsets.only(top: 10.0, left: 12, right: 12),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(19.0),
        ),
        shadowColor: Color(0xff334856),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    top: 5.0, bottom: 9.0, left: 2, right: 10),
                child: Row(children: <Widget>[
                  // Container(
                  //   width: 100,
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(right: 20, top: 5),
                  //     child: Text(
                  //       document['mosque_name'],
                  //       style: TextStyle(
                  //           fontFamily: 'Tajawal',
                  //           fontSize: 12,
                  //           decoration: TextDecoration.underline),
                  //       textAlign: TextAlign.center,
                  //     ),
                  //   ),
                  // ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, top: 5),
                    child: Text(
                      document['title'],
                      style: TextStyle(fontSize: 16.0, fontFamily: 'Tajawal'),
                      // textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SvgPicture.string(
                      mosqueImage,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                ]),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 4.0, bottom: 15.0, right: 70),
                child: Row(children: <Widget>[
                  const Spacer(),
                  Column(
                    children: [
                      Container(
                        width: 250, // to wrap the text in multiline
                        child: Text(
                          document['description'],
                          style: TextStyle(fontFamily: 'Tajawal'),
                          textDirection: ui.TextDirection
                              .rtl, // make the text from right to left
                        ),
                      ),
                      //start_date
                      Container(
                        width: 250, // to wrap the text in multiline
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            'تاريخ البداية: ' + getTime(document['start_date']),
                            style: TextStyle(fontFamily: 'Tajawal'),
                            textDirection: ui.TextDirection
                                .rtl, // make the text from right to left
                          ),
                        ),
                      ),
                      Container(
                        width: 250, // to wrap the text in multiline
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            'المدة: ' + document['days'].toString() + " يوم",
                            style: TextStyle(fontFamily: 'Tajawal'),
                            textDirection: ui.TextDirection
                                .rtl, // make the text from right to left
                          ),
                        ),
                      ),
                      Container(
                        width: 250, // to wrap the text in multiline
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            'يبدأ في تمام الساعة ' +
                                document['start_time'].toString() +
                                " وينتهي " +
                                document['end_time'].toString(),
                            style: TextStyle(fontFamily: 'Tajawal'),
                            textDirection: ui.TextDirection
                                .rtl, // make the text from right to left
                          ),
                        ),
                      ),
                      Container(
                        width: 250, // to wrap the text in multiline
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Directionality(
                            textDirection: ui.TextDirection
                                .rtl, // make the text from right to left,
                            child: Text(
                              'عدد المنظمين المطلوب: ' +
                                  document['parts_number'].toString(),
                              style: TextStyle(fontFamily: 'Tajawal'),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 250, // to wrap the text in multiline
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "عدد المشاركين: ",
                            style: TextStyle(fontFamily: 'Tajawal'),
                            textDirection: ui.TextDirection.rtl,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 14.0),
                            child: Text(document['participants'].toString(),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontFamily: 'Tajawal', fontSize: 13)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, left: 5, right: 5),
                            child: SizedBox(
                              width: 200,
                              height: 10,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: LinearProgressIndicator(
                                      value: (document['participants'] /
                                          document['parts_number']),
                                      valueColor: AlwaysStoppedAnimation(
                                          Color(0xdeedd03c)),
                                      backgroundColor: Color(0xffededed),
                                    ),
                                  ),
                                  Center(
                                      child: buildLinearProgress(
                                          (document['participants'] /
                                              document['parts_number']))),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 14.0),
                            child: Text(document['parts_number'].toString(),
                                style: TextStyle(
                                    fontFamily: 'Tajawal', fontSize: 13)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 5.0, bottom: 5.0, left: 2, right: 10),
                child: Row(children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xffededed),
                            spreadRadius: 1,
                            blurRadius: 10),
                      ],
                    ),
                    height: 30,
                    width: 70,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "شارك",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Tajawal',
                            color: const Color(0xff334856)),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(65.w, 30.h),
                        primary: const Color(0xdeedd03c),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.location_on, color: Color(0xdeedd03c)),
                    onPressed: () async {
                      await feedVM
                          .lunchURL(document['mosque_location'].toString());
                    },
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItemsCards(BuildContext context, DocumentSnapshot document) {
    FeedViewModel feedVM = FeedViewModel();
    // here is the tpye
    return Container(
      padding: const EdgeInsets.only(top: 10.0, left: 12, right: 12),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(19.0),
        ),
        shadowColor: Color(0xff334856),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    top: 5.0, bottom: 9.0, left: 2, right: 10),
                child: Row(children: <Widget>[
                  // Container(
                  //   width: 100,
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(right: 20, top: 5),
                  //     child: Text(
                  //       document['mosque_name'],
                  //       style: TextStyle(
                  //           fontFamily: 'Tajawal',
                  //           fontSize: 12,
                  //           decoration: TextDecoration.underline),
                  //       textAlign: TextAlign.center,
                  //     ),
                  //   ),
                  // ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, top: 5),
                    child: Text(
                      document['title'],
                      style: TextStyle(fontSize: 16.0, fontFamily: 'Tajawal'),
                      // textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SvgPicture.string(
                      mosqueImage,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                ]),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 4.0, bottom: 15.0, right: 70),
                child: Row(children: <Widget>[
                  const Spacer(),
                  Column(
                    children: [
                      Container(
                        width: 250, // to wrap the text in multiline
                        child: Text(
                          document['description'],
                          style: TextStyle(fontFamily: 'Tajawal'),
                          textDirection: ui.TextDirection
                              .rtl, // make the text from right to left
                        ),
                      ),
                      Container(
                        width: 250, // to wrap the text in multiline
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            'العدد المطلوب: ' +
                                document['amount_requested'].toString(),
                            style: TextStyle(fontFamily: 'Tajawal'),
                            textDirection: ui.TextDirection
                                .rtl, // make the text from right to left
                          ),
                        ),
                      ),
                      Container(
                        width: 250, // to wrap the text in multiline
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "العدد المتبقي: ",
                            style: TextStyle(fontFamily: 'Tajawal'),
                            textDirection: ui.TextDirection.rtl,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 14.0),
                          //   child: Text(document['donated'].toString(),
                          //       textAlign: TextAlign.right,
                          //       style: TextStyle(
                          //           fontFamily: 'Tajawal', fontSize: 13)),
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, left: 5, right: 5),
                            child: SizedBox(
                              width: 200,
                              height: 10,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: LinearProgressIndicator(
                                      value: (document['donated'] /
                                          document['amount_requested']),
                                      valueColor: AlwaysStoppedAnimation(
                                          Color(0xdeedd03c)),
                                      backgroundColor: Color(0xffededed),
                                    ),
                                  ),
                                  Center(
                                      child: itemsBuildLinearProgress(
                                          document['donated'],
                                          document['amount_requested'])),
                                ],
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 14.0),
                          //   child: Text(
                          //       document['amount_requested'].toString(),
                          //       style: TextStyle(
                          //           fontFamily: 'Tajawal', fontSize: 13)),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 5.0, bottom: 5.0, left: 2, right: 10),
                child: Row(children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xffededed),
                            spreadRadius: 1,
                            blurRadius: 10),
                      ],
                    ),
                    height: 30,
                    width: 65,
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ItemsDScreen(document: document)));
                      },
                      child: Text(
                        "تبرع",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Tajawal',
                            color: const Color(0xff334856)),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(65.w, 30.h),
                        primary: const Color(0xdeedd03c),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.location_on, color: Color(0xdeedd03c)),
                    onPressed: () async {
                      await feedVM
                          .lunchURL(document['mosque_location'].toString());
                    },
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFundsCards(BuildContext context, DocumentSnapshot document) {
    FeedViewModel feedVM = FeedViewModel();
    return Container(
      padding: const EdgeInsets.only(top: 10.0, left: 12, right: 12),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(19.0),
        ),
        shadowColor: Color(0xff334856),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    top: 5.0, bottom: 9.0, left: 2, right: 10),
                child: Row(children: <Widget>[
                  // Container(
                  //   width: 100,
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(right: 20, top: 5),
                  //     child: Text(
                  //       document['mosque_name'],
                  //       style: TextStyle(
                  //           fontFamily: 'Tajawal',
                  //           fontSize: 12,
                  //           decoration: TextDecoration.underline),
                  //       textAlign: TextAlign.center,
                  //     ),
                  //   ),
                  // ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, top: 5),
                    child: Text(
                      document['title'],
                      style: TextStyle(fontSize: 16.0, fontFamily: 'Tajawal'),
                      // textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SvgPicture.string(
                      mosqueImage,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                ]),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 4.0, bottom: 15.0, right: 70),
                child: Row(children: <Widget>[
                  const Spacer(),
                  Column(
                    children: [
                      Container(
                        width: 250, // to wrap the text in multiline
                        child: Text(
                          document['description'],
                          style: TextStyle(fontFamily: 'Tajawal'),
                          textDirection: ui.TextDirection
                              .rtl, // make the text from right to left
                        ),
                      ),
                      Container(
                        width: 250, // to wrap the text in multiline
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            'المبلغ: ' + document['amount'].toString(),
                            style: TextStyle(fontFamily: 'Tajawal'),
                            textDirection: ui.TextDirection
                                .rtl, // make the text from right to left
                          ),
                        ),
                      ),
                      Container(
                        width: 250, // to wrap the text in multiline
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "نسبة الإكتمال: ",
                            style: TextStyle(fontFamily: 'Tajawal'),
                            textDirection: ui.TextDirection.rtl,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 14.0),
                            child: Text(document['donated'].toString(),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontFamily: 'Tajawal', fontSize: 10)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, left: 5, right: 5),
                            child: SizedBox(
                              width: 200,
                              height: 10,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: LinearProgressIndicator(
                                      value: (document['donated'] /
                                          document['amount']),
                                      valueColor: AlwaysStoppedAnimation(
                                          Color(0xdeedd03c)),
                                      backgroundColor: Color(0xffededed),
                                    ),
                                  ),
                                  Center(
                                      child: buildLinearProgress(
                                          (document['donated'] /
                                              document['amount']))),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 14.0),
                            child: Text(document['amount'].toString(),
                                style: TextStyle(
                                    fontFamily: 'Tajawal', fontSize: 10)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 5.0, bottom: 5.0, left: 2, right: 10),
                child: Row(children: <Widget>[
                  //This button for sprint 2
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xffededed),
                            spreadRadius: 1,
                            blurRadius: 10),
                      ],
                    ),
                    height: 30,
                    width: 65,
                    child: ElevatedButton(
                      onPressed: () async {
                        String? mmId = document['posted_by'];
                        MosqueMangerProfile.wholeDonated = document['donated'];
                        int cumDonated = document['donated'];
                        MosqueMangerProfile.wholeAmount = document['amount'];
                        String? mName = document['mosque_name'];

                        MosqueMangerProfile.mmNameDonated = mName;

                        var documentFormmId = await FirebaseFirestore.instance
                            .collection('users')
                            .doc(mmId)
                            .get();

                        String? mmEmail = documentFormmId['email'];
                        MosqueMangerProfile.mmEmailDonated = mmEmail;

                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PaymentScreen()));

                        cumDonated += PaymentScreen.vDonatedAmount!;

                        String docId = document.id;
                        await FirebaseFirestore.instance
                            .collection('requests')
                            .doc(docId)
                            .update({'donated': cumDonated});

                        //update the denoation for next user
                        PaymentScreen.vDonatedAmount = 0;
                        //  db.collection("requests").doc(docId).update({donated: 10});
                      },
                      child: Text(
                        "تبرع",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Tajawal',
                            color: const Color(0xff334856)),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(65.w, 30.h),
                        primary: const Color(0xdeedd03c),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ),

                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.location_on, color: Color(0xdeedd03c)),
                    onPressed: () async {
                      await feedVM
                          .lunchURL(document['mosque_location'].toString());
                    },
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> subscription(String mmId, String mmName) async {
    String vId = await FirebaseAuth.instance.currentUser!.uid;
    String? dToken;
    String? response = '';
    bool isExsited = false;

    try {
      //subscribe

      var mdoc =
          await FirebaseFirestore.instance.collection('users').doc(mmId).get();

      if (!mdoc.exists || mdoc == null) {
        response = "المسجد لا يملك حسابًا على تطبيق إمداد";
      } else {
        var document = await FirebaseFirestore.instance
            .collection('users')
            .doc(mmId)
            .collection("subscribedVolunteers")
            .doc(vId)
            .get();

        if (document.exists) {
          if (document != null) {
            isExsited = true;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('محتويات هذا المتطوع فارغة')));
          }
        } else {
          print('المتطوع ليس مسجل بقائمة المتطوعين');
        }

        if (!isExsited) {
          await FirebaseMessaging.instance.getToken().then((token) {
            dToken = token.toString();
          });
          await FirebaseFirestore.instance
              .collection('users')
              .doc(mmId)
              .collection("subscribedVolunteers")
              .doc(vId)
              .set({'uid': vId, 'token': dToken})
              .then((value) =>
                  {response = ' تم تفعيل التنبيهات لـ $mmName بنجاح '})
              .catchError(
                  (error) => {response = "لم يتم تفعيل التنبيهات بنجاح"});
          //add to mm
          await FirebaseFirestore.instance
              .collection('users')
              .doc(vId)
              .collection("subscribedMosqueManager")
              .doc(mmId)
              .set({'mosque_name': mmName, 'mmId': mmId});
        }

        //Unsubscribe

        else {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(mmId)
              .collection("subscribedVolunteers")
              .doc(vId)
              .delete()
              .then((value) => {
                    response = ' تم إلغاء تفعيل التنبيهات \n لـ $mmName بنجاح  '
                  })
              .catchError(
                  (error) => {response = "لم يتم إلغاء التنبيهات بنجاح"});

          await FirebaseFirestore.instance
              .collection('users')
              .doc(vId)
              .collection("subscribedMosqueManager")
              .doc(mmId)
              .delete();
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('error to subscribe $e')));
    }

    showAlertDialog(context, response);
  }

  showAlertDialog(BuildContext context, String? response) {
    // set up the button
    Widget okButton = Padding(
        padding: EdgeInsets.only(right: 20.w, bottom: 10.h),
        child: TextButton(
          child: Text(
            "موافق",
            textAlign: TextAlign.right,
            style: TextStyle(fontFamily: "Tajawal", color: Colors.white),
          ),
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xdeedd03c))),
          onPressed: () {
            int count = 0;
            Navigator.of(context).popUntil((_) => count++ >= 2);
          },
        ));
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding:
          EdgeInsets.only(right: 20.w, top: 20.h, bottom: 10.h, left: 10.w),
      title: Text(
        "تأكيد عملية الاشتراك ",
        textAlign: TextAlign.right,
        style: TextStyle(
          fontFamily: "Tajawal",
          color: const Color(0xdeedd03c),
        ),
      ),
      content: Text(
        response!
        // feedbackResponse(response)!
        ,
        textAlign: TextAlign.right,
        style: TextStyle(fontFamily: "Tajawal", height: 1.5),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  String? feedbackResponse(int response) {
    if ((response) == 1) {
//Extract the mosuqe name to add in the msg
      return "تم تفعيل التنبيهات لـ \n  شاكرين لك مساهمتك";
    } else {
      return "لم يتم تفعيل التنبيهات لمسجد بنجاح";
    }
  }

  Future<bool> isSubscribed(String mID) async {
    User? user = FirebaseAuth.instance.currentUser;
    var subscribedMosques = [];

    var uesrDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid.toString())
        .collection("subscribedMosqueManager")
        .get();

    var docs = uesrDoc.docs;
    //var length = uesrDoc.docs.length;

    for (var Doc in docs) {
      if (!subscribedMosques.contains(Doc.id)) {
        subscribedMosques.add(Doc.id);
      }
    }

    if (subscribedMosques.contains(mID)) {
      return true;
    }
    return false;
  }

  String getTime(var timeStamp) {
    final DateFormat formatter =
        DateFormat('dd/MM/yyyy'); //your date format here
    var date = timeStamp.toDate();
    return formatter.format(date);
  }

  Widget _buildWaitingScreen() {
    return Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        color: const Color(0xdeedd03c),
      ),
    );
  }

  Widget buildLinearProgress(double val) => Padding(
        padding: const EdgeInsets.only(top: 1.0),
        child: Text(
          '${(val * 100).toStringAsFixed(1)} %',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 8, fontFamily: 'Tajawal'),
          textAlign: TextAlign.center,
        ),
      );

  Widget itemsBuildLinearProgress(int donated, int all) => Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: Text(
          donated.toString() + " / " + all.toString(),
          style: TextStyle(fontSize: 11, fontFamily: 'Tajawal'),
          textAlign: TextAlign.center,
        ),
      );
  Widget buildSubscribers(BuildContext context, DocumentSnapshot document) {
    return Container(
      padding: const EdgeInsets.only(top: 5.0, bottom: 0, left: 20, right: 20),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(19.0),
        ),
        shadowColor: Color(0xdef3f1e9),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 12.0, bottom: 12.0, left: 2, right: 10),
            child: Row(children: <Widget>[
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 5),
                child: Text(
                  document['uid'].toString(),
                  style: TextStyle(fontSize: 16.0, fontFamily: 'Tajawal'),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                child: Icon(
                  Icons.person,
                  size: 35,
                  color: const Color(0xdeedd03c),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

const String mosqueImage =
    '<svg viewBox="339.0 114.0 45.0 36.0" ><path transform="translate(339.01, 114.0)" d="M 0 33.75 C 0 34.9924201965332 1.007578134536743 36 2.25 36 L 6.75 36 C 7.992422103881836 36 9 34.9924201965332 9 33.75 L 9 11.25 L 0 11.25 L 0 33.75 Z M 40.72218704223633 20.25 C 41.97797012329102 19.02726554870605 42.75 17.62453079223633 42.75 16.10789108276367 C 42.75 12.39117240905762 39.81164169311523 9.51328182220459 36.56812286376953 7.466485023498535 C 33.61921691894531 5.605313301086426 30.89882659912109 3.404531955718994 28.6959342956543 0.7010164260864258 L 28.125 0 L 27.55406188964844 0.7010156512260437 C 25.35117149353027 3.404531240463257 22.63148307800293 5.606015682220459 19.6818733215332 7.466484069824219 C 16.4383602142334 9.513280868530273 13.5 12.3911714553833 13.5 16.10789108276367 C 13.5 17.62453079223633 14.2720308303833 19.02726554870605 15.52781295776367 20.25 L 40.72218704223633 20.25 Z M 42.75 22.5 L 13.5 22.5 C 12.25757789611816 22.5 11.25 23.50757789611816 11.25 24.75 L 11.25 33.75 C 11.25 34.9924201965332 12.25757789611816 36 13.5 36 L 15.75 36 L 15.75 31.5 C 15.75 30.25757789611816 16.75757789611816 29.25 18 29.25 C 19.24242210388184 29.25 20.25 30.25757789611816 20.25 31.5 L 20.25 36 L 24.75 36 L 24.75 30.9375 C 24.75 27.5625 28.125 25.875 28.125 25.875 C 28.125 25.875 31.5 27.5625 31.5 30.9375 L 31.5 36 L 36 36 L 36 31.5 C 36 30.25757789611816 37.0075798034668 29.25 38.25 29.25 C 39.4924201965332 29.25 40.5 30.25757789611816 40.5 31.5 L 40.5 36 L 42.75 36 C 43.9924201965332 36 45 34.9924201965332 45 33.75 L 45 24.75 C 45 23.50757789611816 43.9924201965332 22.5 42.75 22.5 Z M 4.5 0 C 4.5 0 0 2.25 0 6.75 L 0 9 L 9 9 L 9 6.75 C 9 2.25 4.5 0 4.5 0 Z" fill="#edd03c" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String cancelImage =
    '<svg viewBox="34.0 103.6 19.7 19.7" ><path transform="translate(31.41, 101.72)" d="M 12.44279003143311 1.928033471107483 C 6.990582466125488 1.928033471107483 2.570700645446777 6.347914695739746 2.570700645446777 11.80012321472168 C 2.570700645446777 17.2523307800293 6.990581512451172 21.67221450805664 12.44279003143311 21.67221450805664 C 17.89500045776367 21.67221450805664 22.31488037109375 17.2523307800293 22.31488037109375 11.800124168396 C 22.31488037109375 6.347916603088379 17.89499855041504 1.92803430557251 12.44279003143311 1.92803430557251 Z M 12.44279003143311 19.82119750976562 C 8.012883186340332 19.82119750976562 4.421717166900635 16.23003196716309 4.421717166900635 11.800124168396 C 4.421717166900635 7.370216846466064 8.012883186340332 3.779050827026367 12.44279003143311 3.779050827026367 C 16.8726978302002 3.779050827026367 20.46386528015137 7.370216846466064 20.46386528015137 11.800124168396 C 20.46386528015137 16.23003196716309 16.87269973754883 19.82119750976562 12.44279003143311 19.82119750976562 Z M 15.52781867980957 6.864078521728516 L 12.44279003143311 9.949106216430664 L 9.357762336730957 6.864078521728516 L 7.506746292114258 8.715095520019531 L 10.59177398681641 11.80012321472168 L 7.506746292114258 14.88515090942383 L 9.357762336730957 16.73616790771484 L 12.44279003143311 13.6511402130127 L 15.52781867980957 16.73616790771484 L 17.37883567810059 14.88515090942383 L 14.29380702972412 11.80012321472168 L 17.37883567810059 8.715095520019531 L 15.52781867980957 6.864078521728516 Z" fill="#edd03c" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
