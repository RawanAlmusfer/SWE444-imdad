import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:swe444/Functions/home_screen/feed_view_model.dart';
import 'package:swe444/Functions/home_screen/v_subscribe/subscribe.dart';
import 'package:swe444/Functions/request/request_view_model.dart';
import 'package:swe444/Payment/PaymentScreen.dart';

import 'package:url_launcher/url_launcher.dart';

import '../CustomPageRoute.dart';
import 'itemsVFeed.dart';

class moneyVFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FeedViewModel>(
        create: (_) => FeedViewModel(),
        child: Container(height: 1200, width: 450, child: mv_feed()));
  }
}

class mv_feed extends StatefulWidget {
  static String? mmEmailDonated = '';
  static String? mmNameDonated = '';
  static int wholeAmount = 0;
  static int wholeDonated = 0;

  const mv_feed({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return mvFeed();
  }
}

class mvFeed extends State<mv_feed> {
  User? user = FirebaseAuth.instance.currentUser;

  //int? donated= PaymentScreen.vDonatedAmount;
  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration.zero,
        () => setState(() {
              setup();
            }));
  }

  setup() async {
    await Provider.of<FeedViewModel>(context, listen: false).fetchRequests();
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot<Map<String, dynamic>>>? requests =
        Provider.of<FeedViewModel>(context, listen: false).requests;
    return Scaffold(
      backgroundColor: const Color(0xffededed),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 70.0),
          child: Row(
            children: [
              Text(
                "طلبات التبرع بالمال",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff334856),
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Tajawal',
                  fontSize: 24,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
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
          stream: requests,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return _buildWaitingScreen();
            return ListView.builder(
              itemCount: (snapshot.data! as QuerySnapshot).docs.length,
              itemBuilder: (BuildContext context, int index) => buildCards(
                  context, (snapshot.data! as QuerySnapshot).docs[index]),
            );
          }),
    );
  }

  Widget buildCards(BuildContext context, DocumentSnapshot document) {
    FeedViewModel feedVM = FeedViewModel();
    if (document['type'].toString() == "مبلغ" &&
        document['donated'] < document['amount']) {
      return GestureDetector(
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
          //Navigator.of(context).push(CustomPageRoute(child: itemsVFeed()));
        },
        child: Container(
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
                      Container(
                        width: 100,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20, top: 5),
                          child: Text(
                            "مسجد " + document['mosque_name'],
                            style:
                                TextStyle(fontFamily: 'Tajawal', fontSize: 12),
                            textAlign: TextAlign.center,
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
                              textDirection: TextDirection
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
                                textDirection: TextDirection
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
                                textDirection: TextDirection.rtl,
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
                            mv_feed.wholeDonated = document['donated'];
                            int cumDonated = document['donated'];
                            mv_feed.wholeAmount = document['amount'];
                            String? mName = document['mosque_name'];

                            mv_feed.mmNameDonated = mName;

                            var documentFormmId = await FirebaseFirestore
                                .instance
                                .collection('users')
                                .doc(mmId)
                                .get();

                            String? mmEmail = documentFormmId['email'];
                            mv_feed.mmEmailDonated = mmEmail;

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
                          icon: Icon(Icons.notifications,
                              color: Color(0xdeedd03c)),
                          onPressed: () async {
                            String vId =
                                await FirebaseAuth.instance.currentUser!.uid;
                            String mmId = document['posted_by'];
                            String mmName = document['mosque_name'];
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
                                      SnackBar(
                                          content: Text(
                                              'محتويات هذا المتطوع فارغة')));
                                }
                              } else {
                                print('المتطوع ليس مسجل بقائمة المتطوعين');
                              }

                              if (!isExsited) {
                                FirebaseMessaging.instance
                                    .getToken()
                                    .then((token) {
                                  dToken = token.toString();
                                });
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(mmId)
                                    .collection("subscribedVolunteers")
                                    .doc(vId)
                                    .set({'uid': vId, 'token': dToken})
                                    .then((value) => {
                                          response =
                                              ' تم تفعيل التنبيهات لمسجد $mmName بنجاح '
                                        })
                                    .catchError((error) =>
                                        //////
                                        {
                                          response =
                                              "لم يتم تفعيل التنبيهات بنجاح"
                                        });
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
                                          response =
                                              ' تم إلغاء تفعيل التنبيهات لمسجد $mmName بنجاح  '
                                        })
                                    .catchError((error) => {
                                          response =
                                              "لم يتم إلغاء التنبيهات بنجاح"
                                        });

                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(vId)
                                    .collection("subscribedMosqueManager")
                                    .doc(mmId).delete();


                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('error to subscribe $e')));
                            }

                            showAlertDialog(context, response);
                          }),
                      //If not subscribed let it be yellow else grey

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
        ),
      );
    } else {
      return Container();
    }
  }



  Future<void> subscription(String mmId,String mmName) async {
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
              SnackBar(
                  content: Text(
                      'محتويات هذا المتطوع فارغة')));
        }
      } else {
        print('المتطوع ليس مسجل بقائمة المتطوعين');
      }

      if (!isExsited) {
        FirebaseMessaging.instance
            .getToken()
            .then((token) {
          dToken = token.toString();
        });
        await FirebaseFirestore.instance
            .collection('users')
            .doc(mmId)
            .collection("subscribedVolunteers")
            .doc(vId)
            .set({'uid': vId, 'token': dToken})
            .then((value) => {
          response =
          ' تم تفعيل التنبيهات لمسجد $mmName بنجاح '
        })
            .catchError((error) =>
        //////
        {
          response =
          "لم يتم تفعيل التنبيهات بنجاح"
        });
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
          response =
          ' تم إلغاء تفعيل التنبيهات لمسجد $mmName بنجاح  '
        })
            .catchError((error) => {
          response =
          "لم يتم إلغاء التنبيهات بنجاح"
        });

        await FirebaseFirestore.instance
            .collection('users')
            .doc(vId)
            .collection("subscribedMosqueManager")
            .doc(mmId).delete();


      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('error to subscribe $e')));
    }

    showAlertDialog(context, response);
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

        Navigator.of(context).pop(context);


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

  String? feedbackResponse(int response) {
    if ((response) == 1) {
//Extract the mosuqe name to add in the msg
      return "تم تفعيل التنبيهات لمسجد \n  شاكرين لك مساهمتك";
    } else {
      return "لم يتم تفعيل التنبيهات لمسجد بنجاح";
    }
  }

}

Future<bool> isSubscribed(String mID) async {
  User? user = FirebaseAuth.instance.currentUser;
  var subscribedMosques = [];

  var uesrDoc = await FirebaseFirestore.instance
      .collection('users')
      .doc(user?.uid.toString())
      .collection("subscribedMosques")
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
                    color: Color(0xffededed), spreadRadius: 1, blurRadius: 10),
              ],
            ),
            height: 30,
            width: 70,
            child: ElevatedButton(
              onPressed: () async {
                await
                ///Here Deema
              subscription(name,id);
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
                    color: Color(0xffededed), spreadRadius: 1, blurRadius: 10),
              ],
            ),
            height: 30,
            width: 120,
            child: ElevatedButton(
              onPressed: () {
                // Unsubscribe Raneem
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

Widget _buildWaitingScreen() {
  return Scaffold(
    backgroundColor: const Color(0xffededed),
    body: Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
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
