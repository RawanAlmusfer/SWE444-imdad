class UserModel {
  String? uid;
  String? email;
  String? mosque_name;
  String? location;
  int? phone;

  UserModel({this.uid, this.email, this.mosque_name, this.phone, this.location});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      mosque_name: map['mosque_name'],
      phone: map['phone'],
      location: map['location'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'mosque_name': mosque_name,
      'phone_number': phone,
      'location': location,

    };
  }
}