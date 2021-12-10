import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:swe444/Functions/donation/items/item_donation.dart';
import 'package:swe444/Functions/home_screen/feed_view_model.dart';
import 'package:swe444/Functions/profile/viewMosqueProfile.dart';
import 'package:swe444/Functions/subscribe/subscription.dart';
import 'package:swe444/Payment/allDonationsPaymentScreen.dart';
import 'package:swe444/Payment/moneyDonations.dart';
import 'dart:ui' as ui;

import '../CustomPageRoute.dart';
import 'all_donations_view_model.dart';
import 'items/donation_view_model.dart';

class donationsView extends StatelessWidget {
  // final List<String> donations;
  const donationsView({
    Key? key,
    // required this.donations
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AllDonationVM>(
        create: (_) => AllDonationVM(),
        child: ViewUserDonations(
            // donations: donations,
            ));
  }
}

class ViewUserDonations extends StatefulWidget {
  ViewUserDonations.ensureInitialized(
      // this.donations
      );
  // final List<String> donations;
  static String? mmEmailDonated3 = '';
  static String? mmNameDonated3 = '';
  static int wholeAmount3 = 0;
  static int wholeDonated3 = 0;

  const ViewUserDonations({
    Key? key,
    // required this.donations
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return userDonations();
  }
}

class userDonations extends State<ViewUserDonations> {
  List<String> mydonations = [];
  int? donated = allPaymentScreen.vDonatedAmount3;
  User? user = FirebaseAuth.instance.currentUser;
  postMoneyDonations postDB = new postMoneyDonations();
  bool isExecuted = false;
  int i = 0;
  int numOfResults = -1;
  Subscribe subscribe = new Subscribe();
  var donationsVM;

//String
  @override
  void initState() {
    super.initState();
    // mydonations = widget.donations;
    Future.delayed(
        Duration.zero,
        () => setState(() {
              setup();
            }));
  }

  setup() async {
    await Provider.of<AllDonationVM>(context, listen: false).fetchRequests();
    mydonations = await Provider.of<AllDonationVM>(context, listen: false)
        .usersDonations(FirebaseAuth.instance.currentUser!.uid);
    // mydonations= Provider.of<AllDonationVM>(context, listen: false).donations;
  }

