import 'package:flutter/material.dart';
import 'package:food_management/pages/dashboard.dart';
import 'package:food_management/theme/themedata.dart';
import 'package:food_management/widgets/custom_widget.dart';
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
    controller.text = controller.text.trim();
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
                image: "assets/images/breakfast.svg",
              ),
              SizedBox(height: height * 0.022),
              MealSection(
                meal: "Lunch",
                items: mealItems["Lunch"]!,
                onAddItemType: addItemType,
                itemController: lunchController,
                image: "assets/images/lunch.svg",
              ),
              SizedBox(height: height * 0.022),
              MealSection(
                meal: "Snacks",
                items: mealItems["Snacks"]!,
                onAddItemType: addItemType,
                itemController: snacksController,
                image: "assets/images/snacks.svg",
              ),
              SizedBox(height: height * 0.022),
              MealSection(
                meal: "Dinner",
                items: mealItems["Dinner"]!,
                onAddItemType: addItemType,
                itemController: dinnerController,
                image: "assets/images/dinner.svg",
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
                    Navigator.pop(
                        context,
                        MaterialPageRoute(builder: (context) => DashboardPage())
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
            color: theme.primaryColor,
            boxShadow: [

              BoxShadow(
                color: Color(0x1A000000),
                offset: Offset(0, 1),
                blurRadius: 3,
                spreadRadius: 0,
              ),
            ],
            border: Border.all(color: borderColor.withOpacity(themeStore.isDarkMode? 1 : 0.5)),
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
                    child: MyIcon(iconPath: widget.image,color:themeStore.isDarkMode? borderColor : iconColor ,),
                  ),
                  SizedBox(width: 10),
                  Text(
                    widget.meal,
                    style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
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
                        child: Text("Start Time", style: TextStyle(color: theme.colorScheme.tertiary, fontSize: 11)),
                      ),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: width * 0.37,
                            height: height * 0.048,
                            decoration: BoxDecoration(
                              border: Border.all(color: borderColor),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: sttimeController,
                                    readOnly: true,
                                    style: TextStyle(
                                      color:themeStore.isDarkMode? (sttimeController.text.isNotEmpty ? Colors.white : Colors.white) : (sttimeController.text.isNotEmpty ? Colors.black : Colors.black),
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                      hintText: "Start Time",
                                      hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color:Color(0xff717171) ),
                                    ),
                                    onTap: ()=> _selectTime(context, sttimeController),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: MyIcon(iconPath: "assets/images/clock.svg"
                                    ,color: themeStore.isDarkMode? borderColor : iconColor ,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // End Time
                  Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text("End Time", style: TextStyle(color: theme.colorScheme.tertiary, fontSize: 11)),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: width * 0.37,
                        height: height * 0.048,
                        decoration: BoxDecoration(
                          border: Border.all(color: borderColor),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: eddtimeController,
                                readOnly: true,
                                style: TextStyle(
                                  color: themeStore.isDarkMode?(eddtimeController.text.isNotEmpty ? Colors.white : Colors.white) :(eddtimeController.text.isNotEmpty ? Colors.black : Colors.black),
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "End Time",
                                  hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color:Color(0xff717171) ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                ),
                                onTap: ()=> _selectTime(context, eddtimeController),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: MyIcon(iconPath: "assets/images/clock.svg"
                              ,color: themeStore.isDarkMode? borderColor : iconColor ,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 12),
              Text("${widget.meal} List", style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400)),
              SizedBox(height: 8,),
              ...widget.items.map((item) => AddedItem(themeStore: themeStore, theme: theme,name: item["name"]!,type: item["type"]!,)),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                        fontSize: 12,fontWeight: FontWeight.w400,
                        color: themeStore.isDarkMode?borderColor:iconColor,
                      ),
                      controller: widget.itemController,
                      decoration: InputDecoration(
                        hintText: "Enter Item",
                        hintStyle: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: themeStore.isDarkMode?borderColor: Color(0xff717171)),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  MyIcon(iconPath: "assets/images/veg.svg",color: Color(0xff018D0E),size: 16,),
                  Theme(
                    data: ThemeData(
                      checkboxTheme: CheckboxThemeData(
                        side: BorderSide(color: borderColor, width: 1.5),
                        fillColor: WidgetStateProperty.all(theme.primaryColor),
                      ),
                    ),
                    child: Checkbox(
                      checkColor: theme.colorScheme.tertiary,

                      value: isVeg,
                      onChanged: (bool? value) {
                        if (value != null) {
                          setState(() {
                            isVeg = true;
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 10,),
                  MyIcon(iconPath: "assets/images/nonveg.svg",color:Color(0xffD34B26) ,size: 16,),
                  Theme(
                    data: ThemeData(
                      checkboxTheme: CheckboxThemeData(
                        side: BorderSide(color: borderColor, width: 1.5),
                        fillColor: WidgetStateProperty.all(theme.primaryColor),
                      ),
                    ),
                    child: Checkbox(
                      checkColor: theme.colorScheme.tertiary,
                      
                      //activeColor: Colors.white,
                      value: !isVeg,
                      onChanged: (bool? value) {
                        if (value != null) {
                          setState(() {
                            isVeg = false;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
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

class AddedItem extends StatelessWidget {
  const AddedItem({
    super.key,
    required this.themeStore,
    required this.theme,
    required this.name,
    required this.type

  });

  final ThemeStore themeStore;
  final ThemeData theme;
  final String name;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(name,overflow: TextOverflow.ellipsis,style: TextStyle(
          fontSize: 12,fontWeight: FontWeight.w400,
          color: themeStore.isDarkMode?borderColor:iconColor,
        ),),
        Spacer(),
        MyIcon(iconPath: "assets/images/veg.svg",color: type == "veg"? Color(0xff018D0E) : Color(0xff018D0E).withOpacity(0.25),size: 16,),
        Theme(
          data: ThemeData(
            checkboxTheme: CheckboxThemeData(
              side: BorderSide(color: type == "veg"? borderColor : borderColor.withOpacity(0.25), width: 1.5),
              fillColor: WidgetStateProperty.all(theme.primaryColor),
            ),
          ),
          child: Checkbox(
            checkColor: theme.colorScheme.tertiary,

            value: type == "veg"?true:false,
            onChanged: (bool? value) {

            },
          ),
        ),
        SizedBox(width: 10,),
        MyIcon(iconPath: "assets/images/nonveg.svg",color: type!="veg"? Color(0xffD34B26) : Color(0xffD34B26).withOpacity(0.25),size: 16,),
        Theme(
          data: ThemeData(
            checkboxTheme: CheckboxThemeData(
              side: BorderSide(color: type!= "veg"? borderColor : borderColor.withOpacity(0.25), width: 1.5),
              fillColor: WidgetStateProperty.all(theme.primaryColor),
            ),
          ),
          child: Checkbox(
            checkColor: theme.colorScheme.tertiary,

            value: type == "veg"?false: true,
            onChanged: (bool? value) {
            },
          ),
        ),
      ],


      // leading: IconButton(
      //   icon: Icon(Icons.delete),
      //   onPressed: () {
      //     setState(() {
      //       widget.items.remove(item);
      //     });
      //   },
      // ),




    );
  }
}
