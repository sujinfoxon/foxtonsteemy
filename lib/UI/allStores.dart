import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meal_monkey/data/dummyShops.dart';

class AllStores extends StatefulWidget {
  const AllStores({Key? key}) : super(key: key);

  @override
  _AllStoresState createState() => _AllStoresState();
}

class _AllStoresState extends State<AllStores> {
  List _products = [];
  var _firestoreInstance = FirebaseFirestore.instance;
  fetchProducts() async {
    QuerySnapshot qn = await _firestoreInstance.collection("popular_foods").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _products.add({
          "product-img": qn.docs[i]["product-img"],
          "product-price": qn.docs[i]["product-price"],
          "product-description": qn.docs[i]["product-description"],
          "product-calories": qn.docs[i]["product-calories"],
          "product-volume": qn.docs[i]["product-volume"],
          "product-name": qn.docs[i]["product-name"],
          "hotel-latitude": qn.docs[i]["hotel-latitude"],
          "hotel-longitude": qn.docs[i]["hotel-longitude"],
          "hotel-distance": qn.docs[i]["hotel-distance"],
        });
      }
    });

    return qn.docs;
  }
  Position? _currentUserPosition;
  double? distanceImMeter = 0.0;
  Data data = Data();

  Future _getTheDistance() async {
    _currentUserPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    for (int i = 0; i < _products.length; i++) {
      double storelat =  _products[i]["hotel-latitude"];
      double storelng =   _products[i]["hotel-longitude"];

      distanceImMeter = await Geolocator.distanceBetween(
        _currentUserPosition!.latitude,
        _currentUserPosition!.longitude,
        storelat,
        storelng,
      );
      var distance = distanceImMeter?.round().toInt();

      _products[i]["hotel-distance"] = (distance! / 1000);
      setState(() {});
    }
  }

  @override
  void initState() {
    _getTheDistance();
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff2980b9),
        title: Text("All Stores Near you"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
        child: GridView.builder(
            itemCount: _products.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return Container(
                color: Color(0xff3498db),
                height: height * 0.9,
                width: width * 0.3,
                child: Column(
                  children: [
                    Container(
                      height: height * 0.12,
                      width: width,
                      child: Image.network(
                        _products[index]["product-img"],
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      _products[index]["product-name"],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on),
                        Text(
                          "${  _products[index]["hotel-distance"].round()} KM Away",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
