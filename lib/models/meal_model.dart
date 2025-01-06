
//A basic mealitem present in breakfast,lunch,dinner etc
class MealItem {
  final String name;
  final String type;

  MealItem({required this.name, required this.type});

  factory MealItem.fromJson(Map<String, dynamic> json) {
    return MealItem(
      name: json['name'],
      type: json['type'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
    };
  }
}


// Single meal item
class Meal{
  final int id;
  final String type;
  final String startTime;
  final String endTime;


  Meal({required this.id,required this.type,required this.startTime,required this.endTime});

  factory Meal.fromJson(Map<String,dynamic> json){
    return Meal(
        id: json['id'],
        type: json['type'],
        startTime: json['startTime'],
        endTime: json['endTime'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'startTime': startTime,
      'endTime': endTime,
    };
  }
}


