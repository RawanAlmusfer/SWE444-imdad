import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'decisions_tree.dart';
import 'mm_home_view.dart';
import 'v_home_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DecisionsTree(),
    );
  }
}
