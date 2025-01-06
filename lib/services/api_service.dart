
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:food_management/models/plan_model.dart';
import 'package:path_provider/path_provider.dart';

import '../models/plan_model.dart';


class ApiLayer{

  static const String assetPath = 'assets/data/sample_meal.json';

    Future<File> _getLocalFile() async {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/sample_meal.json');

      return file;
    }

    Future<void> _initializeLocalFile() async {
      final file = await _getLocalFile();
      if (!await file.exists()) {
        final dataString = await rootBundle.loadString(assetPath);
        await file.writeAsString(dataString);
      }
    }


    Future<MealPlans> fecthMealPlans() async{
      await _initializeLocalFile();
      final file = await _getLocalFile();
      final String response = await file.readAsString();
      final Map<String,dynamic> json = jsonDecode(response);
      final MealPlans data = MealPlans.fromJson(json);
      return data;
    }
    Future<int> getNextId() async {
      await _initializeLocalFile();
      final file = await _getLocalFile();
      final String response = await file.readAsString();
      final Map<String, dynamic> data = jsonDecode(response);


      final int lastId = data['plans'].isNotEmpty ? data['plans'].last['id'] : 0;
      return lastId + 1;
  }
  Future<void> addMealPlan(Plan newPlan) async {
    await _initializeLocalFile();
    final file = await _getLocalFile();

    final String response = await file.readAsString();
    final Map<String, dynamic> data = jsonDecode(response);
    final List<dynamic> plans = data['plans'];
    plans.add(newPlan.toJson());

    await file.writeAsString(jsonEncode(data));
  }

}