import 'package:flutter/material.dart';

final Color lightBackground = Color(0xffFFFFFF);
final Color borderColor = Color(0xffA6A6A6);
final Color bluishColor = Color(0xff1071A3);
final Color greyColor = Color(0xffF5F5F5);
final Color darkgreyColor = Color(0xffBABABA);
final Color textColor = Color(0xff1071A3);
final Color darkBackground = Color(0xff2E303C);
final Color darkBluish = Color(0xff393F5E);
final Color iconColor = Color(0xff454545);
final Color darktextColor = Color(0xff49ABE8);


final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: lightBackground,
  colorScheme: ColorScheme.light(
    primary: greyColor,
    secondary: bluishColor,
    tertiary: textColor,
  ),
  textTheme: TextTheme(
      titleLarge: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.w700),
      titleMedium: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w500),
      bodyMedium: TextStyle(color:Colors.black87,fontSize: 14,fontWeight: FontWeight.w500)
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: darkBackground,
  colorScheme: ColorScheme.dark(
    primary: darkgreyColor,
    secondary: darkBluish ,
    tertiary: darktextColor
  ),
  textTheme: TextTheme(
      titleLarge: TextStyle(color: Colors.white, fontSize: 20,fontWeight:FontWeight.w700),
      titleMedium:TextStyle(color: Colors.black87, fontSize: 16,fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(color: darkgreyColor, fontSize: 16,fontWeight: FontWeight.w500),
      bodyMedium: TextStyle(color:Colors.white,fontSize: 14,fontWeight: FontWeight.w500)

  ),
);



