import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:swe444/Functions/decisions_tree.dart';
import 'package:swe444/Functions/signup_login_screen.dart';
import 'CustomPageRoute.dart';
import 'login/login_page.dart';

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  static const kYellow = Color(0xdeedd03c);

  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration.zero,
        () => setState(() {
              setup();
            }));
  }

  setup() async {
    print("Iam in init state ____________");
    var requests = await FirebaseFirestore.instance
        .collection('requests')
        .where('type', isEqualTo: "موارد")
        .get();

    // .doc()
    // .collection("donations")
    // .snapshots().

    // var uesrDoc = await FirebaseFirestore.instance
    //   .collection('users')
    //   .doc(user?.uid.toString())
    //   .collection("subscribedMosqueManager")
    //   .get();

    var requestDocs = requests.docs;
    var length = requestDocs.length;

    // for (var Doc in requestDocs) {
    //   if (!subscribedMosques.contains(Doc.id)) {
    //     subscribedMosques.add(Doc.id);
    //   }
    // }

    print("Item requests is ____________" + length.toString());
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (ScaffoldMessenger.of(context).mounted) {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xffededed),
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.only(
          top: 120.0,
          left: 20,
          right: 20,
          bottom: 20,
        ),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: Column(
                children: [
                  Image.asset('images/logo.png'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  const Text(
                    "مرحباً بك",
                    style: TextStyle(
                        fontSize: 32.0,
                        fontFamily: 'Tajawal',
                        color: Color(0xff334856),
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(CustomPageRoute(child: SignupLoginScreen()));
                    },
                    child: const Text(
                      'تسجيل جديد',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Tajawal',
                          color: Color(0xff334856),
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(300, 64),
                      primary: kYellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(CustomPageRoute(child: LoginPage(
                        onSignIn: (User) {
                          DecisionsTree();
                        },
                      )));
                    },
                    child: const Text(
                      'تسجيل الدخول',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Tajawal',
                          color: Color(0xff334856),
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(300, 64),
                      primary: kYellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
