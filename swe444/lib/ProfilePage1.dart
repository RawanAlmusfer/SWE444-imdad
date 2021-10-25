
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Functions/logout.dart';





class ProfilePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage>{

  double  _drawerIconSize = 24;
  double _drawerFontSize = 17;
  String _title = "الملف الشخصي";

  final auth = FirebaseAuth.instance;

   String _userFirstName = 'User NAme';
   String _userLastName = 'Last Name';
   late String _userEmail;
   String _userPhone = '05XXX';
   String role = '';
   String? mosqueName;
   String? mosqueCode;

  User? user()  {
    return  auth.currentUser;
  }

  getUserInformation(){
    FirebaseFirestore.instance.collection('users').doc(auth.currentUser?.uid).get().then((value){
        setState(() {
          if(value.exists){
            role = value.get('role');
            if(isVolunteer()){
              if(value.data()!.containsKey('first_name')
                  && value.data()!.containsKey('last_name')
                  && value.data()!.containsKey('phone_number')
              ){
                _userFirstName = value.get('first_name');
                _userLastName = value.get('last_name');
                _userPhone = value.get('phone_number').toString();

              }
            } else{

              if(value.data()!.containsKey('mosque_name')
                  && value.data()!.containsKey('mosque_code')
                  && value.data()!.containsKey('phone_number')
              ){
                mosqueName = value.get('mosque_name');
                mosqueCode = value.get('mosque_code');
                _userPhone = value.get('phone_number').toString();

              }

            }
            print(value.data().toString());


          }

        });
    });
  }

