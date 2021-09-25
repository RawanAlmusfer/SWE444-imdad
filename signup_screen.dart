import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/authentication.dart';

import 'home_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/authentication.dart';

import 'home_screen.dart';


//project go ahead

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _passwordController = new TextEditingController();
 // TextEditingController _usernamecontroller = new TextEditingController();
  //here




  Map<String, String> _authData = {
    'email' : '',

    'password' : ''
  };

  void _showErrorDialog(String msg)
  {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An Error Occured'),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: (){
                Navigator.of(ctx).pop();
              },
            )
          ],
        )
    );
  }

  Future<void> _submit() async
  {
    if(!_formKey.currentState.validate())
    {
      return;
    }
    _formKey.currentState.save();

    try{
      await Provider.of<Authentication>(context, listen: false).signUp(
          _authData['email'],
          _authData['password']




      );
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);

    } catch(error)
    {
     // var errorMessage = 'Authentication Failed. Please try again later.';
     // _showErrorDialog(errorMessage);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),


      ),
        body: Stack(
            children: <Widget>[

    Center(
    child: Card(
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
    ),
    child: Container(
    height: 260,
    width: 300,
    padding: EdgeInsets.all(16),
    child: Form(
    key: _formKey,
    child: SingleChildScrollView(
    child: Column(
    children: <Widget>[
    //email



                        TextFormField(

                          textAlign: TextAlign.right,

                          decoration: InputDecoration(
                            labelText: "البريد الالكتروني",
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(), ),
                            validator: (value)
                          {
                            if(value.isEmpty || !value.contains('@'))
                            {
                              return 'invalid email';
                            }
                            return null;
                          },
                          onSaved: (value)
                          {
                            _authData['email'] = value;

                          },

                        ),

                        //password
                        TextFormField(
                          obscureText: true,
                          controller: _passwordController,
                          textAlign: TextAlign.right,

                          decoration: InputDecoration(
                            labelText: "كلمة السر",
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(),

                          ),
                          validator: (value)
                          {
                            if(value.isEmpty || value.length<=5)
                            {
                              return 'invalid password';
                            }
                            return null;
                          },
                          onSaved: (value)
                          {
                            _authData['password'] = value;
                          },
                        ),

                        //Confirm Password
                        TextFormField(
                          obscureText: true,
                          textAlign: TextAlign.right,

                          decoration: InputDecoration(
                            labelText: "تأكيد كلمةالسر ",
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(),
                          ),
                          validator: (value)
                          {
                            if(value.isEmpty || value != _passwordController.text)
                            {
                              return 'invalid password';
                            }
                            return null;
                          },
                          onSaved: (value)
                          {

                          },
                        ),
                        TextFormField(

                          textAlign: TextAlign.right,

                          decoration: InputDecoration(
                            labelText: "البريد الالكتروني",
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(), ),
                          validator: (value)
                          {
                            if(value.isEmpty )
                            {
                              return 'invalid email';
                            }
                            return null;
                          },
                          onSaved: (value)
                          {

                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        RaisedButton(
                          child: Text(
                              'Submit'
                          ),
                          onPressed: ()
                          {
                            _submit();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: Colors.blue,
                          textColor: Colors.white,
                        )
    ],
    ),
    ),
    ),
    ),
    ),
    )
            ],
        ),
    );
  }
}




