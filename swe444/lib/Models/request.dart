class Request {
  String? posted_by;
  String? type;
  String? description;
  String? title;
  String? mosque_name;
  String? mosque_location;
  DateTime? uplaod_time;
  String? token;

  Request(this.title, this.type, this.posted_by, this.description,
      this.mosque_name, this.mosque_location, this.uplaod_time, this.token);

  // formatting for upload to Firebase when creating the request

}

class FundsRequest extends Request {
  int? amount;
  int donated = 0;

  FundsRequest(
      {this.amount,
      required this.donated,
      String? posted_by,
      String? type,
      String? description,
      String? title,
      String? mosque_name,
      String? mosque_location,
      DateTime? uplaod_time,
      String? token})
      : super(title, type, posted_by, description, mosque_name, mosque_location,
            uplaod_time, token);

  Map<String, dynamic> toJson() => {
        'posted_by': posted_by,
        'title': title,
        'type': type,
        'description': description,
        'amount': amount,
        'donated': donated,
        'mosque_name': mosque_name,
        'mosque_location': mosque_location,
        'uplaod_time': uplaod_time,
        "token": token,
      };
}

class ItemsRequest extends Request {
  // String? item;
  int? amount;
  int donated = 0;

  ItemsRequest(
      {
      // this.item,
      this.amount,
      required this.donated,
      String? posted_by,
      String? type,
      String? description,
      String? title,
      String? mosque_name,
      String? mosque_location,
      DateTime? uplaod_time,
      String? token})
      : super(title, type, posted_by, description, mosque_name, mosque_location,
            uplaod_time, token);

  Map<String, dynamic> toJson() => {
        'posted_by': posted_by,
        'title': title,
        'type': type,
        'description': description,
        // 'item': item,
        'amount_requested': amount,
        'donated': donated,
        'mosque_name': mosque_name,
        'mosque_location': mosque_location,
        'uplaod_time': uplaod_time,
        "token": token,
      };
}

// class VolnRequest extends Request {
//   int? number;
//   int participants = 0;
//
//   VolnRequest(
//       {this.amount,
//         required this.donated,
//         String? posted_by,
//         String? type,
//         String? description,
//         String? title,
//         String? mosque_name,
//         String? mosque_location,
//         DateTime? uplaod_time,
//         String? token})
//       : super(title, type, posted_by, description, mosque_name, mosque_location,
//       uplaod_time, token);
//
//   Map<String, dynamic> toJson() => {
//     'posted_by': posted_by,
//     'title': title,
//     'type': type,
//     'description': description,
//     'amount': amount,
//     'donated': donated,
//     'mosque_name': mosque_name,
//     'mosque_location': mosque_location,
//     'uplaod_time': uplaod_time,
//     "token": token,
//   };
// }