  @override
  void initState() {
    if(auth.currentUser != null){
      _userEmail = user()!.email ?? '';
      getUserInformation();
    }


    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(


    backgroundColor: const Color(0xffededed),

      drawer: Drawer(

        child: Container(

          decoration:BoxDecoration(

              gradient: LinearGradient(

                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,

                  stops: [0.0, 1.0],
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.2),
                    Theme.of(context).accentColor.withOpacity(0.5),
                  ]
              )
          ) ,
          child: ListView(
            children: [
              DrawerHeader(

                decoration: BoxDecoration(


                  color: Theme.of(context).primaryColor,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 1.0],
                    colors: [ Theme.of(context).primaryColor,Theme.of(context).accentColor,],
                  ),
                ),
                child: Container(

                  alignment: Alignment.topRight,
                  child: Text("FlutterTutorial.Net",
                    style: TextStyle(fontSize: 25,color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.screen_lock_landscape_rounded, size: _drawerIconSize, color: Theme.of(context).accentColor,),
                title: Text('Splash Screen', style: TextStyle(fontSize: 17, color: Theme.of(context).accentColor),),
                onTap: (){
                  //  Navigator.push(context, MaterialPageRoute(builder: (context) => SplashScreen(title: "Splash Screen")));
                },
              ),
             // ListTile(
             //   leading: Icon(Icons.login_rounded,size: _drawerIconSize,color: Theme.of(context).accentColor),
              //  title: Text('Login Page', style: TextStyle(fontSize: _drawerFontSize, color: Theme.of(context).accentColor),
              //  ),
             //   onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()),);
             //   },
            //  ),
              Divider(color: Theme.of(context).primaryColor, height: 1,),
              ListTile(
                leading: Icon(Icons.person_add_alt_1, size: _drawerIconSize,color: Theme.of(context).accentColor),
                title: Text('Registration Page',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                onTap: () {

                },
              ),
              Divider(color: Theme.of(context).primaryColor, height: 1,),
              ListTile(
                leading: Icon(Icons.password_rounded, size: _drawerIconSize,color: Theme.of(context).accentColor,),
                title: Text('Forgot Password Page',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                onTap: () {
                  //   Navigator.push( context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()),);
                },
              ),
              Divider(color: Theme.of(context).primaryColor, height: 1,),
              ListTile(
                leading: Icon(Icons.verified_user_sharp, size: _drawerIconSize,color: Theme.of(context).accentColor,),
                title: Text('Verification Page',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                onTap: () {
                  //  Navigator.push( context, MaterialPageRoute(builder: (context) => ForgotPasswordVerificationPage()), );
                },
              ),
              Divider(color: Theme.of(context).primaryColor, height: 1,),
              ListTile(
                leading: Icon(Icons.logout_rounded, size: _drawerIconSize,color: Theme.of(context).accentColor,),
                title: Text('Logout',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                onTap: () {
                  SystemNavigator.pop();
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //  Container(height: 100, child: HeaderWidget(100,false,Icons.house_rounded),),
          Container(
          //width: 250, // to wrap the text in multiline


              alignment: Alignment.centerRight,

              margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [//Positioned.directional(textDirection: TextDirection.rtl, child: ,),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 5, color: Colors.white),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 20, offset: const Offset(5, 5),),
                      ],
                    ),
                    child: Icon(isVolunteer() ? Icons.person:Icons.account_balance, size: 80, color: Colors.grey.shade300,),
                  ),
                  SizedBox(height: 20,),
                 // Text(isVolunteer()?  "${_userFirstName} ${_userLastName}": "${mosqueName} ${mosqueCode}", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                  Text(isVolunteer()?  "${_userFirstName} ${_userLastName}": "مسجد "+"${mosqueName} ", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Tajawal',),),
                  SizedBox(height: 20,),
                  Text(isVolunteer() ? 'متطوع' : '', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Tajawal',),),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                          //
                          alignment: Alignment.topRight,
                          child: Text(

                            "معلومات المستخدم",

                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              fontFamily: 'Tajawal',

                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Card(
                          child: Container(

                            alignment: Alignment.topRight,

                         //   padding: EdgeInsets.all(15),
                            child: Column(

                              children: <Widget>[

                              Column(

                                 children: <Widget>[Container (alignment: Alignment.topRight,),

                               



                                    ...ListTile.divideTiles(

                                      color: Colors.grey,


                                      tiles: [
                                       ListTile(

                                            leading: Icon( isVolunteer() ? Icons.person:Icons.account_balance ),title: Text(isVolunteer() ? "الاسم الاول " : "اسم المسجد",style:TextStyle( fontFamily: 'Tajawal',),),
                                                       subtitle: Text(

                                                           "${isVolunteer() ? _userFirstName : mosqueName}",style:TextStyle( fontFamily: 'Tajawal',),),  ),


                                        ListTile(
                                            leading:Icon(isVolunteer() ? Icons.person:Icons.shield),
                                            title: Text( isVolunteer() ? "الاسم الاخير " : " كود المسجد", style:TextStyle( fontFamily: 'Tajawal',),),
                                            subtitle: Text(
                                                "${isVolunteer() ? _userLastName : mosqueCode}",style:TextStyle( fontFamily: 'Tajawal',), )

                                        ),
                                        // ListTile(
                                        //  contentPadding: EdgeInsets.symmetric(
                                        //      horizontal: 12, vertical: 4),
                                        //  leading: Icon(Icons.my_location),
                                        //  title: Text("موقع المسجد"),
                                        //   subtitle: Text("USA"),
                                        // ),
                                        ListTile(


                                           title: Text("البريد الالكتروني",style:TextStyle( fontFamily: 'Tajawal'),),

                                          subtitle: Text("${_userEmail}",style:TextStyle( fontFamily: 'Tajawal'),),
                                          leading: Icon(Icons.mail),


                                        ),
                                        ListTile(
                                          leading: Icon(Icons.phone,),
                                          title: Text("رقم الجوال",style:TextStyle( fontFamily: 'Tajawal', ),),
                                          subtitle: Text("${_userPhone}",style:TextStyle( fontFamily: 'Tajawal', ),),
                                        ),

                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          ),

                        SizedBox(height: 20,),
                       logout()
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 70,),

          ],
        ),
      ),
    );
  }//QWEqwerty123@

  bool isVolunteer() => role == 'volunteer';

}