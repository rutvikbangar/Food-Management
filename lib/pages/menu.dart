import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:food_management/stores/theme_store.dart';
import 'package:provider/provider.dart';
import '../stores/meal_store.dart';
import '../models/meal_model.dart';
import '../pages/add_menu.dart';

class Menu extends StatelessWidget {
  final MealStore mealStore = MealStore();

  @override
  Widget build(BuildContext context) {
    // Load data for all meal types
    mealStore.loadMealData("Breakfast");
    mealStore.loadMealData("Lunch");
    mealStore.loadMealData("Snacks");
    mealStore.loadMealData("Dinner");
    final theme = Theme.of(context);
    final height = MediaQuery.of(context).size.height;

    return Observer(
      builder: (_) {
        if (mealStore.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (mealStore.mealTimes == null || mealStore.mealTimes.isEmpty) {
          return Center(
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  Theme.of(context).colorScheme.secondary,
                ),
              ),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddMenu()),
                );

              },
              child: Text(
                "Add Today's Menu",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          );
        }


        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: mealStore.mealItems.length,
                itemBuilder: (context, index) {
                  String mealType = mealStore.mealItems.keys.elementAt(index);
                  List<MealItem>? items = mealStore.mealItems[mealType];
                  String? timeRange = mealStore.mealTimes[mealType];
              
                  return Card(
                    color: theme.primaryColor,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$mealType at $timeRange ",
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20,fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 8),
                          if (items != null && items.isNotEmpty)
                            ...items.map((item) => Text(
                              "${item.name} (${item.type})",
                              style: Theme.of(context).textTheme.bodyMedium,
                            )),
                          if (items == null || items.isEmpty)
                            Text(
                              "No items available",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  Theme.of(context).colorScheme.secondary,
                ),
              ),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddMenu()),
                );

              },
              child: Text(
                "Add Today's Menu",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        );
      },
    );
  }
}
