import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swe444/Widget/show_snackbar.dart';

class mm_feed extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return mmFeed();
  }
}

class mmFeed extends State<mm_feed> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    //var userId = _fetch();
    return Scaffold(
      backgroundColor: const Color(0xffededed),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('requests')
              //.orderBy('timeCreated', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return _buildWaitingScreen();
            return ListView.builder(
              itemCount: (snapshot.data! as QuerySnapshot).docs.length,
              itemBuilder: (BuildContext context, int index) => buildCards(
                  context,
                  (snapshot.data! as QuerySnapshot).docs[index],
                  user?.uid.toString()),
            );
          }),
    );
  }

  Widget buildCards(
      BuildContext context, DocumentSnapshot document, String? id) {
    if (document['posted_by'].toString() == id) {
      //print('posted user Id ' + document['posted_by'].toString());
      //print('current user Id ' + id.toString());

      return Container(
        padding: const EdgeInsets.only(top: 10.0, left: 13, right: 13),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(19.0),
          ),
          shadowColor: Colors.blueGrey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      top: 5.0, bottom: 5.0, left: 2, right: 10),
                  child: Row(children: <Widget>[
                    Container(
                        width: 25,
                        height: 52,
                        padding: const EdgeInsets.only(
                            top: 0, bottom: 25, left: 0, right: 0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      const EdgeInsets.only(
                                          top: 0,
                                          bottom: 0,
                                          left: 0,
                                          right: 0)),
                              elevation: MaterialStateProperty.all<double>(0),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white)),
                          onPressed: () async {
                            await showAlertDialog(document);
                          },
                          child: SvgPicture.string(
                            cancelImage,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                          ),
                        )),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, top: 5),
                      child: Text(
                        document['title'],
                        style: TextStyle(fontSize: 22.0, fontFamily: 'Tajawal'),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SvgPicture.string(
                      mosqueImage,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ]),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 4.0, bottom: 40.0, right: 70),
                  child: Row(children: <Widget>[
                    const Spacer(),
                    Container(
                        width: 250, // to wrap the text in multiline
                        child: Text(
                          document['description'],
                          style: TextStyle(fontFamily: 'Tajawal'),
                          textDirection: TextDirection
                              .rtl, // make the text from right to left
                        )),
                  ]),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 0.1, bottom: 20.0, right: 63),
                  child: Row(children: <Widget>[
                    const Spacer(),
                    Text(document['amount'].toString()),
                    const Text(
                      " :المبلغ",
                      style: TextStyle(fontFamily: 'Tajawal'),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      //print('not included');
      return Container();
    }
  }

  // Future _fetch() async {
  //   User? user = await FirebaseAuth.instance.currentUser;
  //   return user?.uid.toString();
  // }

  Future cancelRequest(DocumentSnapshot document) async {
    final doc =
        FirebaseFirestore.instance.collection('requests').doc(document.id);

    Snackbar bar = Snackbar(context, 'Request canceled successfully');
    bar.showToast();

    return await doc.delete();
  }

  showAlertDialog(DocumentSnapshot document) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      child: const Text(
        "إلغاء",
        style: TextStyle(color: const Color(0xdeedd03c)),
      ),
      onPressed: () {
        Navigator.of(context).pop(context);
      },
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xdeffffff)),
          elevation: MaterialStateProperty.all<double>(0)),
    );
    Widget confirmButton = ElevatedButton(
      child: Text("تأكيد"),
      onPressed: () {
        Navigator.of(context).pop(context);
        cancelRequest(document);
      },
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xdeedd03c))),
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "إضافة",
        textAlign: TextAlign.right,
      ),
      content: Text("هل أنت متأكد من رغبتك في إلغاء الطلب؟"),
      actions: [
        cancelButton,
        confirmButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      backgroundColor: const Color(0xffededed),
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }
}

