import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'list_view_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubscribedList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ListViewModel>(
        create: (_) => ListViewModel(),
        child: Container(height: 1200, width: 450, child: subscribedList()));
  }
}

class subscribedList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Subscribed_List();
  }
}

class Subscribed_List extends State<subscribedList> {
  User? user = FirebaseAuth.instance.currentUser;
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
    await Provider.of<ListViewModel>(context, listen: false).fetchMosques();
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot<Map<String, dynamic>>>? mosques =
        Provider.of<ListViewModel>(context, listen: false).mosques;

    return Scaffold(
      backgroundColor: const Color(0xffededed),
      body: Center(
        child: StreamBuilder(
            stream: mosques,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return _buildWaitingScreen();
              return ListView.builder(
                //shrinkWrap: true,
                itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                itemBuilder: (BuildContext context, int index) => buildCards(
                    context, (snapshot.data! as QuerySnapshot).docs[index]),
              );
            }),
      ),
    );
  }

  Widget buildCards(BuildContext context, DocumentSnapshot document) {
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
                      await subscription(
                          document['mmId'], document['mosque_name'].toString());
                    },
                    child: Text(
                      "إلغاء",
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
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 5),
                child: Text(
                  "مسجد " + document['mosque_name'].toString(),
                  style: TextStyle(fontSize: 16.0, fontFamily: 'Tajawal'),
                  textAlign: TextAlign.center,
                ),
              ),
              SvgPicture.string(
                mosqueImage,
                allowDrawingOutsideViewBox: true,
                fit: BoxFit.fill,
              ),
            ]),
          ),
        ),
      ),
    );
    // } else {
    //   //print('not included');
    //   return Container();
    // }
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
                {response = ' تم إلغاء تفعيل التنبيهات \n لمسجد $mmName بنجاح  '})
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
            Navigator.of(context).popUntil((_) => count++ >= 1);
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

  Widget _buildWaitingScreen() {
    return Scaffold(
      backgroundColor: const Color(0xffededed),
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }
}

const String mosqueImage =
    '<svg viewBox="339.0 114.0 45.0 36.0" ><path transform="translate(339.01, 114.0)" d="M 0 33.75 C 0 34.9924201965332 1.007578134536743 36 2.25 36 L 6.75 36 C 7.992422103881836 36 9 34.9924201965332 9 33.75 L 9 11.25 L 0 11.25 L 0 33.75 Z M 40.72218704223633 20.25 C 41.97797012329102 19.02726554870605 42.75 17.62453079223633 42.75 16.10789108276367 C 42.75 12.39117240905762 39.81164169311523 9.51328182220459 36.56812286376953 7.466485023498535 C 33.61921691894531 5.605313301086426 30.89882659912109 3.404531955718994 28.6959342956543 0.7010164260864258 L 28.125 0 L 27.55406188964844 0.7010156512260437 C 25.35117149353027 3.404531240463257 22.63148307800293 5.606015682220459 19.6818733215332 7.466484069824219 C 16.4383602142334 9.513280868530273 13.5 12.3911714553833 13.5 16.10789108276367 C 13.5 17.62453079223633 14.2720308303833 19.02726554870605 15.52781295776367 20.25 L 40.72218704223633 20.25 Z M 42.75 22.5 L 13.5 22.5 C 12.25757789611816 22.5 11.25 23.50757789611816 11.25 24.75 L 11.25 33.75 C 11.25 34.9924201965332 12.25757789611816 36 13.5 36 L 15.75 36 L 15.75 31.5 C 15.75 30.25757789611816 16.75757789611816 29.25 18 29.25 C 19.24242210388184 29.25 20.25 30.25757789611816 20.25 31.5 L 20.25 36 L 24.75 36 L 24.75 30.9375 C 24.75 27.5625 28.125 25.875 28.125 25.875 C 28.125 25.875 31.5 27.5625 31.5 30.9375 L 31.5 36 L 36 36 L 36 31.5 C 36 30.25757789611816 37.0075798034668 29.25 38.25 29.25 C 39.4924201965332 29.25 40.5 30.25757789611816 40.5 31.5 L 40.5 36 L 42.75 36 C 43.9924201965332 36 45 34.9924201965332 45 33.75 L 45 24.75 C 45 23.50757789611816 43.9924201965332 22.5 42.75 22.5 Z M 4.5 0 C 4.5 0 0 2.25 0 6.75 L 0 9 L 9 9 L 9 6.75 C 9 2.25 4.5 0 4.5 0 Z" fill="#edd03c" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
