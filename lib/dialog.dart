import 'package:flutter/material.dart';
import 'dialogAction.dart';

Future<void> alertDialog(BuildContext context,String message){
  return showDialog(
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
        title: Text('Alert'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: (){
              Navigator.of(context).pop();
            },)
      ]);
    }
  );
}

Future<DialogAction> confirmationDialog(BuildContext context,String message) {

  return showDialog<DialogAction>(
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
        title: Text('Confirmation'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Cancel'),
            onPressed: (){
              Navigator.of(context).pop(DialogAction.cancel);
            },),
          FlatButton(
            child: Text('Retry'),
            onPressed: (){
              Navigator.of(context).pop(DialogAction.retry);
          },)
      ]);
    }
  );
}