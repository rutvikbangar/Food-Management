import 'package:flutter/material.dart';

final Color lightBackground = Colors.white;
final Color bluishColor = Color(0x401071A3);
final Color greyColor = Color(0xffF5F5F5);
final Color textColor = Color(0xff1071A3);
final Color darkBackground = Color(0xff2E303C);
final Color darkBluish = Color(0xff393F5E);


final ThemeData lightTheme = ThemeData(

  primaryColor: lightBackground,
  colorScheme: ColorScheme.light(
    primary: greyColor,
    secondary: bluishColor,
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.w700),
    bodyLarge: TextStyle(color: Colors.black87, fontSize: 16),
    bodyMedium: TextStyle(color:Colors.black87,fontSize: 14,fontWeight: FontWeight.w500)
  ),
);

final ThemeData darkTheme = ThemeData(

  primaryColor: darkBackground,
  colorScheme: ColorScheme.dark(
    primary: greyColor,
    secondary: darkBluish ,
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(color: Colors.white, fontSize: 20,fontWeight:FontWeight.w700),
    bodyLarge: TextStyle(color: Colors.white70, fontSize: 16),
      bodyMedium: TextStyle(color:Colors.white70,fontSize: 14,fontWeight: FontWeight.w500)

  ),
);



