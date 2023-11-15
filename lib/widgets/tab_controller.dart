import 'package:flutter/material.dart';
import 'package:meal_monkey/screens/menu_items.dart';
class ResTabBar extends StatefulWidget {
  const ResTabBar({super.key});

  @override
  State<ResTabBar> createState() => _ResTabBarState();
}

class _ResTabBarState extends State<ResTabBar> {
  @override
  Widget build(BuildContext context) {
    return   DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Mubarak Food Menu',style: TextStyle(color: Color(0xFFefcf18),fontWeight: FontWeight.bold,),),
         backgroundColor: Color(0xFF282828),

          bottom: TabBar(
           labelColor: Color(0xFFefcf18),
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab( text: "Meals"),
              Tab( text: "Ice Cream")
            ],
          ),
        ),
        body: TabBarView(
          children: [
            MenuItems(),
            MenuItems(),
          ],
        ),
      ),
    );
  }
}
