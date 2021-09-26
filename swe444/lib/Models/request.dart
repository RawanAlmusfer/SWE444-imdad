class Request {
  String? documentId;
  String? type;
  int? amount;
  int donated=0;
  String? description;
  String? title;
  String? mosque_name;
  String? mosque_location;



  Request(this.title,
      this.type,
      this.amount,
      this.description);

  // formatting for upload to Firbase when creating the request
  Map<String, dynamic> toJson() =>
      {
        'title': title,
        'type': type,
        'description': description,
        'amount': amount,
        'donated': donated,
      };
}

