import 'dart:convert';
import 'package:food_management/models/meal_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveMealData(String mealType, List<Map<String, String>> items,String timeRange) async {
  if (items.isNotEmpty) {
    final sf = await SharedPreferences.getInstance();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    String itemsJson = jsonEncode(items);

    await sf.setString('${mealType}_data', itemsJson);
    await sf.setInt('${mealType}_timestamp', timestamp);
    await sf.setString("${mealType}_timerange", timeRange);
  }
}

Future<List<MealItem>?> getMealData(String mealType) async {
  final sf = await SharedPreferences.getInstance();
  final savedTimestamp = sf.getInt('${mealType}_timestamp');
  final currentTime = DateTime.now().millisecondsSinceEpoch;
  final oneday = 24 * 60 * 60 * 1000;

  if (savedTimestamp != null && (currentTime - savedTimestamp) > oneday) {
    await sf.remove('${mealType}_data');
    await sf.remove('${mealType}_timestamp');
    await sf.remove("${mealType}_timerange");
    return null;
  }

  final itemsJson = sf.getString('${mealType}_data') ?? '';
  if (itemsJson.isNotEmpty) {
    List<dynamic> itemList = jsonDecode(itemsJson);
    return itemList
        .map((item) => MealItem.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  return null;
}

Future<String?> getMealTime(String mealType) async {
  final sf = await SharedPreferences.getInstance();
  final savedTimestamp = sf.getInt('${mealType}_timestamp');
  final currentTime = DateTime.now().millisecondsSinceEpoch;
  final oneday = 24 * 60 * 60 * 1000;

  if (savedTimestamp != null && (currentTime - savedTimestamp) > oneday) {
    await sf.remove('${mealType}_data');
    await sf.remove('${mealType}_timestamp');
    await sf.remove("${mealType}_timerange");
    return null;
  }

  return sf.getString('${mealType}_timerange');
}

