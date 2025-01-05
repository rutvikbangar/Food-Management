import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:food_management/pages/my_plan.dart';
import 'package:food_management/stores/meal_plan_store.dart';
import 'package:food_management/stores/theme_store.dart';
import 'package:food_management/theme/themedata.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => ThemeStore()),
        Provider<MealPlanStore>(create: (_) => MealPlanStore()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    final themestore = Provider.of<ThemeStore>(context);
    return Observer(builder: (_){
      return MaterialApp(
        theme: themestore.isDarkMode ? darkTheme : lightTheme,
        home: MyPlan(),
      );
    });
  }
}

