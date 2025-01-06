    import 'package:flutter/material.dart';
    import 'package:food_management/models/meal_model.dart';
    import 'package:food_management/models/plan_model.dart';
    import 'package:food_management/pages/my_plan.dart';
    import 'package:food_management/services/api_service.dart';
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

        _planController.dispose();
        _amountController.dispose();
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
                      controller: _planController,
                      focusNode: _planFocusNode,
                      decoration: InputDecoration(
                        hintText: 'Enter Plan Name',
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
                            child: Image.asset("assets/images/title.png"),
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
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
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.only(right: 8),
                    height: height * 0.25,
                    width: width * 0.90,
                    decoration: BoxDecoration(
                      color: themeStore.isDarkMode ? darkBluish : greyColor,
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
                            Checkbox(
                                checkColor: textColor,
                                activeColor: Colors.white,
                                value: selectedMeals.contains("Breakfast"),
                                onChanged: (bool? val) {
                                  _onMealChanged("Breakfast", val);
                                }

                            ),
                            SizedBox(width: 12),
                            Text("Breakfast", style: theme.textTheme.titleMedium?.copyWith(color: _textColor)),
                            Spacer(),
                            if(ison && selectedMeals.contains("Breakfast"))
                              Container(
                                alignment: Alignment.center,
                                height: 32,width: 72,
                                decoration: BoxDecoration(
                                  color: theme.primaryColor,
                                  border: Border.all(color: Color(0xffA6A6A6)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                  child: Text("₹ 30"),
                              )
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                                checkColor: textColor,
                                activeColor: Colors.white,
                                value: selectedMeals.contains("Lunch"),
                                onChanged: (bool? val) {
                                  _onMealChanged("Lunch", val);
                                }
                            ),
                            SizedBox(width: 12),
                            Text("Lunch", style: theme.textTheme.titleMedium?.copyWith(color: _textColor)),
                            Spacer(),
                            if(ison && selectedMeals.contains("Lunch"))
                                Container(
                                  alignment: Alignment.center,
                              height: 32,width: 72,
                              decoration: BoxDecoration(
                                color: theme.primaryColor,
                                border: Border.all(color: Color(0xffA6A6A6)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text("₹ 80"),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                                checkColor: textColor,
                                activeColor: Colors.white,
                                value: selectedMeals.contains("Snacks"),
                                onChanged: (bool? val) {
                                  _onMealChanged("Snacks", val);
                                }
                            ),
                            SizedBox(width: 12),
                            Text("Snacks", style: theme.textTheme.titleMedium?.copyWith(color: _textColor)),
                            Spacer(),
                            if(ison && selectedMeals.contains("Snacks"))
                              Container(
                                alignment: Alignment.center,
                                height: 32,width: 72,
                                decoration: BoxDecoration(
                                  color: theme.primaryColor,
                                  border: Border.all(color: Color(0xffA6A6A6)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text("₹ 30"),
                              )
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                                checkColor: textColor,
                                activeColor: Colors.white,
                                value: selectedMeals.contains("Dinner"),
                                onChanged: (bool? val) {
                                  _onMealChanged("Dinner", val);
                                }
                            ),
                            SizedBox(width: 12),
                            Text("Dinner", style: theme.textTheme.titleMedium?.copyWith(color: _textColor)),
                            Spacer(),
                            if(ison && selectedMeals.contains("Dinner"))
                              Container(
                                alignment: Alignment.center,
                                height: 32,width: 72,
                                decoration: BoxDecoration(
                                  color: theme.primaryColor,
                                  border: Border.all(color: Color(0xffA6A6A6)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(("₹ 80")),
                              )
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
                            child: Icon(Icons.currency_rupee),
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
                        labelStyle: theme.textTheme.titleMedium?.copyWith(color: _textColor),
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
                            child: Image.asset("assets/images/calendar.png"),
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                      items: ['Daily', 'Weekly', 'Monthly']
                          .map((frequency) => DropdownMenuItem(
                        value: frequency,
                        child: Text(
                          frequency,
                          style: theme.textTheme.titleMedium?.copyWith(color: _textColor),
                        ),
                      ))
                          .toList(),
                      onChanged: _onFrequencyChanged,
                    ),
                  ),
                  SizedBox(height: height * 0.15),
                  GestureDetector(
                    onTap: () async {
                      if(_selectedFrequency == null ) {
                        showSnackbar(context, Colors.red, "Select Frequency");
                      }
                      save(selectedMeals, _planController.text!, _amountController.text!, _selectedFrequency!);
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
      void save(List<String> selectedMeals, String plan, String amount, String frequency) async {
        print("Selected Meals: $selectedMeals");
        print("Plan: $plan");
        print("Amount: $amount");
        print("Frequency: $frequency");

        if (selectedMeals.isEmpty || plan.isEmpty || amount.isEmpty || frequency.isEmpty) {
          showSnackbar(context, Colors.red, "All fields required");
        } else {
          int intAmount = 0;
          try {
            intAmount = int.parse(amount);
          } catch (e) {
            showSnackbar(context, Colors.red, "Invalid amount entered");
            return;
          }
          int id = await api.getNextId();
          Plan newPlan = Plan(
            id: id,
            name: plan,
            frequency: frequency,
            amount: intAmount,
            meals: [
              for (int i = 0; i < selectedMeals.length; i++)
                Meal(id: i + 1, type: selectedMeals[i], startTime: "", endTime: ""),
            ],
          );

          await api.addMealPlan(newPlan);

          final store = Provider.of<MealPlanStore>(context, listen: false);
          store.addPlan(newPlan);

          showSnackbar(context, Colors.green, "Plan saved successfully!");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MyPlan()),
          );
        }
      }
    }
