import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupMViewModel {
  String? uid;
  String? email;
  String? mosque_name;
  String? mosque_location = "default";
  int? mosque_phone;
  String? mosque_code;
  String? role;
  late String message;
  bool? valid;

  SignupMViewModel(
      {this.uid,
      this.email,
      this.mosque_name,
      this.mosque_phone,
      this.mosque_location,
      this.mosque_code,
      this.role});

  get widget => null;

  set uID(String? value) {
    if (value != null) {
      uid = value;
    }
  }

  set emailSet(String? value) {
    if (value != null) {
      email = value;
    }
  }

  set mosqueName(String? value) {
    if (value != null) {
      mosque_name = value;
    }
  }

  set mosquePhone(int? value) {
    if (value != null) {
      mosque_phone = value;
    }
  }

  set mosqueCode(String? value) {
    if (value != null) {
      mosque_code = value;
    }
  }

  set userRole(String? value) {
    if (value != null) {
      role = value;
    }
  }

  // receiving data from server
  factory SignupMViewModel.fromMap(map) {
    return SignupMViewModel(
      uid: map['uid'],
      email: map['email'],
      mosque_name: map['mosque_name'],
      mosque_phone: map['mosque_phone'],
      mosque_location: map['mosque_location'],
      mosque_code: map['mosque_code'],
      role: map['role'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'mosque_name': mosque_name,
      'phone_number': mosque_phone,
      'location': mosque_location,
      'mosque_code': mosque_code,
      'role': role,
    };
  }

  Future<void> signUp(String email, String password) async {
    String _message = "";

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    firebaseFirestore
        .collection('mosques_code')
        .where('code', isEqualTo: mosque_code)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        try {
          FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password)
              .then((value) => {postDetailsToFirestore()});
          authen(email, password);
        } on FirebaseAuthException catch (e) {
          switch (e.code) {
            case "email-already-in-use":
              _message = 'البريد الإلكتروني مستخدم مسبقًا';

              break;
            case "invalid-email":
              _message = 'البديد الإلكتروني غير صالح';

              break;
            case "too-many-requests":
              _message =
                  'يجب على المستخدم إعادة المصادقة قبل تنفيذ هذه العملية';

              break;
            case "operation-not-allowed":
              _message =
                  'يجب على المستخدم إعادة المصادقة قبل تنفيذ هذه العملية';

              break;
            case "network-request-failed":
              _message =
                  'يجب على المستخدم إعادة المصادقة قبل تنفيذ هذه العملية';

              break;
            case "credential-already-in-use":
              _message = 'بيانات الاعتماد هذه مرتبطة بالفعل بحساب مستخدم مختلف';

              break;

            case "invalid-email":
              _message = 'البريد الالكتروني غير صحيح';
              break;

            default:
              _message = 'حدث خطأ ما ، أعد المحاولة من فضلك';

              break;
          }
          // snackbar2 = Snackbar(context, errorMessage);
          // snackbar2!.showToast();
        }
        ;
        if (email.isEmpty && password.isEmpty) {
          _message = "الرجاء إدخال البريد الالكتروني وكلمة السر ";
        } else if (email.isEmpty) {
          _message = " الرجاء إدخال البريد الالكتروني ";
        } else if (password.isEmpty) {
          _message = "الرجاء إدخال كلمة السر ";

          switch ("invalid-email") {
            case "invalid-email":
              _message = 'البريد الالكتروني غير صحيح';
              break;
            case "too-many-requests":
              _message =
                  'يجب على المستخدم إعادة المصادقة قبل تنفيذ هذه العملية';

              break;
            case "operation-not-allowed":
              _message =
                  'يجب على المستخدم إعادة المصادقة قبل تنفيذ هذه العملية';

              break;
            case "network-request-failed":
              _message =
                  'يجب على المستخدم إعادة المصادقة قبل تنفيذ هذه العملية';

              break;
            case "credential-already-in-use":
              _message = 'بيانات الاعتماد هذه مرتبطة بالفعل بحساب مستخدم مختلف';

              break;
            default:
              _message = 'حدث خطأ ما ، أعد المحاولة من فضلك';
              break;
          }
          // snackbar3 = Snackbar(context, _message);
          // snackbar3!.showToast();
        } //end 2ed switch
      } else {
        message = ("كود المسجد المدخل غير صالح");
      }
      ;
    }).catchError((error) {
      message = ("كود المسجد المدخل غير صالح");
    });
    message = _message;
  }

  Future<void> postDetailsToFirestore() async {
    String _message = "";
    bool? _valid;

    await FirebaseFirestore.instance
        .collection('mosques_code')
        .where('code', isEqualTo: mosque_code)
        .get()
        .then((mosques) {
      for (var mosque in mosques.docs) {
        Map<String, dynamic>? data = mosque.data();
        mosque_location = data['location'];
        FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .set(toMap())
            .then((value) {
          _message = ("تم التسجيل بنجاح ");
        }).catchError(
          (e) {
            _valid = false;
            _message = ("حدث خطأ ");
          },
        );
      }
    }).catchError(
      (e) {
        _valid = false;
        _message = ("حدث خطأ ");
      },
    );
    message = _message;
    valid = _valid;
  }

  Future<void> authen(String email, String password) async {
    {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        print(userCredential.user);
        uid = userCredential.user?.uid.toString();
        widget.onSignIn(userCredential.user!);
        //
      } on FirebaseAuthException catch (e) {
        //Snackbar(context, e.toString()).showToast();
      }
    }
  }
}
