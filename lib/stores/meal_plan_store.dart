  import 'package:mobx/mobx.dart';
  import '../models/plan_model.dart';
  import '../services/api_service.dart';

  part 'meal_plan_store.g.dart';

  class MealPlanStore = _MealPlanStore with _$MealPlanStore;

  abstract class _MealPlanStore with Store {
    @observable
    ObservableList<Plan> plans = ObservableList<Plan>();

    @observable
    bool isloading=true;

    @action
    Future<void> loadInitialPlans(ApiLayer api) async {
      try {

        final MealPlans mealPlans = await api.fecthMealPlans();
        if (mealPlans.plans == null || mealPlans.plans.isEmpty) {
          print('NO MEAL PLAN IS AVAILABLE');
          plans = ObservableList<Plan>();
        } else {
          plans = ObservableList.of(mealPlans.plans);
        }

      } catch (e) {
        print("------------- ERROR IS ------------  ${e}");
      }
      finally{
        isloading = false;
      }
    }

    @action
    void addPlan(Plan plan) {
      plans.add(plan);
    }
  }
