import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Subscribe {
  Future<void> subscription(
      String mmId, String mmName, BuildContext context) async {
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
            .then(
                (value) => {response = ' تم تفعيل التنبيهات لـ$mmName بنجاح '})
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
                {response = ' تم إلغاء تفعيل التنبيهات \n لـ$mmName بنجاح  '})
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
      return "لم يتم تفعيل التنبيهات لـ بنجاح";
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

  static const String mosqueImage =
      '<svg viewBox="339.0 114.0 45.0 36.0" ><path transform="translate(339.01, 114.0)" d="M 0 33.75 C 0 34.9924201965332 1.007578134536743 36 2.25 36 L 6.75 36 C 7.992422103881836 36 9 34.9924201965332 9 33.75 L 9 11.25 L 0 11.25 L 0 33.75 Z M 40.72218704223633 20.25 C 41.97797012329102 19.02726554870605 42.75 17.62453079223633 42.75 16.10789108276367 C 42.75 12.39117240905762 39.81164169311523 9.51328182220459 36.56812286376953 7.466485023498535 C 33.61921691894531 5.605313301086426 30.89882659912109 3.404531955718994 28.6959342956543 0.7010164260864258 L 28.125 0 L 27.55406188964844 0.7010156512260437 C 25.35117149353027 3.404531240463257 22.63148307800293 5.606015682220459 19.6818733215332 7.466484069824219 C 16.4383602142334 9.513280868530273 13.5 12.3911714553833 13.5 16.10789108276367 C 13.5 17.62453079223633 14.2720308303833 19.02726554870605 15.52781295776367 20.25 L 40.72218704223633 20.25 Z M 42.75 22.5 L 13.5 22.5 C 12.25757789611816 22.5 11.25 23.50757789611816 11.25 24.75 L 11.25 33.75 C 11.25 34.9924201965332 12.25757789611816 36 13.5 36 L 15.75 36 L 15.75 31.5 C 15.75 30.25757789611816 16.75757789611816 29.25 18 29.25 C 19.24242210388184 29.25 20.25 30.25757789611816 20.25 31.5 L 20.25 36 L 24.75 36 L 24.75 30.9375 C 24.75 27.5625 28.125 25.875 28.125 25.875 C 28.125 25.875 31.5 27.5625 31.5 30.9375 L 31.5 36 L 36 36 L 36 31.5 C 36 30.25757789611816 37.0075798034668 29.25 38.25 29.25 C 39.4924201965332 29.25 40.5 30.25757789611816 40.5 31.5 L 40.5 36 L 42.75 36 C 43.9924201965332 36 45 34.9924201965332 45 33.75 L 45 24.75 C 45 23.50757789611816 43.9924201965332 22.5 42.75 22.5 Z M 4.5 0 C 4.5 0 0 2.25 0 6.75 L 0 9 L 9 9 L 9 6.75 C 9 2.25 4.5 0 4.5 0 Z" fill="#edd03c" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
}
