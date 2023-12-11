
import 'package:flutter/material.dart';
import 'package:meal_monkey/Advanced/screens/login_screen.dart';
import 'package:meal_monkey/onboard/onboard_model.dart';
import 'package:meal_monkey/screens/login_page.dart';
import 'package:meal_monkey/screens/register_page.dart';
import 'package:meal_monkey/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';



class OnBoard extends StatefulWidget {
  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  int currentIndex = 0;
  late PageController _pageController;
  List<OnboardModel> screens = <OnboardModel>[
    OnboardModel(
      img: 'assets/onboard1.png',
      text: "Food . Instamart",
      desc:
      "Upto 40% Offer On Orders",
      bg: Colors.white,
      button: Color(0xFF4756DF),
    ),
    OnboardModel(
      img: 'assets/onboard2.png',
      text: "Order From Top Restaurant",
      desc:
      "Choose your favorite food \nfrom your favorite restaurant",
      bg: Colors.white,
      button: Colors.white,
    ),
    OnboardModel(
      img: 'assets/onboard3.jpg',
      text: "Get Delivery at Your Door Step",
      desc:
      "Prepared by food experts, Enjoy \nwith everyone together.",
      bg: Colors.white,
      button: Color(0xFF4756DF),
    ),
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _storeOnboardInfo() async {
    print("Shared pref called");
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
    print(prefs.getInt('onBoard'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite ,
      appBar: AppBar(
        backgroundColor:  kwhite ,
        elevation: 0.0,
        actions: [
          TextButton(
            onPressed: () {
              _storeOnboardInfo();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Skip",
                style: TextStyle(
                  color:  kblack ,fontSize: 22,fontWeight: FontWeight.w500
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: PageView.builder(
            itemCount: screens.length,
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (_, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(screens[index].img),
                  Container(
                    height: 10.0,
                    child: ListView.builder(
                      itemCount: screens.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 3.0),
                                width: currentIndex == index ? 25 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: currentIndex == index
                                      ? Color(0xffEFCF18)
                                      : Color(0xff282828),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ]);
                      },
                    ),
                  ),
                  Text(
                    screens[index].text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 27.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color:  kblack,
                    ),
                  ),
                  Divider(color: Colors.black,height: 1,),
                  Text(
                    screens[index].desc,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                      color: kblack ,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      print(index);
                      if (index == screens.length - 1) {
                        await _storeOnboardInfo();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => LoginScreen()));
                      }

                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.bounceIn,
                      );
                    },
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                      decoration: BoxDecoration(
                          color: Color(0xff282828),
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        currentIndex == 2 ?   Text(
                        "Get Started",
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(0xffEFCF18)),
                      ) : Text(
                        "Next",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xffEFCF18)),
                      ),

                        SizedBox(
                          width: 15.0,
                        ),
                        Icon(
                          Icons.arrow_forward_sharp,
                          color:Color(0xffEFCF18),
                        )
                      ]),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