const String mosqueImage =
    '<svg viewBox="339.0 114.0 45.0 36.0" ><path transform="translate(339.01, 114.0)" d="M 0 33.75 C 0 34.9924201965332 1.007578134536743 36 2.25 36 L 6.75 36 C 7.992422103881836 36 9 34.9924201965332 9 33.75 L 9 11.25 L 0 11.25 L 0 33.75 Z M 40.72218704223633 20.25 C 41.97797012329102 19.02726554870605 42.75 17.62453079223633 42.75 16.10789108276367 C 42.75 12.39117240905762 39.81164169311523 9.51328182220459 36.56812286376953 7.466485023498535 C 33.61921691894531 5.605313301086426 30.89882659912109 3.404531955718994 28.6959342956543 0.7010164260864258 L 28.125 0 L 27.55406188964844 0.7010156512260437 C 25.35117149353027 3.404531240463257 22.63148307800293 5.606015682220459 19.6818733215332 7.466484069824219 C 16.4383602142334 9.513280868530273 13.5 12.3911714553833 13.5 16.10789108276367 C 13.5 17.62453079223633 14.2720308303833 19.02726554870605 15.52781295776367 20.25 L 40.72218704223633 20.25 Z M 42.75 22.5 L 13.5 22.5 C 12.25757789611816 22.5 11.25 23.50757789611816 11.25 24.75 L 11.25 33.75 C 11.25 34.9924201965332 12.25757789611816 36 13.5 36 L 15.75 36 L 15.75 31.5 C 15.75 30.25757789611816 16.75757789611816 29.25 18 29.25 C 19.24242210388184 29.25 20.25 30.25757789611816 20.25 31.5 L 20.25 36 L 24.75 36 L 24.75 30.9375 C 24.75 27.5625 28.125 25.875 28.125 25.875 C 28.125 25.875 31.5 27.5625 31.5 30.9375 L 31.5 36 L 36 36 L 36 31.5 C 36 30.25757789611816 37.0075798034668 29.25 38.25 29.25 C 39.4924201965332 29.25 40.5 30.25757789611816 40.5 31.5 L 40.5 36 L 42.75 36 C 43.9924201965332 36 45 34.9924201965332 45 33.75 L 45 24.75 C 45 23.50757789611816 43.9924201965332 22.5 42.75 22.5 Z M 4.5 0 C 4.5 0 0 2.25 0 6.75 L 0 9 L 9 9 L 9 6.75 C 9 2.25 4.5 0 4.5 0 Z" fill="#edd03c" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String cancelImage =
    '<svg viewBox="34.0 103.6 19.7 19.7" ><path transform="translate(31.41, 101.72)" d="M 12.44279003143311 1.928033471107483 C 6.990582466125488 1.928033471107483 2.570700645446777 6.347914695739746 2.570700645446777 11.80012321472168 C 2.570700645446777 17.2523307800293 6.990581512451172 21.67221450805664 12.44279003143311 21.67221450805664 C 17.89500045776367 21.67221450805664 22.31488037109375 17.2523307800293 22.31488037109375 11.800124168396 C 22.31488037109375 6.347916603088379 17.89499855041504 1.92803430557251 12.44279003143311 1.92803430557251 Z M 12.44279003143311 19.82119750976562 C 8.012883186340332 19.82119750976562 4.421717166900635 16.23003196716309 4.421717166900635 11.800124168396 C 4.421717166900635 7.370216846466064 8.012883186340332 3.779050827026367 12.44279003143311 3.779050827026367 C 16.8726978302002 3.779050827026367 20.46386528015137 7.370216846466064 20.46386528015137 11.800124168396 C 20.46386528015137 16.23003196716309 16.87269973754883 19.82119750976562 12.44279003143311 19.82119750976562 Z M 15.52781867980957 6.864078521728516 L 12.44279003143311 9.949106216430664 L 9.357762336730957 6.864078521728516 L 7.506746292114258 8.715095520019531 L 10.59177398681641 11.80012321472168 L 7.506746292114258 14.88515090942383 L 9.357762336730957 16.73616790771484 L 12.44279003143311 13.6511402130127 L 15.52781867980957 16.73616790771484 L 17.37883567810059 14.88515090942383 L 14.29380702972412 11.80012321472168 L 17.37883567810059 8.715095520019531 L 15.52781867980957 6.864078521728516 Z" fill="#edd03c" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
