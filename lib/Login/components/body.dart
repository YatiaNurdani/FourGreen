import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fourgreen/Config/auth.dart';
import 'package:fourgreen/Config/config.dart';
import 'package:fourgreen/Homepage/homepage.dart';
import 'package:fourgreen/Services/helperFunction.dart';
import 'package:fourgreen/components/errorDialog.dart';
import 'package:fourgreen/components/rounded_button.dart';
import 'package:fourgreen/components/rounded_input_field.dart';
import 'package:fourgreen/components/rounded_password_field.dart';
import 'package:fourgreen/welcome/components/background.dart';

import '../../Homepage/components/bottom_nav.dart';
import '../../Homepage/components/homescreen.dart';
import '../../Services/database.dart';

class Login extends StatefulWidget{

  // final Function toogle;
  // Login(this.toogle);

  @override
  _LoginState createState() => new _LoginState();
}
class _LoginState extends State<Login> {
  AuthMethods authMethods = new AuthMethods();
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();
  DatabaseMethods databaseMethods = new DatabaseMethods();


  QuerySnapshot snapshotUserInfo;

  bool isLoading = false;

  signIn(){
    if(formKey.currentState.validate()){
      HelperFunctions.saveUserEmailSharedPreferences(_emailTextEditingController.text);

      databaseMethods.getUserByUserEmail(_emailTextEditingController.text).then((val){
        snapshotUserInfo = val;
        HelperFunctions.saveUserNameSharedPreferences(snapshotUserInfo.documents[0].data["name"]);
        // print("${snapshotUserInfo.documents[0].data["name"]}");
      });

     setState(() {
       isLoading = true;
     });

      authMethods.signInWithEmailAndPassword( _emailTextEditingController.text, _passwordTextEditingController.text)
      .then((val){
        if(val != null) {
          HelperFunctions.saveUserLoggedInSharedPreferences(true);
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => Home  ()
          ));
        }
      });

    }
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: isLoading ?  Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ) : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(left: 0),
              child:
              Text("LOGIN TO",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              ),
              Padding(padding: EdgeInsets.only(left: 0),
              child:
              Text("YOUR ACCOUNT",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              ),
              SizedBox(height: size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                // ToggleTab(),
                LoginRoundedButton(
                  text: "LOGIN",
                  press: () {Navigator.pushReplacementNamed(context, "/login",);}),
                RegisRoundedButton(
                  text: "REGISTER",
                  press: () {Navigator.pushReplacementNamed(context, "/register",);})
              ],
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    RoundedInputField(
                      hintText: "E-mail",
                      controller: _emailTextEditingController,
                    ),
                    RoundedPasswordField(
                      hintText: "Password",
                      controller: _passwordTextEditingController,
                      maxlenght: 10,

                    ),
                    SizedBox(height: size.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(margin: EdgeInsets.only(right:10.0),
                        child: Text("Remember me",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      Container(margin: EdgeInsets.only(right:50.0),
                      child: ButtonSwitch(),
                      ),
                      ]
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text("Are you don't have an account?",
                    style: TextStyle(color: Colors.white),),
                    Text("Create a New Account",
                    style: TextStyle(color: Colors.redAccent),),
                    SizedBox(height: size.height * 0.05),
                GestureDetector(
                  onTap: (){
                    signIn();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 280,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text("Login", style: TextStyle(color: Color(0xff5fbbd9)),),
                  ),
                )
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Forgot Password?",
                    style: TextStyle(color: Colors.white, fontSize: 16),),
                  Text(" CLICK HERE",
                    style: TextStyle(color: Colors.indigo, fontSize: 12, decoration: TextDecoration.underline)),
                ]
              ),
              SizedBox(height: size.height * 0.09),
            ],
          ),
        ),
      );

    
  }
  // Future <void> login() async {
  // final formState = _formKey.currentState;
  // Route route = MaterialPageRoute(builder: (c) => Homepage());
  // if(formState.validate()){
  //   formState.save();
  //   try {
  //     Future<AuthResult> user = (FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password));
  //     user.then((userData) => {
  //     Navigator.pushReplacement(context, route)});
  //
  //   } catch(e){
  //     print(e.message);
  //   }
  // }
  // }
  
  // FirebaseAuth _auth = FirebaseAuth.instance;
  // void login() async {
  //   FirebaseUser firebaseUser;
  //   await _auth.signInWithEmailAndPassword(
  //     email: _emailTextEditingController.text,
  //     password: _passwordTextEditingController.text,
  //   ).then((authUser){
  //     firebaseUser = authUser.user;
  //   }).catchError((error) {
  //     Navigator.pop(context);
  //     showDialog(
  //       context: context,
  //       builder: (c) {
  //         return ErrorAlertDialog(message: error.message.toString(),);
  //       }
  //     );
  //   });
  //
  //   databaseMethods.getUserByUsername(_emailTextEditingController.text)
  //
  //   .then((val){
  //       snapshotUserInfo = val;
  //     HelperFunctions.saveUserNameSharedPreferences(snapshotUserInfo.documents[0].data["name"]);
  //   });


  //   if (firebaseUser != null ){
  //     readData(firebaseUser).then((value) {
  //       Navigator.pop(context);
  //       Route route = MaterialPageRoute(builder: (c) => Homepage());
  //       Navigator.pushReplacement(context, route);
  //     });
  //   }
  // }

  // Future readData(FirebaseUser user) async {
  //   Firestore.instance.collection("users").document(user.uid).get().then((dataSnapshot) async {
  //     await FourgreenApp.sharedPreferences.setString("uid", dataSnapshot.data[FourgreenApp.userUID]);
  //     await FourgreenApp.sharedPreferences.setString(FourgreenApp.userEmail, dataSnapshot.data[FourgreenApp.userEmail]);
  //     await FourgreenApp.sharedPreferences.setString(FourgreenApp.userName, dataSnapshot.data[FourgreenApp.userName]);
  //     await FourgreenApp.sharedPreferences.setString(FourgreenApp.userPhone, dataSnapshot.data[FourgreenApp.userPhone]);
  //   });
  // }

}

class ButtonSwitch extends StatefulWidget {
  @override
  _ButtonSwitchState createState() => _ButtonSwitchState();
}

class _ButtonSwitchState extends State<ButtonSwitch> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomSwitch(
              activeColor: Colors.cyan,
              value: status,
              onChanged: (value) {
                print("VALUE : $value");
                setState(() {
                  status = value;
                });
              },
            ),
            SizedBox(height: 0.1,),
            // Text('Value : $status', style: TextStyle(
            //   color: Colors.white,
            //   fontSize: 20.0
            // ),)
          ],
        ),
    );
  }
}