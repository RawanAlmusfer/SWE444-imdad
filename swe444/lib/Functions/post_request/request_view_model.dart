import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swe444/Models/request.dart';
import 'package:swe444/Widgets/show_snackbar.dart';

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
  String? _item;
  int? _requested;
  late String message;

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

  /// items requests
  set setItem(String? value) {
    if (value != null) {
      _item = value;
    }
  }

  set setRequested(int? value) {
    if (value != null) {
      _requested = value;
    }
  }

  Future<void> add() async {
    String _message = "";

    if (_type == "مبلغ") {
      FundsRequest request = FundsRequest(
          amount: _amount,
          type: _type,
          posted_by: _posted_by,
          description: _description,
          mosque_name: _mosque_name,
          mosque_location: _mosque_location,
          title: _title,
          uplaod_time: _uplaod_time);

      await FirebaseFirestore.instance
          .collection('requests')
          .add(request.toJson())
          .then((value) => {_message = 'تمت إضافة الطلب بنجاح'})
          .catchError((error) => _message = " فشل في إضافة الطلب:" + error);
    } else if (_type == "موارد") {
      ItemsRequest request = ItemsRequest(
          item: _item,
          type: _type,
          requested: _requested,
          posted_by: _posted_by,
          description: _description,
          mosque_name: _mosque_name,
          mosque_location: _mosque_location,
          title: _title,
          uplaod_time: _uplaod_time);

      await FirebaseFirestore.instance
          .collection('requests')
          .add(request.toJson())
          .then((value) => {_message = 'تمت إضافة الطلب بنجاح'})
          .catchError((error) => _message = " فشل في إضافة الطلب:" + error);
    }

    message = _message;
  }

  Future cancelRequest(DocumentSnapshot document) async {
    String _message = "";
    return await FirebaseFirestore.instance
        .collection('requests')
        .doc(document.id)
        .delete()
        .then((value) {
      _message = "تم إلغاء الطلب بنجاح";
      message = _message;
    }).catchError((error) {
      _message = "فشل في إلغاء الطلب";
      message = _message;
    });
  }
}
