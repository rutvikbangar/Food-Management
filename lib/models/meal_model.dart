
// //A basic mealitem present in breakfast,lunch,dinner etc
// class MealItem{
//   final String diet;
//   final String name;
//   MealItem({required this.diet,required this.name});
//
//   factory MealItem.fromJson(Map<String,dynamic> json){
//     return MealItem(diet: json['diet'], name: json['name']);
//   }
//
//   Map<String,dynamic> toJson() {
//     return {
//       'diet': diet,
//       'name': name,
//     };
//   }
// }

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


