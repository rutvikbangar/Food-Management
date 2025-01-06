// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MealStore on _MealStoreBase, Store {
  late final _$mealItemsAtom =
      Atom(name: '_MealStoreBase.mealItems', context: context);

  @override
  Map<String, List<MealItem>?> get mealItems {
    _$mealItemsAtom.reportRead();
    return super.mealItems;
  }

  @override
  set mealItems(Map<String, List<MealItem>?> value) {
    _$mealItemsAtom.reportWrite(value, super.mealItems, () {
      super.mealItems = value;
    });
  }

  late final _$mealTimesAtom =
      Atom(name: '_MealStoreBase.mealTimes', context: context);

  @override
  Map<String, String?> get mealTimes {
    _$mealTimesAtom.reportRead();
    return super.mealTimes;
  }

  @override
  set mealTimes(Map<String, String?> value) {
    _$mealTimesAtom.reportWrite(value, super.mealTimes, () {
      super.mealTimes = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_MealStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$loadMealDataAsyncAction =
      AsyncAction('_MealStoreBase.loadMealData', context: context);

  @override
  Future<void> loadMealData(String mealType) {
    return _$loadMealDataAsyncAction.run(() => super.loadMealData(mealType));
  }

  late final _$saveMealDataAsyncAction =
      AsyncAction('_MealStoreBase.saveMealData', context: context);

  @override
  Future<void> saveMealData(
      String mealType, List<Map<String, String>> items, String timerange) {
    return _$saveMealDataAsyncAction
        .run(() => super.saveMealData(mealType, items, timerange));
  }

  late final _$_MealStoreBaseActionController =
      ActionController(name: '_MealStoreBase', context: context);

  @override
  void refreshMealData(String mealType) {
    final _$actionInfo = _$_MealStoreBaseActionController.startAction(
        name: '_MealStoreBase.refreshMealData');
    try {
      return super.refreshMealData(mealType);
    } finally {
      _$_MealStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
mealItems: ${mealItems},
mealTimes: ${mealTimes},
isLoading: ${isLoading}
    ''';
  }
}
