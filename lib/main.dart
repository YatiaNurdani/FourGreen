import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fourgreen/Config/config.dart';
import 'package:fourgreen/Fitur/HomeChat/HomeChat.dart';
import 'package:fourgreen/Fitur/NewsUpdate/addnews.dart';
import 'package:fourgreen/Login/login_screen.dart';
import 'package:fourgreen/Register/register_screen.dart';
import 'package:fourgreen/welcome/splash_screen.dart';
import 'package:fourgreen/welcome/welcome_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Config/config.dart';
import 'Homepage/components/homescreen.dart';
import 'Notifikasi_Setting/components/notifiers.dart';
import 'Privacy/components/notofiers.dart';
import 'Services/helperFunction.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  FourgreenApp.auth = FirebaseAuth.instance;
  FourgreenApp.sharedPreferences = await SharedPreferences.getInstance();
  FourgreenApp.firestore = Firestore.instance;

  runApp(MultiProvider(
   providers: [
    ChangeNotifierProvider<SingleNotifier>(create: (_) => SingleNotifier()),
    ChangeNotifierProvider<SingleNotifierGetar>(create: (_) => SingleNotifierGetar()),
    ChangeNotifierProvider<SingleNotifierPop>(create: (_) => SingleNotifierPop()),
    ChangeNotifierProvider<SingleNotifierTerang>(create: (_) => SingleNotifierTerang()),
    ChangeNotifierProvider<SingleNotifierPrivacy>(create: (_) =>SingleNotifierPrivacy()),
    ChangeNotifierProvider<SingleNotifierInfo>(create: (_) =>SingleNotifierInfo()),
    ChangeNotifierProvider<SingleNotifierStatus>(create: (_) =>SingleNotifierStatus()),
    ChangeNotifierProvider<SingleNotifierForum>(create: (_) =>SingleNotifierForum()),
    ChangeNotifierProvider<SingleNotifierClub>(create: (_) =>SingleNotifierClub()),
   ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool userIsLoggedIn = false;

  @override
  void initState() {
    // getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreferences().then((value){
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fourgreen',
      theme: ThemeData(
        primaryColor: HexColor('#04855e'),
        scaffoldBackgroundColor: HexColor('#04855e'),
        ),
      home: userIsLoggedIn ?  HomeScreen() : SplashScreen(),
      routes: {
        "/register": (_) => new RegisterScreen(),
        "/login": (_) => new LoginScreen(),
        "/logout": (_) => new WelcomeScreen(),
        } ,
    );
  }
}


