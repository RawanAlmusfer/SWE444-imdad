import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:swe444/post_request.dart';
import 'package:swe444/home.dart';
import 'mm_feed.dart';
import 'home_view.dart';
import 'registration.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  //Home()
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}
