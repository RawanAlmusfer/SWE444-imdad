import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:swe444/post_request.dart';
import 'package:swe444/home.dart';
import 'mm_feed.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(mm_feed());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.white,
        accentColor: Colors.white,
        scaffoldBackgroundColor: Color(0xff070706),
      ),
      home: HomePage(),
    );
  }
}
