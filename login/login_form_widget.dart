import 'package:flutter/material.dart';
import 'users_screen.dart';

class LoginPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xdeedd03c),
        title: Text(
          'Sign In',
          style: TextStyle(color: Colors.grey),
        ),
      ),
      body: Container(

    child:SingleChildScrollView(
        child: ConstrainedBox(constraints: BoxConstraints(minHeight: 50, maxHeight: 400),
            child: Column(
            children: [ SafeArea(
            minimum: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.03,
            ),
            Column(
              children: [
                Text(
                  'مرحباً بك',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    'Sign in with your email and password or continue with socail media accounts',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            UsersScreen(),
            SingleChildScrollView(
              child: Column(
                children: [
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 20,
                    children: [],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [],
                  )
                ],
              ),
            )
          ],
        ),
      ),
      ],),) //child
    ,
    )
    ,
    ),);
  }
}
