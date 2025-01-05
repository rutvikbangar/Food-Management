// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_plan_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MealPlanStore on _MealPlanStore, Store {
  late final _$plansAtom = Atom(name: '_MealPlanStore.plans', context: context);

  @override
  ObservableList<Plan> get plans {
    _$plansAtom.reportRead();
    return super.plans;
  }

  @override
  set plans(ObservableList<Plan> value) {
    _$plansAtom.reportWrite(value, super.plans, () {
      super.plans = value;
    });
  }

  late final _$loadInitialPlansAsyncAction =
      AsyncAction('_MealPlanStore.loadInitialPlans', context: context);

  @override
  Future<void> loadInitialPlans(ApiLayer api) {
    return _$loadInitialPlansAsyncAction.run(() => super.loadInitialPlans(api));
  }

  late final _$_MealPlanStoreActionController =
      ActionController(name: '_MealPlanStore', context: context);

  @override
  void addPlan(Plan plan) {
    final _$actionInfo = _$_MealPlanStoreActionController.startAction(
        name: '_MealPlanStore.addPlan');
    try {
      return super.addPlan(plan);
    } finally {
      _$_MealPlanStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
plans: ${plans}
    ''';
  }
}
