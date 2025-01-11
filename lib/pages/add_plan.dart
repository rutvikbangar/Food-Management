    import 'package:flutter/material.dart';
    import 'package:food_management/models/meal_model.dart';
    import 'package:food_management/models/plan_model.dart';
    import 'package:food_management/pages/dashboard.dart';
    import 'package:food_management/services/api_service.dart';
import 'package:food_management/widgets/custom_widget.dart';
    import 'package:food_management/widgets/snackbar_widget.dart';
    import 'package:provider/provider.dart';
    import '../stores/meal_plan_store.dart';
    import '../stores/theme_store.dart';
    import '../theme/themedata.dart';

    class AddPlan extends StatefulWidget {
      @override
      _AddPlanState createState() => _AddPlanState();
    }

    class _AddPlanState extends State<AddPlan> {
      final api = ApiLayer();
      final Color _textColor = Color(0xff717171);
      TextEditingController _planController = TextEditingController();
      TextEditingController _amountController = TextEditingController();
      TextEditingController _breakfastController = TextEditingController(text: '30');
      TextEditingController _lunchController = TextEditingController(text: '80');
      TextEditingController _snacksController = TextEditingController(text: '30');
      TextEditingController _dinnerController = TextEditingController(text: '80');
      FocusNode _breakfastFocusNode = FocusNode();
      FocusNode _lunchFocusNode = FocusNode();
      FocusNode _snacksFocusNode = FocusNode();
      FocusNode _dinnerFocusNode = FocusNode();
      FocusNode _planFocusNode = FocusNode();
      FocusNode _amountFocusNode = FocusNode();
      List<String> selectedMeals = [];
      String? _selectedFrequency;
      bool ison = false ;

      void _onMealChanged(String meal, bool? isChecked) {
        setState(() {
          if (isChecked == true) {

            if (!selectedMeals.contains(meal)) {
              selectedMeals.add(meal);
            }
          } else {
            selectedMeals.remove(meal);
          }
        });
      }

      void _onFrequencyChanged(String? value) {
        setState(() {
          _selectedFrequency = value;
        });
    }


      @override
      void dispose() {
        _breakfastController.dispose();
        _lunchController.dispose();
        _snacksController.dispose();
        _dinnerController.dispose();
        _planController.dispose();
        _amountController.dispose();
        _breakfastFocusNode.dispose();
        _lunchFocusNode.dispose();
        _snacksFocusNode.dispose();
        _dinnerFocusNode.dispose();
        _planFocusNode.dispose();
        _amountFocusNode.dispose();
        super.dispose();
      }

      @override
      Widget build(BuildContext context) {
        final themeStore = Provider.of<ThemeStore>(context);
        final theme = Theme.of(context);
        final height = MediaQuery.of(context).size.height;
        final width = MediaQuery.of(context).size.width;

        return Scaffold(
          backgroundColor: theme.primaryColor,
          appBar: AppBar(
            title: Text('Add Plan'),
            backgroundColor: theme.primaryColor,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 10),
                    width: width * 0.90,
                    height: height * 0.074,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: borderColor.withOpacity(0.5),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: themeStore.isDarkMode?Colors.white:Colors.black),
                      controller: _planController,
                      focusNode: _planFocusNode,
                      decoration: InputDecoration(
                        hintText: 'Enter Plan Name',
                        hintStyle: theme.textTheme.titleMedium?.copyWith(color: _textColor),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(right: 9.0),
                          child: Container(
                            alignment: Alignment.center,
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              color: themeStore.isDarkMode ? darkBluish : greyColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: MyIcon(
                                iconPath: "assets/images/title.svg",
                                color: themeStore.isDarkMode? darkgreyColor: iconColor,
                            ),
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Show price breakdown per meal', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                      SwitchTheme(
                        data: SwitchThemeData(
                          thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
                            return themeStore.isDarkMode ? Color(0xFF2E303C) : Colors.white;
                          }),
                          trackColor: WidgetStateProperty.resolveWith<Color>((states) {
                            if (!states.contains(WidgetState.selected)) {
                              return Color(0xffA6A6A6);
                            }
                            return Color(0xff31749E);
                          }),
                        ),
                        child: Switch(
                          value: ison,
                          onChanged: (bool value) {
                            setState(() {
                              ison = value;
                            });
                          },
                        ),
                      )




                    ],
                  ),
                  SizedBox(height: 14),
                  Container(
                    padding: EdgeInsets.only(right: 8),

                    width: width * 0.90,
                    decoration: BoxDecoration(
                      color: themeStore.isDarkMode ? darkBluish : greyColor,
                      border: Border.all(
                        color: borderColor.withOpacity(0.5),
                        width: 1.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: themeStore.isDarkMode ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1),
                          offset: Offset(0, 4),
                          blurRadius: 8,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Theme(
                              data: ThemeData(
                                checkboxTheme: CheckboxThemeData(
                                  side: BorderSide(color: borderColor, width: 1.5),
                                  fillColor: WidgetStateProperty.all(theme.primaryColor),
                                ),
                              ),
                              child: Checkbox(
                                  checkColor: themeStore.isDarkMode? darktextColor : textColor,
                                 // activeColor: Colors.white,
                                  value: selectedMeals.contains("Breakfast"),
                                  onChanged: (bool? val) {
                                    _onMealChanged("Breakfast", val);
                                  }

                              ),
                            ),
                            SizedBox(width: 12),
                            Text("Breakfast", style: theme.textTheme.titleMedium?.copyWith(color: themeStore.isDarkMode? darkgreyColor: iconColor)),
                            Spacer(),
                            if(ison && selectedMeals.contains("Breakfast"))
                              SubPriceContainer(theme: theme, textEditingController: _breakfastController, focusNode: _breakfastFocusNode)
                          ],
                        ),
                        Row(
                          children: [
                            Theme(
                              data: ThemeData(
                                checkboxTheme: CheckboxThemeData(
                                  side: BorderSide(color: borderColor, width: 1.5),
                                  fillColor: WidgetStateProperty.all(theme.primaryColor),
                                ),
                              ),
                              child: Checkbox(
                                  checkColor: themeStore.isDarkMode? darktextColor : textColor,
                                 // activeColor: Colors.white,
                                  value: selectedMeals.contains("Lunch"),
                                  onChanged: (bool? val) {
                                    _onMealChanged("Lunch", val);
                                  }
                              ),
                            ),
                            SizedBox(width: 12),
                            Text("Lunch", style: theme.textTheme.titleMedium?.copyWith(color: themeStore.isDarkMode? darkgreyColor: iconColor)),
                            Spacer(),
                            if(ison && selectedMeals.contains("Lunch"))
                                SubPriceContainer(theme: theme, textEditingController: _lunchController, focusNode: _lunchFocusNode)
                          ],
                        ),
                        Row(
                          children: [
                            Theme(
                              data: ThemeData(
                                checkboxTheme: CheckboxThemeData(
                                  side: BorderSide(color: borderColor, width: 1.5),
                                  fillColor: WidgetStateProperty.all(theme.primaryColor),
                                ),
                              ),
                              child: Checkbox(
                                  checkColor: themeStore.isDarkMode? darktextColor : textColor,
                                 // activeColor: Colors.white,
                                  value: selectedMeals.contains("Snacks"),
                                  onChanged: (bool? val) {
                                    _onMealChanged("Snacks", val);
                                  }
                              ),
                            ),
                            SizedBox(width: 12),
                            Text("Snacks", style: theme.textTheme.titleMedium?.copyWith(color: themeStore.isDarkMode? darkgreyColor: iconColor)),
                            Spacer(),
                            if(ison && selectedMeals.contains("Snacks"))
                              SubPriceContainer(theme: theme, textEditingController: _snacksController, focusNode: _snacksFocusNode)
                          ],
                        ),
                        Row(
                          children: [
                            Theme(
                              data: ThemeData(
                                checkboxTheme: CheckboxThemeData(
                                  side: BorderSide(color: borderColor, width: 1.5),
                                  fillColor: WidgetStateProperty.all(theme.primaryColor),
                                ),
                              ),
                              child: Checkbox(
                                checkColor: themeStore.isDarkMode? darktextColor : textColor,

                                value: selectedMeals.contains("Dinner"),
                                onChanged: (bool? val) {
                                  _onMealChanged("Dinner", val);
                                },
                              ),
                            ),
                            SizedBox(width: 12),
                            Text("Dinner", style: theme.textTheme.titleMedium?.copyWith(color: themeStore.isDarkMode? darkgreyColor: iconColor)),
                            Spacer(),
                            if(ison && selectedMeals.contains("Dinner"))
                              SubPriceContainer(theme: theme, textEditingController: _dinnerController, focusNode: _dinnerFocusNode)
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),

                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 10),
                    width: width * 0.90,
                    height: height * 0.074,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: borderColor.withOpacity(0.5),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: themeStore.isDarkMode?Colors.white:Colors.black),
                      controller: _amountController,
                      focusNode: _amountFocusNode,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter Amount',
                        hintStyle: theme.textTheme.titleMedium?.copyWith(color: _textColor),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            alignment: Alignment.center,
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              color: themeStore.isDarkMode ? darkBluish : greyColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: MyIcon(iconPath: "assets/images/rup.svg",
                            color:themeStore.isDarkMode? darkgreyColor: iconColor,
                            ),
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 10),
                    width: width * 0.90,
                    height: height * 0.074,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: borderColor.withOpacity(0.5),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Select Frequency',
                        labelStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: _textColor),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            alignment: Alignment.center,
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              color: themeStore.isDarkMode ? darkBluish : greyColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: MyIcon(iconPath: "assets/images/calender.svg",
                              color: themeStore.isDarkMode? darkgreyColor: iconColor,
                            ),
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                      items: ['Daily', 'Weekly', 'Monthly']
                          .map((frequency) => DropdownMenuItem(
                        value: frequency,
                        child: Text(
                          frequency,
                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: themeStore.isDarkMode?Colors.white:Colors.black),

                        ),
                      ))
                          .toList(),
                      onChanged: _onFrequencyChanged,
                      dropdownColor: theme.primaryColor,
                      icon: Padding(
                        padding: const EdgeInsets.only(right: 20.0,bottom: 10),
                        child: MyIcon(iconPath: "assets/icons/down.svg",color: _textColor,size: 10,),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.15),
                  GestureDetector(
                    onTap: () async {

                      final numValue = num.tryParse(_amountController.text);
                      if (numValue == null || numValue <= 0) {
                        showSnackbar(context, Colors.red, "Enter a valid amount");
                      }else{
                        if(_selectedFrequency == null ) {
                          showSnackbar(context, Colors.red, "Select Frequency");
                        }else{

                          //other validations are done inside the save function
                          List<String> breakdown =  breakDown(selectedMeals);
                          if (breakdown.isEmpty){
                            return;
                          }
                          save(selectedMeals, _planController.text!, _amountController.text!, _selectedFrequency!,breakdown);
                        }
                      }


                      },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [Color(0xff31749E), Color(0xff0185D8)]),
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: Text(
                        "Save & Continue",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }

      List<String> breakDown(List<String> selectedMeals) {
        List<String> breakdown = [];
        if(selectedMeals.isEmpty){
          showSnackbar(context, Colors.red, "No meal selected");
          return [];
        }
        if (selectedMeals.contains("Breakfast")) {
          final bval = num.tryParse(_breakfastController.text);
          if (bval == null || bval < 0) {
            showSnackbar(context, Colors.red, "Breakfast price is invalid");
            return [];
          } else {
            breakdown.add("b${_breakfastController.text}");
          }
        }

        if (selectedMeals.contains("Lunch")) {
          final lval = num.tryParse(_lunchController.text);
          if (lval == null || lval < 0) {
            showSnackbar(context, Colors.red, "Lunch price is invalid");
            return [];
          } else {
            breakdown.add("l${_lunchController.text}");
          }
        }

        if (selectedMeals.contains("Snacks")) {
          final sval = num.tryParse(_snacksController.text);
          if (sval == null || sval < 0) {
            showSnackbar(context, Colors.red, "Snacks price is invalid");
            return [];
          } else {
            breakdown.add("s${_snacksController.text}");
          }
        }

        if (selectedMeals.contains("Dinner")) {
          final dval = num.tryParse(_dinnerController.text);
          if (dval == null || dval < 0) {
            showSnackbar(context, Colors.red, "Dinner price is invalid");
            return [];
          } else {
            breakdown.add("d${_dinnerController.text}");
          }
        }

        return breakdown;
      }




      void save(List<String> selectedMeals, String plan, String amount, String frequency,List<String> breakdown) async {
        print("Selected Meals: $selectedMeals");
        print("Plan: $plan");
        print("Amount: $amount");
        print("Frequency: $frequency");
        print("breakdown: $breakdown");
        plan = plan.trim();
        if (selectedMeals.isEmpty || plan.isEmpty || amount.isEmpty || frequency.isEmpty) {
          showSnackbar(context, Colors.red, "Plan name required");
        } else {
          int id = await api.getNextId();
          Plan newPlan = Plan(
            id: id,
            name: plan,
            frequency: frequency,
            breakdown: breakdown,
            amount: amount,
            meals: [
              for (int i = 0; i < selectedMeals.length; i++)
                Meal(id: i + 1, type: selectedMeals[i], startTime: "", endTime: ""),
            ],
          );

          await api.addMealPlan(newPlan);

          final store = Provider.of<MealPlanStore>(context, listen: false);
          store.addPlan(newPlan);

          showSnackbar(context, Colors.green, "Plan saved successfully!");
          Navigator.pop(
            context,
            MaterialPageRoute(builder: (context) => DashboardPage()),
          );
        }
      }
    }


class SubPriceContainer extends StatelessWidget {
  const SubPriceContainer({
    super.key,
    required this.theme,
    required this.textEditingController,
    required this.focusNode,
  });

  final ThemeData theme;
  final TextEditingController textEditingController;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      height: 32,width: 72,
      decoration: BoxDecoration(
        color: theme.primaryColor,
        border: Border.all(color: Color(0xffA6A6A6)),
        borderRadius: BorderRadius.circular(8),
      ),
        child: Row(
          children: [
            SizedBox(width: 1,),
            Icon(Icons.currency_rupee,size: 15,),
            Expanded(
              child: TextField(
                style: TextStyle(color: theme.brightness==Brightness.dark? Colors.white : Colors.black ),
                controller: textEditingController,
                focusNode: focusNode,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(bottom: 16),
                ),

              ),
            ),
          ],
        ),
    );
  }
}
