import 'package:flutter/material.dart';
import 'package:food_management/stores/theme_store.dart';
import 'package:food_management/theme/themedata.dart';
import 'package:provider/provider.dart';

class MyPlan extends StatefulWidget {
  MyPlan({super.key});

  static const WidgetStateProperty<Icon> thumbIcon =
  WidgetStateProperty<Icon>.fromMap(
    <WidgetStatesConstraint, Icon>{
      WidgetState.selected: Icon(Icons.dark_mode),
      WidgetState.any: Icon(Icons.light_mode_outlined),
    },
  );

  List<String> labels = ["Meal Plan", "Menu", "Track", "Feedback"];
  List<String> img = [
    "assets/images/meal_plan.png",
    "assets/images/Menu.png",
    "assets/images/meal_track.png",
    "assets/images/feedback.png"
  ];

  @override
  State<MyPlan> createState() => _MyPlanState();
}

class _MyPlanState extends State<MyPlan> with SingleTickerProviderStateMixin {
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
      appBar: AppBar(
        title: Text(
          "Food Management",
          style: theme.textTheme.titleLarge,
        ),
        backgroundColor: theme.primaryColor,
        actions: [
          TextButton(
            onPressed: () {},
            child: Row(
              children: [
                Image.asset("assets/icons/add.png"),
                SizedBox(width: 5),
                Text(
                  "Add Plan",
                  style: TextStyle(color: textColor),
                )
              ],
            ),
          ),
          Switch(
            activeColor: Colors.white,
            inactiveThumbColor: Colors.black,
            thumbIcon: MyPlan.thumbIcon,
            value: themeStore.isDarkMode,
            onChanged: (bool val) {
              themeStore.toggleTheme();
            },
          ),
        ],
        bottom: TabBar(
          controller: tabController,
          indicatorColor: textColor,
          dividerColor: Colors.transparent,
          labelColor: textColor,
          unselectedLabelColor: themeStore.isDarkMode? Color(0xffBABABA) : Color(0xff454545),
          tabs: [
            for (int i = 0; i < widget.labels.length; i++)
              Tab(
                child: Column(
                  children: [
                    Image.asset(widget.img[i]),
                    Text(widget.labels[i],)
                  ],
                ),
              ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [

          Dashboard(),
          Center(child: Text("2 Tab Content")),
          Center(child: Text("3 Tab Content")),
          Center(child: Text("4 Tab Content")),
        ],
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("1d Tab Content"));
  }
}



