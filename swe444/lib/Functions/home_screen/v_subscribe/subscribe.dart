
import 'package:cloud_firestore/cloud_firestore.dart';

class Subscription{


   addToMmDoc(String vId, String mmId) async {
    var document = await FirebaseFirestore.instance
        .collection('users')
        .doc(vId)
        .get();




}

Future<bool> checkIfVExists(String vId) async {
  var document = await FirebaseFirestore.instance
      .collection('users')
      .doc(vId)
      .get();

  if (document.exists) {
    if (document != null)
    return true;
  else  return false;
  }
  else return false;


}












}

