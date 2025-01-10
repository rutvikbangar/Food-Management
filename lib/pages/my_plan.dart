import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:food_management/models/meal_model.dart';
import 'package:food_management/models/plan_model.dart';
import 'package:food_management/services/api_service.dart';
import 'package:food_management/stores/theme_store.dart';
import 'package:food_management/theme/themedata.dart';
import 'package:provider/provider.dart';
import '../stores/meal_plan_store.dart';
import '../widgets/custom_widget.dart';

class MyPlan extends StatefulWidget {
  MyPlan({super.key});

  @override
  State<MyPlan> createState() => _MyPlanState();
}

class _MyPlanState extends State<MyPlan> {


  @override
  void initState() {
    super.initState();
    final store = Provider.of<MealPlanStore>(context, listen: false);
    store.loadInitialPlans(ApiLayer());
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<MealPlanStore>(context);

    return Observer(
      builder: (_) {
        if (store.isloading) {
          return Center(child: CircularProgressIndicator(color: bluishColor ,));
        }

        if (store.plans.isEmpty) {
          return Center(child: Text("No meal plan available"));
        } else {
          return ListView.builder(
            itemCount: store.plans.length,
            itemBuilder: (context, index) {
              final currentPlan = store.plans[index];
              return PlanTemplate(
                currentplan: currentPlan,
                currmealitem: currentPlan.meals,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                theme: Theme.of(context),
                n: currentPlan.meals.length,
              );
            },
          );
        }
      },
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

        //height: n<=2 ? height*0.15 : height*0.203,
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

            DottedContainer(
              height: height * 0.049,
              name: currentplan.name,
              frequency: currentplan.frequency,
              textStyle: theme.textTheme.titleMedium!,
              backgroundColor: theme.colorScheme.primary,
            ),

            Column(
              children: [
                for (int i = 0; i < (n / 2).ceil(); i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36.0,vertical: 8),
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

            
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.only(left: 16),
              alignment: Alignment.centerLeft,
              height: height*0.043,
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary.withOpacity(0.2),
                  border: Border(
                    top: BorderSide.none,
                    left: BorderSide(width: 0.8, color: theme.colorScheme.secondary.withOpacity(0.25)),
                    right: BorderSide(width: 0.8, color: theme.colorScheme.secondary.withOpacity(0.25)),
                    bottom: BorderSide(width: 0.8, color: theme.colorScheme.secondary.withOpacity(0.25)),
                  ),

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