  @override
  Widget build(BuildContext context) {
    donationsVM = Provider.of<AllDonationVM>(context);

    Stream<QuerySnapshot<Map<String, dynamic>>>? requests =
        donationsVM.requests;

    donationsVM.usersDonations(FirebaseAuth.instance.currentUser!.uid);

    mydonations = donationsVM
        .donations;

    SchedulerBinding.instance!.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          mydonations =
              Provider.of<AllDonationVM>(context, listen: false).donations;
          if (mydonations.length == 0) {
            none();
          }
        });
      }
    });
    // mydonations= Provider.of<AllDonationVM>(context, listen: false).donations;

    // mydonations = Provider.of<AllDonationVM>(context, listen: false).userDonations;

    return Scaffold(
      backgroundColor: const Color(0xffededed),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              margin: EdgeInsets.only(right: 20, bottom: 8),
              child: Icon(
                Icons.keyboard_backspace_rounded,
                textDirection: ui.TextDirection.rtl,
                size: 30,
                color: Color(0xff334856),
              ),
            ),
          ),
        ],
        title: Text(
          "مساهماتي",
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
      body: StreamBuilder(
          stream: requests,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return _buildWaitingScreen();
            // if (donationsVM.donations.length == 0)
            // // if (mydonations.length == 0)
            //   return Container(
            //     alignment: Alignment.center,
            //     child: Text("لا يوجد لديك اي مساهمات سابقة"),
            //   );
            return ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: (snapshot.data! as QuerySnapshot).docs.length,
              itemBuilder: (BuildContext context, int index) => buildCards(
                  context, (snapshot.data! as QuerySnapshot).docs[index], mydonations),
            );
          }),
    );
  }

  buildCards(BuildContext context, DocumentSnapshot document, List<String> mydonations) {
    // SchedulerBinding.instance!.addPostFrameCallback((_) {
    //   if (mounted) {
    //     setState(() {
    //       mydonations =
    //           Provider.of<AllDonationVM>(context, listen: false).donations;
    //       if (mydonations.length == 0) {
    //         none();
    //       }
    //     });
    //   }
    // });

    // mydonations = donationsVM.donations;
    if (mydonations.contains(document.id)) {
      if (document['type'].toString() == "مبلغ")
        return buildFundsCards(context, document);
      else if (document['type'].toString() == "موارد")
        return buildItemsCards(context, document);
      else if (document['type'].toString() == "تنظيم")
        return buildEventsCards(context, document);
      else {
        return Container();
      }
    } else
      return Container();
  }

  Widget none() {
    return Container(
      alignment: Alignment.center,
      child: Text("لا يوجد لديك اي مساهمات سابقة"),
    );
  }

  Widget buildFundsCards(BuildContext context, DocumentSnapshot document) {
    FeedViewModel feedVM = FeedViewModel();
    {
      if (document['donated'] < document['amount']) {
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
                      GestureDetector(
                        onTap: () async {
                          callProfile(
                              document['mosque_name'], document['posted_by']);
                        },
                        child: Container(
                          width: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20, top: 5),
                            child: Text(
                              document['mosque_name'],
                              style: TextStyle(
                                  fontFamily: 'Tajawal',
                                  fontSize: 12,
                                  decoration: TextDecoration.underline),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 10, top: 5),
                        child: Text(
                          document['title'],
                          style:
                              TextStyle(fontSize: 16.0, fontFamily: 'Tajawal'),
                          // textAlign: TextAlign.left,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          callProfile(
                              document['mosque_name'], document['posted_by']);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: SvgPicture.string(
                            mosqueImage,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 4.0, bottom: 15.0, right: 70),
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
                            ViewUserDonations.wholeDonated3 =
                                document['donated'];
                            int cumDonated = document['donated'];
                            ViewUserDonations.wholeAmount3 = document['amount'];
                            String? mName = document['mosque_name'];

                            ViewUserDonations.mmNameDonated3 = mName;

                            var documentFormmId = await FirebaseFirestore
                                .instance
                                .collection('users')
                                .doc(mmId)
                                .get();

                            String? mmEmail = documentFormmId['email'];
                            ViewUserDonations.mmEmailDonated3 = mmEmail;

                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => allPaymentScreen()));

                            cumDonated += allPaymentScreen.vDonatedAmount3!;

                            String docId = document.id;
                            await FirebaseFirestore.instance
                                .collection('requests')
                                .doc(docId)
                                .update({'donated': cumDonated});
                            if (allPaymentScreen.vDonatedAmount3 != 0)
                              postDB.postToDB(document, user!.uid);
                            //update the denoation for next user
                            allPaymentScreen.vDonatedAmount3 = 0;
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
      } else {
        return Container();
      }
    }
  }

  Widget buildItemsCards(BuildContext context, DocumentSnapshot document) {
    FeedViewModel feedVM = FeedViewModel();
    if (document['type'].toString() == "موارد"
        && document['amount_requested'] > document['donated']
    ) {
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
                    GestureDetector(
                      onTap: () async {
                        callProfile(
                            document['mosque_name'], document['posted_by']);
                      },
                      child: Container(
                        width: 100,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20, top: 5),
                          child: Text(
                            document['mosque_name'],
                            style: TextStyle(
                                fontFamily: 'Tajawal',
                                fontSize: 12,
                                decoration: TextDecoration.underline),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, top: 5),
                      child: Text(
                        document['title'],
                        style: TextStyle(fontSize: 16.0, fontFamily: 'Tajawal'),
                        // textAlign: TextAlign.left,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        callProfile(
                            document['mosque_name'], document['posted_by']);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: SvgPicture.string(
                          mosqueImage,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
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
                              'العدد: ' +
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
                                            document['amount_requested']),
                                        valueColor: AlwaysStoppedAnimation(
                                            Color(0xdeedd03c)),
                                        backgroundColor: Color(0xffededed),
                                      ),
                                    ),
                                    Center(
                                        child: buildLinearProgress(
                                            (document['donated'] /
                                                document['amount_requested']))),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 14.0),
                              child: Text(
                                  document['amount_requested'].toString(),
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
    } else {
      return Container();
    }
  }

  Widget buildEventsCards(BuildContext context, DocumentSnapshot document) {
    FeedViewModel feedVM = FeedViewModel();

    if (document['type'].toString() == "تنظيم") {
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
                    GestureDetector(
                      onTap: () async {
                        callProfile(
                            document['mosque_name'], document['posted_by']);
                      },
                      child: Container(
                        width: 100,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20, top: 5),
                          child: Text(
                            document['mosque_name'],
                            style: TextStyle(
                                fontFamily: 'Tajawal',
                                fontSize: 12,
                                decoration: TextDecoration.underline),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, top: 5),
                      child: Text(
                        document['title'],
                        style: TextStyle(fontSize: 16.0, fontFamily: 'Tajawal'),
                        // textAlign: TextAlign.left,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        callProfile(
                            document['mosque_name'], document['posted_by']);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: SvgPicture.string(
                          mosqueImage,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
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
                              'تاريخ البداية: ' +
                                  getTime(document['start_date']),
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
                        onPressed: () async {
                          int? wholePartsNum = document['parts_number'];
                          int? currentPartsNum = document['participants'];
                          String mName = document['mosque_name'].toString();
                          String mmId = document['posted_by'].toString();
                          String thisDocId = document.id;
                          String title = document['title'];

                          await apply(mName, mmId, wholePartsNum!,
                              currentPartsNum!, thisDocId, title);
                        },
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
    } else {
      return Container();
    }
  }

  callProfile(String name, String ID) async {
    bool flag = await isSubscribed(ID.toString());

    var followrs = await FirebaseFirestore.instance
        .collection('users')
        .doc(ID)
        .collection("subscribedVolunteers")
        .get();
    String v = followrs.docs.length.toString();
    String r = await countNumOfRequests(ID);
    Navigator.of(context).push(CustomPageRoute(
        child: MosqueMangerProfile(
      isSubscribed: flag,
      numOfVolunteers: v,
      numOfRequests: r,
      MosqueID: ID,
      MosqueName: name,
    )));
  }

  Future<String> countNumOfRequests(String mmId) async {
    var requests =
        await FirebaseFirestore.instance.collection('requests').get();
    var numOfR = 0;
    var requestDocs = requests.docs;

    // loop over each item request
    for (var doc in requestDocs) {
      var requestData = doc.data();
      if (requestData['posted_by'] == mmId) {
        numOfR = numOfR + 1;
      }
    }

    return numOfR.toString();
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

  Future<void> apply(String mmName, String mmId, int wholePartsNum,
      int currentPartsNum, String thisDocId, String title) async {
    String vId = await FirebaseAuth.instance.currentUser!.uid;
    String? response = '';
    bool isExsited = false;
    var document = await FirebaseFirestore.instance
        .collection('requests')
        .doc(thisDocId)
        .collection('applicants')
        .doc(vId)
        .get();

    if (document.exists) {
      if (document != null) {
        isExsited = true;
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('محتويات هذا المتطوع فارغة')));
      }
    } else {
      print('المتطوع ليس مسجل بقائمة المشاركين');
    }
    if (!isExsited) {
      await FirebaseFirestore.instance
          .collection('requests')
          .doc(thisDocId)
          .collection("applicants")
          .doc(vId)
          .set({'uid': vId})
          .then((value) =>
              {response = ' تم تقديم طلب للمشاركة في $title لـ $mmName بنجاح '})
          .catchError((error) => {response = "لم يتم تفعيل التنبيهات بنجاح"});
    } else
      response = ' لقد قمت بتقديم مُسبق  للمشاركة في $title لـ $mmName  ';
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
            Navigator.of(context).pop();
          },
        ));
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding:
          EdgeInsets.only(right: 20.w, top: 20.h, bottom: 10.h, left: 10.w),
      title: Text(
        "تأكيد عملية التقديم ",
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

  String getTime(var timeStamp) {
    final DateFormat formatter =
        DateFormat('dd/MM/yyyy'); //your date format here
    var date = timeStamp.toDate();
    return formatter.format(date);
  }
}

