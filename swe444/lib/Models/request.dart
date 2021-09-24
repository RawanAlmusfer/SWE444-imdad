class Request {
  String? type;
  int? amount;
  String? description;
  String? title;


  Request(this.title,
      this.type,
      this.amount,
      this.description);

  // formatting for upload to Firbase when creating the trip
  Map<String, dynamic> toJson() =>
      {
        'title': title,
        'type': type,
        'description': description,
        'amount': amount,
      };
}

