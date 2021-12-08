import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:swe444/Functions/donation/items/item_donation.dart';
import 'package:swe444/Functions/home_screen/feed_view_model.dart';

import 'donation_view_model.dart';

// class ViewItemDonations extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<DonationsViewModel>(
//         create: (_) => DonationsViewModel(),
//         child: Container(height: 1200, width: 450, child: ViewDonations()));
//   }

// }

class ViewItemDonations extends StatefulWidget {
  ViewItemDonations.ensureInitialized(this.document);
  final DocumentSnapshot document;

  const ViewItemDonations({Key? key, required this.document}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return requestDonations();
  }
}

class requestDonations extends State<ViewItemDonations> {
//String
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot<Map<String, dynamic>>>? donations = FirebaseFirestore
        .instance
        .collection('requests')
        .doc(widget.document.id)
        .collection("donations")
        .snapshots();

    return Scaffold(
      backgroundColor: const Color(0xffededed),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 150.0),
          child: Row(
            children: [
              Text(
                "التبرعات",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff334856),
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Tajawal',
                  fontSize: 24,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 80.0),
                child: IconButton(
                  icon: Icon(
                    Icons.keyboard_backspace_rounded,
                    textDirection: TextDirection.rtl,
                    size: 30,
                    color: Color(0xff334856),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
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
          stream: donations,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return _buildWaitingScreen();
            if ((snapshot.data! as QuerySnapshot).docs.length != 0)
              return ListView.builder(
                itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                itemBuilder: (BuildContext context, int index) => buildCards(
                    context, (snapshot.data! as QuerySnapshot).docs[index]),
              );
            return Container(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text("لا يوجد تبرعات حتى الآن"),
              ),
            );
          }),
    );
  }

  Widget buildCards(BuildContext context, DocumentSnapshot document) {
    if (document['status'] == "unconfirmed") {
      return Container(
        padding:
            const EdgeInsets.only(top: 5.0, bottom: 0, left: 20, right: 20),
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
                Padding(
                  padding: const EdgeInsets.only(
                      top: 5.0, bottom: 5.0, left: 2, right: 10),
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
                    width: 65,
                    child: ElevatedButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('requests')
                            .doc(widget.document.id)
                            .collection("donations")
                            .doc(document.id)
                            .set({
                          'date': document['date'],
                          'donated_by': document['donated_by'],
                          'num_of_items': document['num_of_items'],
                          'status': "confirmed"
                        });
                      },
                      child: Text(
                        "وصل",
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
                ),
                const Spacer(),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10, top: 5),
                      child: Text(
                        document['donated_by'].toString(),
                        style: TextStyle(fontSize: 16.0, fontFamily: 'Tajawal'),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 0, top: 5),
                      child: Row(children: <Widget>[
                        //Text(document['amount_requested'].toString()),
                        Text("       " + document['num_of_items'].toString()),
                        const Text(
                          " :العدد",
                          style: TextStyle(fontFamily: 'Tajawal'),
                        ),
                      ]),
                    ),
                  ],
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
    } else {
      return Container();
    }
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
