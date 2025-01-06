import 'package:flutter/material.dart';
import 'package:food_management/pages/my_plan.dart';
import 'package:food_management/theme/themedata.dart';
import 'package:food_management/widgets/snackbar_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../services/shared_preferences_service.dart';
import '../stores/theme_store.dart';

class AddMenu extends StatefulWidget {
  @override
  _AddMenuState createState() => _AddMenuState();
}

class _AddMenuState extends State<AddMenu> {
  final TextEditingController breakfastController = TextEditingController();
  final TextEditingController lunchController = TextEditingController();
  final TextEditingController snacksController = TextEditingController();
  final TextEditingController dinnerController = TextEditingController();

  final Map<String, List<Map<String, String>>> mealItems = {
    "Breakfast": [],
    "Lunch": [],
    "Snacks": [],
    "Dinner": [],
  };
  final Map<String, String> mealTimes = {
    "Breakfast": "",
    "Lunch": "",
    "Snacks": "",
    "Dinner": "",
  };


  void addItemType(String meal, TextEditingController controller, bool isVeg, String startTime, String endTime) {
    if (controller.text.isNotEmpty) {
      setState(() {
        // Store the time range for the meal
        mealTimes[meal] = "$startTime to $endTime";

        // Add the dish to the mealItems list
        mealItems[meal]!.add({
          "name": controller.text,
          "type": isVeg ? "veg" : "nonveg",
        });

        controller.clear();
      });
    }
  }




  Future<void> saveAllMealData() async {
    try{

      await saveMealData("Breakfast", mealItems["Breakfast"]!,mealTimes["Breakfast"]!);
      await saveMealData("Lunch", mealItems["Lunch"]!,mealTimes["Lunch"]!);
      await saveMealData("Snacks", mealItems["Snacks"]!,mealTimes["Snacks"]!);
      await saveMealData("Dinner", mealItems["Dinner"]!,mealTimes["Dinner"]!);
    }catch(e){
      print("ERROR CAUGHT AT SAVEMEALDATA] $e");
    }


  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: AppBar(
        title: Text("Set Plan"),
        backgroundColor: theme.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              MealSection(
                meal: "Breakfast",
                items: mealItems["Breakfast"]!,
                onAddItemType: addItemType,
                itemController: breakfastController,
                image: "assets/images/breakfast.png",
              ),
              SizedBox(height: height * 0.022),
              MealSection(
                meal: "Lunch",
                items: mealItems["Lunch"]!,
                onAddItemType: addItemType,
                itemController: lunchController,
                image: "assets/images/lunch.png",
              ),
              SizedBox(height: height * 0.022),
              MealSection(
                meal: "Snacks",
                items: mealItems["Snacks"]!,
                onAddItemType: addItemType,
                itemController: snacksController,
                image: "assets/images/snacks.png",
              ),
              SizedBox(height: height * 0.022),
              MealSection(
                meal: "Dinner",
                items: mealItems["Dinner"]!,
                onAddItemType: addItemType,
                itemController: dinnerController,
                image: "assets/images/dinner.png",
              ),
              SizedBox(height: height * 0.022),
              GestureDetector(
                onTap: () async {
                  if (mealItems["Breakfast"]!.isEmpty ||
                      mealItems["Lunch"]!.isEmpty ||
                      mealItems["Snacks"]!.isEmpty ||
                      mealItems["Dinner"]!.isEmpty) {
                    showSnackbar(context, Colors.red, "All fields are required");
                  } else {
                    await saveAllMealData();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MyPlan())
                    );
                  }
                },

                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Color(0XffC3C3C3), Color(0xff9FA2A3)]),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Text("Save",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),),

                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}

class MealSection extends StatefulWidget {
  final String meal;
  final List<Map<String, String>> items;
  final Function(String meal, TextEditingController controller, bool isVeg,String startTime, String endTime) onAddItemType;
  final TextEditingController itemController;
  final String image;

