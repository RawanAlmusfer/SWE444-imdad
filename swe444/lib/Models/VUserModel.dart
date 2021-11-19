import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VUserModel {
  String? uid;
  String? email;
  String? first_name;
  String? last_name;
  int? volunteer_phone;
  String? role;
  late String message;
  late String msgType;

  VUserModel({
    this.uid,
    this.email,
    this.first_name,
    this.last_name,
    this.volunteer_phone,
    this.role,
  });

  // receiving data from server
  factory VUserModel.fromMap(map) {
    return VUserModel(
      uid: map['uid'],
      email: map['email'],
      first_name: map['first_name'],
      last_name: map['last_name'],
      volunteer_phone: map['volunteer_phone'],
      role: map['role'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'first_name': first_name,
      'last_name': last_name,
      'phone_number': volunteer_phone,
      'role':role,
    };
  }

  Future update(String docId, User? user) async {
    String _message = "";
    String _msgtype = "";

    VUserModel volun = VUserModel(
      uid: this.uid,
      email: this.email,
      first_name: this.first_name,
      last_name: this.last_name,
      volunteer_phone: this.volunteer_phone,
      role: this.role,
    );

    // await user!
    //     .updateEmail(this.email!)
    //     .then((value) async => {
    //           _message = 'تم تحديث الملف الشخصي بنجاح',
    //           _msgtype = "success",
    //           await FirebaseFirestore.instance
    //               .collection('users')
    //               .doc(docId)
    //               .set(manger.toMap())
    //               .then((value) => {
    //                     _message = 'تم تحديث الملف الشخصي بنجاح',
    //                     _msgtype = "success"
    //                   })
    //               .catchError((error) => {
    //                     _message = " فشل في تحديث الملف الشخصي:" + error,
    //                     _msgtype = "fail"
    //                   })
    //         })
    //     .catchError((error) => {
    //           _message = " فشل في تحديث الملف الشخصي:" + error.toString(),
    //           _msgtype = "fail"
    //         });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(docId)
        .set(volun.toMap())
        .then((value) =>
    {_message = 'تم تحديث الملف الشخصي بنجاح', _msgtype = "success"})
        .catchError((error) => {
      _message = " فشل في تحديث الملف الشخصي:" + error,
      _msgtype = "fail"
    });
    message = _message;
    msgType = _msgtype;
  }

}
