import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swe444/Functions/signup_login_screen.dart';
import 'package:swe444/Functions/signup_login_screen_mm.dart';


class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  static const kYellow = const Color(0xdeedd03c);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xdeedd03c),
      ),
      body: new Container(

        padding: new EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(),
            child: Column(
              children: [
                Image.asset('images/logo.png'),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Text(
                  "مرحباً بك",
                  style: TextStyle(
                    color: Color(0xff334856),
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                    ),

                  ],
                ),

                ElevatedButton(

                  onPressed: () {  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignupLoginScreen()));
                  },

                  child: Text(
                    'متطوع',
                    style: TextStyle(   color: Color(0xff334856), fontSize: 20,fontWeight: FontWeight.bold,),
                  ),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor:
                    MaterialStateProperty.all(Color(0xdeedd03c)),
                    minimumSize: MaterialStateProperty.all(Size(300, 64)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(500),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                ElevatedButton(
                  onPressed: () {

                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => mSignupLoginScreen()));

                  },
                  child: Text(
                    'مالك مسجد',
                    style: TextStyle(   color: Color(0xff334856), fontSize: 20,fontWeight: FontWeight.bold,),
                  ),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor:
                    MaterialStateProperty.all(Color(0xdeedd03c)),
                    minimumSize: MaterialStateProperty.all(Size(300, 64)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(500),
                      ),
                    ),

                  ),
                )


              ],
            ),
          ),
        ),
      ),
    );
  }
}
