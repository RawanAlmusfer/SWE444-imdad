import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swe444/Models/donation.dart';
import 'package:swe444/Models/request.dart';

class RequestViewModel {
  String? _posted_by;
  String? _type;
  int? _amount;
  int _donated = 0;
  String? _description;
  String? _title;
  String? _mosque_name;
  String? _mosque_location;
  DateTime? _uplaod_time;
  String? _token;
  int? _requested;
  late String message;
  late String msgType;
  int? itemsDonated;

  get userDocument {
    return FirebaseFirestore.instance.collection("users").doc(_posted_by).get();
  }

  set postedBy(String? value) {
    if (value != null) {
      _posted_by = value;
    }
  }

  set setType(String? value) {
    if (value != null) {
      _type = value;
    }
  }

  set setAmount(int? value) {
    if (value != null) {
      _amount = value;
    }
  }

  set setDescription(String? value) {
    if (value != null) {
      _description = value;
    }
  }

  set setTitle(String? value) {
    if (value != null) {
      _title = value;
    }
  }

  set setMName(String? value) {
    if (value != null) {
      _mosque_name = value;
    }
  }

  set setMLocation(String? value) {
    if (value != null) {
      _mosque_location = value;
    }
  }

  set setUploadTime(DateTime? value) {
    if (value != null) {
      _uplaod_time = value;
    }
  }

  set setDonations(int? value) {
    if (value != null) {
      _donated = value;
    }
  }

  set setToken(String? value) {
    if (value != null) {
      _token = value;
    }
  }

  /// items requests

  // set setItem(String? value) {
  //   if (value != null) {
  //     _item = value;
  //   }
  // }

  set setRequested(int? value) {
    if (value != null) {
      _requested = value;
    }
  }

  Future<void> add() async {
    String _message = "";
    String _msgtype = "";

    if (_type == "مبلغ") {
      FundsRequest request = FundsRequest(
          amount: _amount,
          donated: _donated,
          type: _type,
          posted_by: _posted_by,
          description: _description,
          mosque_name: _mosque_name,
          mosque_location: _mosque_location,
          title: _title,
          uplaod_time: _uplaod_time,
          token: _token);

      await FirebaseFirestore.instance
          .collection('requests')
          .add(request.toJson())
          .then((value) =>
              {_message = 'تمت إضافة الطلب بنجاح', _msgtype = "success"})
          .catchError((error) =>
              {_message = " فشل في إضافة الطلب:" + error, _msgtype = "fail"});
    } else if (_type == "موارد") {
      ItemsRequest request = ItemsRequest(
          // item: _item,
          type: _type,
          donated: _donated,
          amount: _requested,
          posted_by: _posted_by,
          description: _description,
          mosque_name: _mosque_name,
          mosque_location: _mosque_location,
          title: _title,
          uplaod_time: _uplaod_time,
          token: _token);

      await FirebaseFirestore.instance
          .collection('requests')
          .add(request.toJson())
          .then((value) =>
              {_message = 'تمت إضافة الطلب بنجاح', _msgtype = "success"})
          .catchError((error) =>
              {_message = " فشل في إضافة الطلب:" + error, _msgtype = "fail"});
    }

    message = _message;
    msgType = _msgtype;
  }

  Future update(String docId) async {
    String _message = "";
    String _msgtype = "";

    if (_type == "مبلغ") {
      FundsRequest request = FundsRequest(
          amount: _amount,
          donated: _donated,
          type: _type,
          posted_by: _posted_by,
          description: _description,
          mosque_name: _mosque_name,
          mosque_location: _mosque_location,
          title: _title,
          uplaod_time: _uplaod_time,
          token: _token);

      await FirebaseFirestore.instance
          .collection('requests')
          .doc(docId)
          .set(request.toJson())
          .then((value) =>
              {_message = 'تم تعديل الطلب بنجاح', _msgtype = "success"})
          .catchError((error) =>
              {_message = " فشل في تعديل الطلب:" + error, _msgtype = "fail"});
    } else if (_type == "موارد") {
      ItemsRequest request = ItemsRequest(
          // item: _item,
          type: _type,
          donated: _donated,
          amount: _requested,
          posted_by: _posted_by,
          description: _description,
          mosque_name: _mosque_name,
          mosque_location: _mosque_location,
          title: _title,
          uplaod_time: _uplaod_time,
          token: _token);

      await FirebaseFirestore.instance
          .collection('requests')
          .doc(docId)
          .set(request.toJson())
          .then((value) =>
              {_message = 'تم تعديل الطلب بنجاح', _msgtype = "success"})
          .catchError((error) =>
              {_message = " فشل في تعديل الطلب:" + error, _msgtype = "fail"});
    }

    message = _message;
    msgType = _msgtype;
  }

