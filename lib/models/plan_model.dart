
// one plan contain different meals
import 'meal_model.dart';

class Plan {
  final int id;
  final String name;
  final String frequency;
  final String amount;
  final List<String> breakdown;
  final List<Meal> meals;

  Plan({
    required this.id,
    required this.name,
    required this.frequency,
    required this.amount,
    required this.breakdown,
    required this.meals,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      id: json['id'],
      name: json['name'],
      frequency: json['frequency'],
      amount: json['amount'],
      breakdown: List<String>.from(json['breakdown']),
      meals: (json['meals'] as List)
          .map((meal) => Meal.fromJson(meal))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'frequency': frequency,
      'amount': amount,
      'breakdown': breakdown,
      'meals': meals.map((meal) => meal.toJson()).toList(),
    };
  }
}

// List of available plans
class MealPlans {
  final List<Plan> plans;

  MealPlans({required this.plans});

  factory MealPlans.fromJson(Map<String, dynamic> json) {
    return MealPlans(
      plans: (json['plans'] as List)
          .map((plan) => Plan.fromJson(plan))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'plans': plans.map((plan) => plan.toJson()).toList(),
    };
  }
}


