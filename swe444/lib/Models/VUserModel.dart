class VUserModel {
  String? uid;
  String? email;
  String? first_name;
  String? last_name;
  int? volunteer_phone;
  String? role;

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
}
