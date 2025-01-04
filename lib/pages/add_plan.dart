import 'package:flutter/material.dart';
import 'package:food_management/stores/theme_store.dart';
import 'package:food_management/theme/themedata.dart';
import 'package:provider/provider.dart';


class AddPlan extends StatelessWidget {
  
  final Color borderColor = Color(0xffA6A6A6);
  final Color _textColor = Color(0xff717171);

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
        backgroundColor: theme.primaryColor ,
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
                width: width*0.90,
                height: height*0.074,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: borderColor.withOpacity(0.5),
                    width: 1.0,  
                  ),
                  borderRadius: BorderRadius.circular(12),  
                ),
        
              child: TextField(
                decoration: InputDecoration(
                  hintText: ' Enter Plan Name',
                  hintStyle: theme.textTheme.titleMedium?.copyWith(color:_textColor ),
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
              )
        
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Show price breakdown per meal',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                  Switch(value: false, onChanged: (bool value){
                    value = !value;
                  })
                ],
              ),
              SizedBox(height: 16),

              Container(
                height: height*0.25,
                width: width*0.90,
                decoration: BoxDecoration(
                    color: themeStore.isDarkMode? darkBluish : greyColor,
                    boxShadow: [
                      BoxShadow(
                        color: themeStore.isDarkMode?Colors.white.withOpacity(0.1): Colors.black.withOpacity(0.1),
                        offset: Offset(0, 4),
                        blurRadius: 8,
                      ),
                    ],
                borderRadius: BorderRadius.circular(12)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                            checkColor: textColor,
                            activeColor: Colors.white,
                            value: true, onChanged: (bool? val){}),
                        SizedBox(width: 12,),
                        Text("Breakfast",style: theme.textTheme.titleMedium?.copyWith(color:_textColor ),),

                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                            checkColor: textColor,
                            activeColor: Colors.white,
                            value: true, onChanged: (bool? val){}),
                        SizedBox(width: 12,),
                        Text("Lunch",style: theme.textTheme.titleMedium?.copyWith(color:_textColor ),),

                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                            checkColor: textColor,
                            activeColor: Colors.white,

                            value: true, onChanged: (bool? val){}),
                        SizedBox(width: 12,),
                        Text("Snacks",style: theme.textTheme.titleMedium?.copyWith(color:_textColor ),),

                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                            checkColor: textColor,
                            activeColor: Colors.white,
                            value: false, onChanged: (bool? val){}),
                        SizedBox(width: 12,),
                        Text("Dinner",style: theme.textTheme.titleMedium?.copyWith(color:_textColor ),),

                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 10),
                  width: width*0.90,
                  height: height*0.074,
                  decoration: BoxDecoration(

                    border: Border.all(
                      color: borderColor.withOpacity(0.5),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter Amount',
                      hintStyle: theme.textTheme.titleMedium?.copyWith(color:_textColor ),
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
                  )


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
                  onChanged: (String? value) {}, // Empty for now
                ),
              ),



              //Spacer(),
              SizedBox(height: height*0.15,),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xff31749E),
                    Color(0xff0185D8),

                  ]),
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Text("Save & Continue",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}