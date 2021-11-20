import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
import 'package:swe444/Payment/PaymentScreen.dart';
import 'dart:ui' as ui;


class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FeedViewModel>(
        create: (_) => FeedViewModel(),
        child: Container(height: 1200, width: 450, child: SearchRequests()));
  }
}

class SearchRequests extends StatefulWidget {
  static String? mmEmailDonated = '';
  static String? mmNameDonated = '';
  static int wholeAmount = 0;
  static int wholeDonated = 0;

  const SearchRequests({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SearchRequests();
  }
}

class _SearchRequests extends State<SearchRequests> {
  int? donated = PaymentScreen.vDonatedAmount;
  bool isExecuted = false;
  TextEditingController searchTerm = TextEditingController();
  String search = "";
  int i = 0;
  int numOfResults = 0;

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  searchFunc(String s) async {
    await Provider.of<FeedViewModel>(context, listen: false).fetchRequests();
    Provider.of<FeedViewModel>(context, listen: false).getSearchResults.clear();
    await Provider.of<FeedViewModel>(context, listen: false)
        .QueryRequests(s.trim());
  }

  @override
  Widget build(BuildContext context) {
    {
      return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: AppBar(
              backgroundColor: const Color(0xffededed),
              automaticallyImplyLeading: false,
              elevation: 0,
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(
                    left: 30.0, right: 30, top: 20, bottom: 10),
                child: Stack(
                  children: [
                    TextField(
                      maxLines: 1,
                      controller: searchTerm,
                      onChanged: (_val) {
                        if (_val != null) {
                          numOfResults = 0;
                          searchTerm.text = _val;
                          search = searchTerm.text;
                          setState(() {
                            numOfResults = 0;
                            Future.delayed(
                                Duration.zero,
                                () => setState(() {
                                      searchFunc(search);
                                    }));
                          });
                        }
                      },
                      showCursor: true,
                      cursorColor: const Color(0xdeedd03c),
                      style: TextStyle(
                          fontSize: 17, color: const Color(0xff334856)),
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        // prefixIcon: Icon(Icons.search, color: const Color(0xdeedd03c),),
                        filled: true,
                        fillColor: Color(0xbfffffff),
                        contentPadding: EdgeInsets.only(right: 20, top: 3),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.20,
                            color: const Color(0xffc1c1c1),
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: const Color(0xdeedd03c),
                          ),
                        ),
                        prefixStyle: TextStyle(
                            fontSize: 17, color: const Color(0xff334856)),
                        hoverColor: const Color(0xff334856),
                        hintText: "إبحث عن",
                        hintStyle: TextStyle(
                            fontSize: 16,
                            color: const Color(0xffcbcbcc),
                            fontFamily: 'Tajawal'),
                        labelStyle: TextStyle(
                            fontSize: 15,
                            color: const Color(0xff334856),
                            fontFamily: 'Tajawal'),
                        alignLabelWithHint: true,
                        //border: OutlineInputBorder(),
                        // hoverColor: const Color(0xff334856),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          numOfResults=0;
                          search = searchTerm.text;
                          setState(() {
                            numOfResults=0;
                            Future.delayed(
                                Duration.zero,
                                () => setState(() {
                                      searchFunc(search);
                                    }));
                          });
                        },
                        icon:
                            Icon(Icons.search, color: const Color(0xdeedd03c))),
                  ],
                ),
              ),
            ),
          ),
          backgroundColor: const Color(0xffededed),
          body: Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: ListView(
              shrinkWrap: false,
              physics: ScrollPhysics(),
              children: [
                StreamBuilder(
                    stream: Provider.of<FeedViewModel>(context, listen: false)
                        .requests,
                    builder: (context, snapshot) {
                      if (Provider.of<FeedViewModel>(context, listen: false)
                              .getSearchResults
                              .length ==
                          0)
                        return Container(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 150.0),
                            child: Text("لا يوجد نتائج مطابقة للبحث"),
                          ),
                        );
                      // return _buildWaitingScreen();
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount:
                            (snapshot.data! as QuerySnapshot).docs.length,
                        itemBuilder: (BuildContext context, int index) =>
                            buildCards(context,
                                (snapshot.data! as QuerySnapshot).docs[index]),
                      );
                    }),
                if (Provider.of<FeedViewModel>(context, listen: false)
                    .getSearchResults
                    .length !=
                    0)
                  Container(
                      margin: const EdgeInsets.only(top: 30.0, bottom: 20),
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "نتائج البحث: $numOfResults",
                        style: TextStyle(color: Color(0xff8b8b8b)),
                      ))
              ],
            ),
          ));
    }
  }

  Widget buildCards(BuildContext context, DocumentSnapshot document) {
    if (Provider.of<FeedViewModel>(context, listen: false)
        .getSearchResults
        .contains(document.id)) {
      if (Provider.of<FeedViewModel>(context, listen: false)
              .getSearchResults
              .first ==
          document.id) {
        SchedulerBinding.instance!.addPostFrameCallback((_) {
          if (mounted)
            setState(() {
              numOfResults = Provider.of<FeedViewModel>(context, listen: false)
                  .getSearchResults
                  .length;
            });
        });
      }
      if (document['type'].toString() == "مبلغ")
        return buildFundsCards(context, document);
      else if (document['type'].toString() == "موارد")
        return buildItemsCards(context, document);
      else if (document['type'].toString() == "تنظيم")
        return buildEventsCards(context, document);
      else {
        return Container();
      }
    } else {
      return Container();
    }
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
                          bool flag = await isSubscribed(document['posted_by']);
                          print("Flag is " + flag.toString());
                          if (!flag) {
                            showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(19.0),
                                  ),
                                ),
                                context: context,
                                builder: (context) => BuildSubscribedProfile(
                                    document['mosque_name'].toString(),
                                    document['posted_by'].toString()));
                          } else {
                            showModalBottomSheet(
                              //isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(19.0),
                                  ),
                                ),
                                context: context,
                                builder: (context) => BuildUnsubscribedProfile(
                                    document['mosque_name'].toString(),
                                    document['posted_by'].toString()));
                          }
                          //await
                          //Navigator.of(context).pop(CustomPageRoute(child: itemsVFeed()));
                        },
                        child: Container(
                          width: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20, top: 5),
                            child: Text(
                              "مسجد " + document['mosque_name'],
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
                          bool flag = await isSubscribed(document['posted_by']);
                          print("Flag is " + flag.toString());
                          if (!flag) {
                            showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(19.0),
                                  ),
                                ),
                                context: context,
                                builder: (context) => BuildSubscribedProfile(
                                    document['mosque_name'].toString(),
                                    document['posted_by'].toString()));
                          } else {
                            showModalBottomSheet(
                              //isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(19.0),
                                  ),
                                ),
                                context: context,
                                builder: (context) => BuildUnsubscribedProfile(
                                    document['mosque_name'].toString(),
                                    document['posted_by'].toString()));
                          }
                          //await
                          //Navigator.of(context).pop(CustomPageRoute(child: itemsVFeed()));
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
                            SearchRequests.wholeDonated = document['donated'];
                            int cumDonated = document['donated'];
                            SearchRequests.wholeAmount = document['amount'];
                            String? mName = document['mosque_name'];

                            SearchRequests.mmNameDonated = mName;

                            var documentFormmId = await FirebaseFirestore.instance
                                .collection('users')
                                .doc(mmId)
                                .get();

                            String? mmEmail = documentFormmId['email'];
                            SearchRequests.mmEmailDonated = mmEmail;

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
      } else {
        return Container();
      }
    }
  }

  Widget buildItemsCards(BuildContext context, DocumentSnapshot document) {
    FeedViewModel feedVM = FeedViewModel();
    if (document['type'].toString() == "موارد") {
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
                        bool flag = await isSubscribed(document['posted_by']);
                        print("Flag is " + flag.toString());
                        if (!flag) {
                          showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(19.0),
                                ),
                              ),
                              context: context,
                              builder: (context) => BuildSubscribedProfile(
                                  document['mosque_name'].toString(),
                                  document['posted_by'].toString()));
                        } else {
                          showModalBottomSheet(
                            //isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(19.0),
                                ),
                              ),
                              context: context,
                              builder: (context) => BuildUnsubscribedProfile(
                                  document['mosque_name'].toString(),
                                  document['posted_by'].toString()));
                        }
                        //await
                        //Navigator.of(context).pop(CustomPageRoute(child: itemsVFeed()));
                      },
                      child: Container(
                        width: 100,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20, top: 5),
                          child: Text(
                            "مسجد " + document['mosque_name'],
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
                        bool flag = await isSubscribed(document['posted_by']);
                        print("Flag is " + flag.toString());
                        if (!flag) {
                          showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(19.0),
                                ),
                              ),
                              context: context,
                              builder: (context) => BuildSubscribedProfile(
                                  document['mosque_name'].toString(),
                                  document['posted_by'].toString()));
                        } else {
                          showModalBottomSheet(
                            //isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(19.0),
                                ),
                              ),
                              context: context,
                              builder: (context) => BuildUnsubscribedProfile(
                                  document['mosque_name'].toString(),
                                  document['posted_by'].toString()));
                        }
                        //await
                        //Navigator.of(context).pop(CustomPageRoute(child: itemsVFeed()));
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
                        bool flag = await isSubscribed(document['posted_by']);
                        print("Flag is " + flag.toString());
                        if (!flag) {
                          showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(19.0),
                                ),
                              ),
                              context: context,
                              builder: (context) => BuildSubscribedProfile(
                                  document['mosque_name'].toString(),
                                  document['posted_by'].toString()));
                        } else {
                          showModalBottomSheet(
                            //isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(19.0),
                                ),
                              ),
                              context: context,
                              builder: (context) => BuildUnsubscribedProfile(
                                  document['mosque_name'].toString(),
                                  document['posted_by'].toString()));
                        }
                        //await
                        //Navigator.of(context).pop(CustomPageRoute(child: itemsVFeed()));
                      },
                      child: Container(
                        width: 100,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20, top: 5),
                          child: Text(
                            "مسجد " + document['mosque_name'],
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
                        bool flag = await isSubscribed(document['posted_by']);
                        print("Flag is " + flag.toString());
                        if (!flag) {
                          showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(19.0),
                                ),
                              ),
                              context: context,
                              builder: (context) => BuildSubscribedProfile(
                                  document['mosque_name'].toString(),
                                  document['posted_by'].toString()));
                        } else {
                          showModalBottomSheet(
                            //isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(19.0),
                                ),
                              ),
                              context: context,
                              builder: (context) => BuildUnsubscribedProfile(
                                  document['mosque_name'].toString(),
                                  document['posted_by'].toString()));
                        }
                        //await
                        //Navigator.of(context).pop(CustomPageRoute(child: itemsVFeed()));
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
    } else {
      return Container();
    }
  }

  Widget BuildSubscribedProfile(String name, String id) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
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
          Text(
            "مسجد " + name,
            style: TextStyle(
              fontSize: 18.0,
              fontFamily: 'Tajawal',
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
            child: Container(
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
                  await subscription(id, name);
                },
                child: Text(
                  "تابع",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Tajawal', color: const Color(0xff334856)),
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
          ),
        ],
      ),
    );
  }

  Widget BuildUnsubscribedProfile(String name, String id) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
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
          Text(
            "مسجد " + name,
            style: TextStyle(
              fontSize: 18.0,
              fontFamily: 'Tajawal',
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Color(0xffededed),
                      spreadRadius: 1,
                      blurRadius: 10),
                ],
              ),
              height: 30,
              width: 120,
              child: ElevatedButton(
                onPressed: () async {
                  await subscription(id, name);
                },
                child: Text(
                  "إلغاء المتابعة",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Tajawal', color: const Color(0xff334856)),
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
          ),
        ],
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
                {response = ' تم تفعيل التنبيهات لمسجد $mmName بنجاح '})
            .catchError((error) =>
                //////
                {response = "لم يتم تفعيل التنبيهات بنجاح"});
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
            .then((value) =>
                {response = ' تم إلغاء تفعيل التنبيهات لمسجد $mmName بنجاح  '})
            .catchError((error) => {response = "لم يتم إلغاء التنبيهات بنجاح"});

        await FirebaseFirestore.instance
            .collection('users')
            .doc(vId)
            .collection("subscribedMosqueManager")
            .doc(mmId)
            .delete();
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('error to subscribe $e')));
    }

    showAlertDialog(context, response);
  }

  String? feedbackResponse(int response) {
    if ((response) == 1) {
//Extract the mosuqe name to add in the msg
      return "تم تفعيل التنبيهات لمسجد \n  شاكرين لك مساهمتك";
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

  showAlertDialog(BuildContext context, String? response) {
    // set up the button
    Widget okButton = TextButton(
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
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding: EdgeInsets.only(right: 20.w, top: 20.h, bottom: 10.h),
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
        style: TextStyle(fontFamily: "Tajawal"),
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
    final DateFormat formatter = DateFormat('dd/MM/yyyy'); //your date format here
    var date = timeStamp.toDate();
    return formatter.format(date);
  }
}

Widget _buildWaitingScreen() {
  return Container(
    alignment: Alignment.center,
    child: CircularProgressIndicator(),
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
