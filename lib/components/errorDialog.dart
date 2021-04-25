import 'package:flutter/material.dart';

class ErrorAlertDialog extends StatelessWidget {
  final String message;
  const ErrorAlertDialog({
    Key key,
    this.message
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context){
    return AlertDialog(
      key: key,
      content: 
      SingleChildScrollView(
        child: Text(message)),
        actions: <Widget>[
          RaisedButton(onPressed: (){
            Navigator.pop(context);
          },
          color: Colors.red,
          child: Center(child: Text("OK"),),
        ),
      ],
    );
  }
}