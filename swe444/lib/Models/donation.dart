class Donation {
  int amount;
  String status;
  String donated_by;
  DateTime donation_time;
  String uid;

  Donation(this.amount, this.status, this.donated_by, this.donation_time, this.uid );

  Map<String, dynamic> toJson() => {
    'num_of_items': amount,
    'status': status,
    'donated_by': donated_by,
    'date': donation_time,
    'uid': uid,
  };
// formatting for upload to Firebase when creating the request

}