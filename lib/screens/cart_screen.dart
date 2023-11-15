import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff949494),
      appBar: AppBar(
        backgroundColor: Color(0xff949494),
        centerTitle: true,
        automaticallyImplyLeading: false,

        elevation: 0,
        title: Text(
          "My Cart",
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFefcf18)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(15),
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        image: DecorationImage(
                            image: AssetImage("assets/Burger.png"))),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Special Burger \n ₹150",
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 50,
                    width: 105,
                    decoration: BoxDecoration(
                      color: Color(0xff949494),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 35,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.minimize,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          color: Color(0xfff7ede6),
                          height: 50,
                          width: 35,
                          child: Center(
                            child: Text(
                              "02",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 35,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.all(15),
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        image: DecorationImage(
                            image: AssetImage("assets/Pizza.png"))),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Special Pizza \n ₹150",
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 50,
                    width: 105,
                    decoration: BoxDecoration(
                      color: Color(0xfff9ccaf),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 35,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.minimize,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          color: Color(0xfff7ede6),
                          height: 50,
                          width: 35,
                          child: Center(
                            child: Text(
                              "02",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 35,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.all(15),
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        image: DecorationImage(
                            image: AssetImage("assets/Snacks.png"))),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Potato Fries \n ₹150",
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 50,
                    width: 105,
                    decoration: BoxDecoration(
                      color: Color(0xfff9ccaf),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 35,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.minimize,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          color: Color(0xfff7ede6),
                          height: 50,
                          width: 35,
                          child: Center(
                            child: Text(
                              "02",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 35,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.all(15),
              height: 65,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Promo Code",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                  Container(
                    height: 65,
                    width: 150,
                    decoration: BoxDecoration(
                      color:Color(0xFFefcf18),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        "Apply",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      SizedBox(height: 10,),
      Container(
        margin: EdgeInsets.all(15),
        height: 160,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(

          children: [

            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text("Sub Total",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 18),),
                  Text("₹450",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 18),),

                ],
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text("Shipping",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 18),),
                  Text("₹50",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 18),),

                ],
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text("Total",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 18),),
                  Text("₹500",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 18),),

                ],
              ),
            ),
SizedBox(height: 10,),

          ],
        ),
      ),
            Container(
              margin: EdgeInsets.all(15),
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.red,

              ),
              child: Center(child: Text("Finalize Order",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),)),
            )
          ],
        ),
      ),
    );
  }
}
