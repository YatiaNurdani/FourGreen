import 'package:flutter/material.dart';
import 'package:fourgreen/Homepage/components/bottom_nav.dart';

class Homepage extends StatefulWidget{
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Home(),);
  }
}

