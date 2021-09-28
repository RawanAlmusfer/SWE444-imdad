import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class v_feed extends StatelessWidget {
  const v_feed({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffededed),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('requests').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('Loading...');
            return ListView.builder(
              itemCount: (snapshot.data! as QuerySnapshot).docs.length,
              itemBuilder: (BuildContext context, int index) => buildCards(
                  context, (snapshot.data! as QuerySnapshot).docs[index]),
            );
          }),
    );
  }

  Widget buildCards(BuildContext context, DocumentSnapshot document) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0, left: 13, right: 13),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(19.0),
        ),
        shadowColor: Color(0xff334856),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    top: 5.0, bottom: 5.0, left: 2, right: 10),
                child: Row(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 20, top: 5),
                    child: Text(
                      document['mosque_name'],
                      style: TextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, top: 5),
                    child: Text(
                      document['title'],
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
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
                    const EdgeInsets.only(top: 4.0, bottom: 15.0, right: 70),
                child: Row(children: <Widget>[
                  const Spacer(),
                  Column(
                    children: [
                      Container(
                        width: 250, // to wrap the text in multiline
                        child: Text(
                          document['description'],
                          textDirection: TextDirection
                              .rtl, // make the text from right to left
                        ),
                      ),
                      Container(
                        width: 250, // to wrap the text in multiline
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            'المبلغ: ' + document['amount'].toString(),
                            textDirection: TextDirection
                                .rtl, // make the text from right to left
                          ),
                        ),
                      ),
                      Container(
                        width: 250, // to wrap the text in multiline
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "نسبة الإكتمال: ",
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 20),
                        child: SizedBox(
                          width: 230,
                          height: 10,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: LinearProgressIndicator(
                                  value: (document['donated'] /
                                      document['amount']),
                                  valueColor:
                                      AlwaysStoppedAnimation(Color(0xdeedd03c)),
                                  backgroundColor: Color(0xffededed),
                                ),
                              ),
                              Center(
                                  child: buildLinearProgress(
                                      (document['donated'] /
                                          document['amount']))),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 5.0, bottom: 5.0, left: 2, right: 10),
                child: Row(children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xffededed),
                            spreadRadius: 1,
                            blurRadius: 10),
                      ],
                    ),
                    height: 30,
                    width: 65,
                    child: TextButton(
                      onPressed: () {},
                      child: Text("تبرع", textAlign: TextAlign.center),
                      style: TextButton.styleFrom(
                        primary: Color(0xff334856),
                        backgroundColor: const Color(0xdeedd03c),
                        textStyle: TextStyle(
                          fontSize: 12,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.location_on, color: Color(0xdeedd03c)),
                    onPressed: () {
                      _lunchURL(document['mosque_location'].toString());
                    },
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _lunchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw "Could not lunch the url";
  }
}

Widget buildLinearProgress(double val) => Text(
      '${(val * 100).toStringAsFixed(1)} %',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8),
    );
const String mosqueImage =
    '<svg viewBox="339.0 114.0 45.0 36.0" ><path transform="translate(339.01, 114.0)" d="M 0 33.75 C 0 34.9924201965332 1.007578134536743 36 2.25 36 L 6.75 36 C 7.992422103881836 36 9 34.9924201965332 9 33.75 L 9 11.25 L 0 11.25 L 0 33.75 Z M 40.72218704223633 20.25 C 41.97797012329102 19.02726554870605 42.75 17.62453079223633 42.75 16.10789108276367 C 42.75 12.39117240905762 39.81164169311523 9.51328182220459 36.56812286376953 7.466485023498535 C 33.61921691894531 5.605313301086426 30.89882659912109 3.404531955718994 28.6959342956543 0.7010164260864258 L 28.125 0 L 27.55406188964844 0.7010156512260437 C 25.35117149353027 3.404531240463257 22.63148307800293 5.606015682220459 19.6818733215332 7.466484069824219 C 16.4383602142334 9.513280868530273 13.5 12.3911714553833 13.5 16.10789108276367 C 13.5 17.62453079223633 14.2720308303833 19.02726554870605 15.52781295776367 20.25 L 40.72218704223633 20.25 Z M 42.75 22.5 L 13.5 22.5 C 12.25757789611816 22.5 11.25 23.50757789611816 11.25 24.75 L 11.25 33.75 C 11.25 34.9924201965332 12.25757789611816 36 13.5 36 L 15.75 36 L 15.75 31.5 C 15.75 30.25757789611816 16.75757789611816 29.25 18 29.25 C 19.24242210388184 29.25 20.25 30.25757789611816 20.25 31.5 L 20.25 36 L 24.75 36 L 24.75 30.9375 C 24.75 27.5625 28.125 25.875 28.125 25.875 C 28.125 25.875 31.5 27.5625 31.5 30.9375 L 31.5 36 L 36 36 L 36 31.5 C 36 30.25757789611816 37.0075798034668 29.25 38.25 29.25 C 39.4924201965332 29.25 40.5 30.25757789611816 40.5 31.5 L 40.5 36 L 42.75 36 C 43.9924201965332 36 45 34.9924201965332 45 33.75 L 45 24.75 C 45 23.50757789611816 43.9924201965332 22.5 42.75 22.5 Z M 4.5 0 C 4.5 0 0 2.25 0 6.75 L 0 9 L 9 9 L 9 6.75 C 9 2.25 4.5 0 4.5 0 Z" fill="#edd03c" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
