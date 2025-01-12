import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:food_management/pages/my_plan.dart';
import 'package:food_management/pages/menu.dart';
import 'package:food_management/stores/theme_store.dart';
import 'package:food_management/theme/themedata.dart';
import 'package:food_management/widgets/custom_widget.dart';
import 'package:provider/provider.dart';

import 'add_plan.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({super.key});

  static const WidgetStateProperty<Icon> thumbIcon =
  WidgetStateProperty<Icon>.fromMap(
    <WidgetStatesConstraint, Icon>{
      WidgetState.selected: Icon(Icons.dark_mode),
      WidgetState.any: Icon(Icons.light_mode_outlined),
    },
  );

  List<String> labels = ["Meal Plan", "Menu", "Meal Track", "Feedback"];
  List<String> img = [
    "assets/images/meal_plan.svg",
    "assets/images/menu.svg",
    "assets/images/meal_track.svg",
    "assets/images/feedback.svg"
  ];

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: widget.labels.length, vsync: this);
  }

  @override
  void dispose() {

    tabController.dispose();
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
        title: Text(
          "Food Management",
          style: theme.textTheme.titleLarge,
        ),
        backgroundColor: theme.primaryColor,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddPlan()),
              );

            },
            child: Row(
              children: [
                MyIcon(
                    iconPath: "assets/icons/add.svg",
                    color: theme.colorScheme.tertiary,
                ),
                SizedBox(width: 5),
                Text(
                  "Add Plan",
                  style: TextStyle(color: theme.colorScheme.tertiary),
                )
              ],
            ),
          ),
          Switch(
            activeColor: Colors.white,
            inactiveThumbColor: Colors.black,
            thumbIcon: DashboardPage.thumbIcon,
            value: themeStore.isDarkMode,
            onChanged: (bool val) {
              themeStore.toggleTheme();
            },
          ),
        ],
        bottom:TabBar(
          controller: tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: EdgeInsets.symmetric(horizontal: width * 0.02),
          indicatorColor: theme.colorScheme.tertiary,
          dividerColor: Colors.transparent,
          labelColor: textColor,
          unselectedLabelColor: themeStore.isDarkMode ? Color(0xffBABABA) : Color(0xff454545),
          tabs: [
            for (int i = 0; i < widget.labels.length; i++)
              Tab(
                child: Container(


                  child: Column(
                    children: [
                      AnimatedBuilder(
                        animation: tabController!,
                        builder: (context, _) {
                          bool isSelected = tabController!.index == i;
                          return MyIcon(
                            iconPath: widget.img[i],
                            color: isSelected
                                ? (theme.colorScheme.tertiary)
                                : (themeStore.isDarkMode ? darkgreyColor : iconColor),
                          );
                        },
                      ),
                      Text(
                        widget.labels[i],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: TabBarView(
          controller: tabController,
          children: [

            MyPlan(),
            Menu(),
            Center(child: Text("3 Tab Content"),),
            Center(child: Text("4 Tab Content")),
          ],
        ),
      ),
    );
  }
}







