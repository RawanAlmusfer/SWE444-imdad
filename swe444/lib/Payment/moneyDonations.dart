

import 'package:cloud_firestore/cloud_firestore.dart';

class postMoneyDonations{






  postToDB ( DocumentSnapshot document, String vId) async {
    String _message = "";
    String _msgtype = "";


    await FirebaseFirestore.instance
        .collection('requests')
        .doc(document.id)
        .collection("moneyDonations")
        .doc(vId)
        .set({'uid': vId,})

        .catchError((error) =>
    {_message = " فشل في إضافة المتبرع" + error, _msgtype = "fail"});
  }
}