  // Future donateItem(DocumentSnapshot document, String amount) async {
  //   String _message = "";
  //   String _msgtype = "";
  //   int? items=  int.parse(amount);
  //
  //     FundsRequest request = FundsRequest(
  //         type: document['type'],
  //         donated: items,
  //         amount: int.parse(document['amount']),
  //         posted_by: document['posted_by'],
  //         description: document['description'],
  //         mosque_name: document['mosque_name'],
  //         mosque_location: document['mosque_location'],
  //         title: document['title'],
  //         uplaod_time: document['upload_time'], token: document['token']);
  //
  //     await FirebaseFirestore.instance
  //         .collection('requests')
  //         .doc(document.id)
  //         .set(request.toJson())
  //         .then((value) =>
  //     {_message = 'تم تسجيل التبرع بنجاح', _msgtype = "success"})
  //         .catchError((error) =>
  //     {_message = " فشل في تسجيل التبرع" + error, _msgtype = "fail"});
  //
  //
  //   message = _message;
  //   msgType = _msgtype;
  // }

  Future donateItems(
      DocumentSnapshot document, String amount, User user) async {
    String _message = "";
    String _msgtype = "";
    int? items = int.parse(amount);
    if (user != null) {
      var userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid.toString())
          .get();
      String firstName = userDoc['first_name'].toString().trim();
      String lastName = userDoc['last_name'].toString().trim();

      Donation donation = new Donation(
          items, "unconfirmed", firstName + " " + lastName, DateTime.now());

      ItemsRequest request = ItemsRequest(
          type: document['type'],
          donated: int.parse(document['donated'].toString()) + items,
          amount: int.parse(document['amount_requested'].toString()),
          posted_by: document['posted_by'],
          description: document['description'],
          mosque_name: document['mosque_name'],
          mosque_location: document['mosque_location'],
          title: document['title'],
          uplaod_time: (document['uplaod_time'] as Timestamp).toDate(),
          token: document['token']);

      await FirebaseFirestore.instance
          .collection('requests')
          .doc(document.id)
          .collection('donations')
          .add(donation.toJson())
          .then((value) async => {
                await FirebaseFirestore.instance
                    .collection('requests')
                    .doc(document.id)
                    .set(request.toJson())
                    .then((value) => {
                          _message = 'تم تسجيل التبرع بنجاح',
                          _msgtype = "success"
                        })
                    .catchError((error) => {
                          _message = " فشل في تسجيل التبرع" + error,
                          _msgtype = "fail"
                        }),
              })
          .catchError((error) => {
                _message = " فشل في تسجيل التبرع" + error,
                _msgtype = "fail",
              });

      message = _message;
      msgType = _msgtype;
    }
  }

  Future cancelRequest(DocumentSnapshot document) async {
    String _message = "";
    String _msgtype = "";

    return await FirebaseFirestore.instance
        .collection('requests')
        .doc(document.id)
        .delete()
        .then((value) {
      _message = "تم إلغاء الطلب بنجاح";
      _msgtype = "success";
      msgType = _msgtype;
      message = _message;
    }).catchError((error) {
      _message = "فشل في إلغاء الطلب";
      _msgtype = "fail";
      msgType = _msgtype;
      message = _message;
    });
  }
}
