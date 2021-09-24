class Request {
  String? documentId;
  String? type;
  int? amount;
  String? description;
  String? title;


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
      };
}

