import 'package:flutter/material.dart';
import 'package:food_management/models/meal_model.dart';
import 'package:food_management/models/plan_model.dart';
import 'package:food_management/services/api_service.dart';
import 'package:food_management/stores/theme_store.dart';
import 'package:food_management/theme/themedata.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
   Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final api = ApiLayer();
  Future<MealPlans>? _mealPlans ;
  @override
  void initState() {
    // TODO: implement initState
    _mealPlans =  api.fecthMealPlans();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: _mealPlans,
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(color: theme.colorScheme.secondary ),);
          }
          else if(!snapshot.hasData){
            return Center(child: Text("No meal plan available"),);
          }
          else{
              final mealplan = snapshot.data!;
              return ListView.builder(
                  itemCount: mealplan.plans.length,
                  itemBuilder: (context,index){
                    final currentplan = mealplan.plans[index];
                    final currmealitem = currentplan.meals;
                    int n = currmealitem.length ;
                    return PlanTemplate(height: height, width: width, theme: theme, currentplan: currentplan, n: n, currmealitem: currmealitem);
                  }

              );
          }
        }


    );
  }
}

class PlanTemplate extends StatelessWidget {
  const PlanTemplate({
    super.key,
    required this.height,
    required this.width,
    required this.theme,
    required this.currentplan,
    required this.n,
    required this.currmealitem,
  });

  final double height;
  final double width;
  final ThemeData theme;
  final Plan currentplan;
  final int n;
  final List<Meal> currmealitem;

  @override
  Widget build(BuildContext context) {
    final themeStore = Provider.of<ThemeStore>(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height*0.0096,horizontal: width*0.055),
      child: Container(
        height: height*0.185,
        width: width*0.88,
        decoration: BoxDecoration(
          color: theme.primaryColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: themeStore.isDarkMode?Colors.white.withOpacity(0.1): Colors.black.withOpacity(0.1),
              offset: Offset(0, 4),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(

          children: [
            Container(
              padding: EdgeInsets.only(left: 16),
              alignment: Alignment.centerLeft,
              height: height*0.043,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
              ),
              child: Row(
                children: [
                  Text(currentplan.name,style: theme.textTheme.titleMedium,),
                  SizedBox(width: 4,),
                  Text("(${currentplan.frequency})",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Colors.black87),)
                ],
              ),
            ),


            Column(
              children: [
                for (int i = 0; i < (n / 2).ceil(); i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0,vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (int j = 0; j < 2; j++)
                          if (i * 2 + j < n)
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text("• ${currmealitem[i * 2 + j].type}"),
                            ),
                      ],
                    ),
                  ),
              ],
            ),

            
            Spacer(),
            Container(
              padding: EdgeInsets.only(left: 16),
              alignment: Alignment.centerLeft,
              height: height*0.043,
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary.withOpacity(0.50),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12)),
              ),
              child: Row(
                children: [
                  Text("Amount:",style: theme.textTheme.bodyLarge,),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text("₹ ${currentplan.amount}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: textColor),),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}