Widget _buildWaitingScreen() {
  return Scaffold(
    backgroundColor: const Color(0xffededed),
    body: Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        color: const Color(0xdeedd03c),
      ),
    ),
  );
}

Widget buildLinearProgress(double val) => Text(
      '${(val * 100).toStringAsFixed(1)} %',
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 8, fontFamily: 'Tajawal'),
      textAlign: TextAlign.center,
    );

const String mosqueImage =
    '<svg viewBox="339.0 114.0 45.0 36.0" ><path transform="translate(339.01, 114.0)" d="M 0 33.75 C 0 34.9924201965332 1.007578134536743 36 2.25 36 L 6.75 36 C 7.992422103881836 36 9 34.9924201965332 9 33.75 L 9 11.25 L 0 11.25 L 0 33.75 Z M 40.72218704223633 20.25 C 41.97797012329102 19.02726554870605 42.75 17.62453079223633 42.75 16.10789108276367 C 42.75 12.39117240905762 39.81164169311523 9.51328182220459 36.56812286376953 7.466485023498535 C 33.61921691894531 5.605313301086426 30.89882659912109 3.404531955718994 28.6959342956543 0.7010164260864258 L 28.125 0 L 27.55406188964844 0.7010156512260437 C 25.35117149353027 3.404531240463257 22.63148307800293 5.606015682220459 19.6818733215332 7.466484069824219 C 16.4383602142334 9.513280868530273 13.5 12.3911714553833 13.5 16.10789108276367 C 13.5 17.62453079223633 14.2720308303833 19.02726554870605 15.52781295776367 20.25 L 40.72218704223633 20.25 Z M 42.75 22.5 L 13.5 22.5 C 12.25757789611816 22.5 11.25 23.50757789611816 11.25 24.75 L 11.25 33.75 C 11.25 34.9924201965332 12.25757789611816 36 13.5 36 L 15.75 36 L 15.75 31.5 C 15.75 30.25757789611816 16.75757789611816 29.25 18 29.25 C 19.24242210388184 29.25 20.25 30.25757789611816 20.25 31.5 L 20.25 36 L 24.75 36 L 24.75 30.9375 C 24.75 27.5625 28.125 25.875 28.125 25.875 C 28.125 25.875 31.5 27.5625 31.5 30.9375 L 31.5 36 L 36 36 L 36 31.5 C 36 30.25757789611816 37.0075798034668 29.25 38.25 29.25 C 39.4924201965332 29.25 40.5 30.25757789611816 40.5 31.5 L 40.5 36 L 42.75 36 C 43.9924201965332 36 45 34.9924201965332 45 33.75 L 45 24.75 C 45 23.50757789611816 43.9924201965332 22.5 42.75 22.5 Z M 4.5 0 C 4.5 0 0 2.25 0 6.75 L 0 9 L 9 9 L 9 6.75 C 9 2.25 4.5 0 4.5 0 Z" fill="#edd03c" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
