import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swe444/screens/users_screen.dart';
import 'package:swe444/screens/users_screen2.dart';
import 'package:swe444/signup.dart';

import 'screens/home_screen.dart';

import 'screens/signup_screen.dart';
import 'models/authentication.dart';
import 'package:swe444/screens/xd_starting_screen.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Authentication(),
        )
      ],
      child: MaterialApp(
        title: 'Login App',
        theme: ThemeData(
          primaryColor: Colors.blue,
        ),
        // home:LoginPageWidget(),
       // home:UsersScreen(),
       // home:UsersScreen2(),
       home:SignUpPage(),



      ),


      //routes: {
      // SignupScreen.routeName: (ctx)=> SignupScreen(),

      // HomeScreen.routeName: (ctx)=> HomeScreen(),
      //},
    );


  }
}
