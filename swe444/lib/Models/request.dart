class Request {
  String? posted_by;
  String? type;
  String? description;
  String? title;
  String? mosque_name;
  String? mosque_location;
  DateTime? uplaod_time;

  Request(this.title, this.type, this.posted_by, this.description,
      this.mosque_name, this.mosque_location, this.uplaod_time);

  // formatting for upload to Firebase when creating the request


}

class FundsRequest extends Request {
  int? amount;
  int donated = 0;

  FundsRequest({
    this.amount, String? posted_by,
    String? type,
    String? description,
    String? title,
    String? mosque_name,
    String? mosque_location,
    DateTime? uplaod_time}) : super(title, type, posted_by, description, mosque_name, mosque_location, uplaod_time);

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
      };
}


class ItemsRequest extends Request {
  String? item;
  int? requested;
  int donated=0;

  ItemsRequest({
    this.item, this.requested, String? posted_by,
    String? type,
    String? description,
    String? title,
    String? mosque_name,
    String? mosque_location,
    DateTime? uplaod_time}) : super(title, type, posted_by, description, mosque_name, mosque_location, uplaod_time);

  Map<String, dynamic> toJson() => {
    'posted_by': posted_by,
    'title': title,
    'type': type,
    'description': description,
    'item': item,
    'amount_requested': requested,
    'donated': donated,
    'mosque_name': mosque_name,
    'mosque_location': mosque_location,
    'uplaod_time': uplaod_time,
  };
}

