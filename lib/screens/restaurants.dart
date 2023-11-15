import 'package:flutter/material.dart';
import 'package:meal_monkey/screens/menu_items.dart';

class Restaurants extends StatefulWidget {
  const Restaurants({super.key});

  @override
  State<Restaurants> createState() => _RestaurantsState();
}

class _RestaurantsState extends State<Restaurants> {
  List rest = ["bbqnation", "mubarak","bbqnation", "mubarak",];
  List name = [
    "Mubarak",
    "BBQ Nation",
    "Taj Hotel",
    "Noha",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black45,
          ),
        ),
        title: Text(
          "Restaurants",
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: 4,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    ListTile(
                      trailing:  GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) =>MenuItems()));
                        },
                        child: Image.asset(
                          "assets/menu.png",height: 40,width: 40,

                          fit: BoxFit.cover,
                        ),
                      ),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.all(

                      Radius.circular(10),
                        ),
                        child: Image.asset(
                          "assets/${rest[index]}.jpg",

                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        name[index],
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500),
                      ),
                      subtitle: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Color(0xFFFF2F08),
                            size: 20,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "4.9",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "(4541 Ratings)",
                            style: TextStyle(color: Colors.black45),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.location_on,
                            color: Color(0xFFFF2F08),
                            size: 20,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "1KM",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }
}
