import 'package:mobx/mobx.dart';
import '../models/meal_model.dart';
import '../services/shared_preferences_service.dart';

part 'meal_store.g.dart';

class MealStore = _MealStoreBase with _$MealStore;

abstract class _MealStoreBase with Store {
  @observable
  Map<String, List<MealItem>?> mealItems = {};

  @observable
  bool isLoading = true;

  @action
  Future<void> loadMealData(String mealType) async {
    isLoading = true;
    try {
      List<MealItem>? data = await getMealData(mealType);
      mealItems[mealType] = data;
      if (data == null || data.isEmpty) {
        print("NO MEAL DATA FOUND FOR $mealType.");
      }
    } catch (e) {
      print("-------ERROR ----- === $e");
      mealItems[mealType] = null;
    }
    isLoading = false;
  }

  @action
  Future<void> saveMealData(String mealType, List<Map<String, String>> items) async {
    await saveMealData(mealType, items);
  }

  @action
  void refreshMealData(String mealType) {
    loadMealData(mealType);
  }
}
