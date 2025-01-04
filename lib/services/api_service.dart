
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:food_management/models/plan_model.dart';


class ApiLayer{

    Future<MealPlans> fecthMealPlans() async{
      final String response = await rootBundle.loadString("assets/data/sample_meal.json");
      final Map<String,dynamic> json = jsonDecode(response);
      final MealPlans data = MealPlans.fromJson(json);
      return data;
    }

}