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

    var requestDocs = requests.docs;
    var length = requestDocs.length;

    // loop over each item request
    for (var doc in requestDocs) {
      // getting current request data
      var requestData = doc.data();
      // get donations collection
      var donationsCollection = await FirebaseFirestore.instance
          .collection('requests')
          .doc(doc.id)
          .collection("donations")
          .get();

      // is donations exists
      var donations = donationsCollection.docs;
      if (donations.isNotEmpty) {
        // loop over each donation for the request
        for (var donor in donations) {
          //getting curresnt doc data
          var donorData = donor.data();

          //Checking status first
          if (donorData['status'] == "unconfirmed") {
            // checking the date
            var donationDate = donorData['date'];
            var oldDonation = isAfterOneDay(donationDate);
            // print("isAfterToday: " + oldDonation.toString());
            if (oldDonation) {
              int willbeDeleted = donorData['num_of_items'];
              int oldValue = requestData['donated'];
              int newValue = oldValue - willbeDeleted;

              // update donated variable
              await FirebaseFirestore.instance
                  .collection('requests')
                  .doc(doc.id)
                  .update({'donated': newValue});

              // Delete this donation
              await FirebaseFirestore.instance
                  .collection('requests')
                  .doc(doc.id)
                  .collection("donations")
                  .doc(donor.id)
                  .delete();
            }
          }
        }
      } else {
        print("Doc title is " + requestData['title']);
        print("Empty");
      }
    }
  }

  bool isAfterOneDay(Timestamp timestamp) {
    var DonationDate = timestamp.toDate();
    var deadline = DonationDate.add(Duration(days: 1, hours: 0, minutes: 00));

    return DateTime.fromMillisecondsSinceEpoch(
      deadline.millisecondsSinceEpoch,
      isUtc: false,
    ).toUtc().isBefore(DateTime.now().toUtc());
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
