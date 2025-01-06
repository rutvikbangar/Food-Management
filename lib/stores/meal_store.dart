import 'package:mobx/mobx.dart';
import '../models/meal_model.dart';
import '../services/shared_preferences_service.dart';

part 'meal_store.g.dart';

class MealStore = _MealStoreBase with _$MealStore;

abstract class _MealStoreBase with Store {
  @observable
  Map<String, List<MealItem>?> mealItems = {};

  @observable
  Map<String, String?> mealTimes = {};

  @observable
  bool isLoading = true;

  @action
  Future<void> loadMealData(String mealType) async {
    isLoading = true;
    try {
      List<MealItem>? data = await getMealData(mealType);
      String? timeRange = await getMealTime(mealType);

      mealItems[mealType] = data;
      if(timeRange != null){
        mealTimes[mealType] = timeRange;
      }

      if (data == null) {
        print("NO MEAL DATA FOUND FOR $mealType.");
      }
    } catch (e) {
      print("-------ERROR ----- === $e");
      mealItems[mealType] = null;
      mealTimes[mealType] = null;
    }
    isLoading = false;
  }

  @action
  Future<void> saveMealData(String mealType, List<Map<String, String>> items,String timerange) async {
    await saveMealData(mealType, items,timerange);
  }

  @action
  void refreshMealData(String mealType) {
    loadMealData(mealType);
  }
}
