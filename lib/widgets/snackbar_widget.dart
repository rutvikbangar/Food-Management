
import 'package:flutter/material.dart';

void showSnackbar(context, color, message){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar
    (content: Text(message, style: TextStyle(fontSize: 14,color: Colors.white),),
      backgroundColor: color,duration: Duration(seconds: 3),
      action : SnackBarAction(label: "Ok",textColor: Colors.white, onPressed:(){},)));}