  MealSection({
    required this.meal,
    required this.items,
    required this.onAddItemType,
    required this.itemController,
    required this.image,
  });

  @override
  State<MealSection> createState() => _MealSectionState();
}

class _MealSectionState extends State<MealSection> {
  bool isVeg = true;
  final TextEditingController sttimeController = TextEditingController();

  final TextEditingController eddtimeController = TextEditingController();

  void _selectTime(BuildContext context, TextEditingController timeController) async {
    TimeOfDay selectedTime = TimeOfDay.now();

    final themeStore = Provider.of<ThemeStore>(context, listen: false);

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: themeStore.isDarkMode ? ThemeData.dark() : ThemeData.light(),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      timeController.text = pickedTime.format(context);
      print("TIME CONTROLLER TEXT-- ${timeController.text}");
    }
  }



  @override
  Widget build(BuildContext context) {
    final themeStore = Provider.of<ThemeStore>(context, listen: false);
    final theme = Theme.of(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 24,
                    width: 24,
                    child: Image.asset(widget.image),
                  ),
                  SizedBox(width: 10),
                  Text(
                    widget.meal,
                    style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text("${widget.meal} List", style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400)),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Start Time
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text("Start Time", style: TextStyle(color: textColor, fontSize: 11)),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: width * 0.37,
                        height: height * 0.048,
                        decoration: BoxDecoration(
                          border: Border.all(color: borderColor),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: TextField(
                          controller: sttimeController,
                          readOnly: true,
                          style: TextStyle(
                            color: sttimeController.text.isNotEmpty ? Colors.black : Colors.black,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                          onTap: ()=> _selectTime(context, sttimeController),
                        ),
                      ),
                    ],
                  ),
                  // End Time
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text("End Time", style: TextStyle(color: textColor, fontSize: 11)),
                      ),
                      Container(
                        width: width * 0.37,
                        height: height * 0.048,
                        decoration: BoxDecoration(
                          border: Border.all(color: borderColor),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: TextField(
                          controller: eddtimeController,
                          readOnly: true,
                          style: TextStyle(
                            color: eddtimeController.text.isNotEmpty ? Colors.black : Colors.black,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                          onTap: ()=> _selectTime(context, eddtimeController),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: widget.itemController,
                    ),
                  ),
                  SizedBox(width: 10),
                  Image.asset("assets/images/veg.png"),
                  Checkbox(
                    checkColor: textColor,
                    activeColor: Colors.white,
                    value: isVeg,
                    onChanged: (bool? value) {
                      if (value != null) {
                        setState(() {
                          isVeg = true;
                        });
                      }
                    },
                  ),
                  Image.asset("assets/images/nonveg.png"),
                  Checkbox(
                    checkColor: textColor,
                    activeColor: Colors.white,
                    value: !isVeg,
                    onChanged: (bool? value) {
                      if (value != null) {
                        setState(() {
                          isVeg = false;
                        });
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 12),
              ...widget.items.map((item) => ListTile(
                title: Text(item["name"]!),
                leading: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      widget.items.remove(item);
                    });
                  },
                ),
                trailing: Image.asset(
                  item["type"] == "veg" ? "assets/images/veg.png" : "assets/images/nonveg.png",
                ),
              )),
            ],
          ),
        ),




        Positioned(
          bottom: 0,
          right: 15,
          child: Container(
            alignment: Alignment.center,
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xff31749E), Color(0xff0185D8)]),
              borderRadius: BorderRadius.circular(40),
            ),
            child: IconButton(
              icon: Icon(Icons.add, color: Colors.white),
              onPressed: () {
                if(sttimeController.text.isEmpty || eddtimeController.text.isEmpty){
                  showSnackbar(context, Colors.red, "select time");
                }else{
                  widget.onAddItemType(widget.meal, widget.itemController, isVeg,sttimeController.text,eddtimeController.text);
                }

              },
            ),
          ),
        ),
      ],
    );
  }
}
