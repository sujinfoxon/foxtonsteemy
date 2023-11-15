import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';

class ImageSliderFirebase extends StatefulWidget {
  const ImageSliderFirebase({super.key});

  @override
  State<ImageSliderFirebase> createState() => _ImageSliderFirebaseState();
}

class _ImageSliderFirebaseState extends State<ImageSliderFirebase> {
  List<String> _carouselImages = [];
  var _dotPosition = 0;
  List _products = [];
  var _firestoreInstance = FirebaseFirestore.instance;

  fetchCarouselImages() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn =
    await _firestoreInstance.collection("Image_Slider").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _carouselImages.add(
          qn.docs[i]["img"],
        );
        print(qn.docs[i]["img"]);
      }
    });
    return qn.docs;
  }

  @override
  void initState() {
    fetchCarouselImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return   Container(
      child: Column(
        children: [

          SizedBox(
            height: 10,
          ),
          AspectRatio(
            aspectRatio: 3.0,
            child: CarouselSlider(
                items: _carouselImages
                    .map((item) => Padding(
                  padding: const EdgeInsets.only(left: 3, right: 3),
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(item),
                            fit: BoxFit.fitWidth)),
                  ),
                ))
                    .toList(),
                options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.8,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    onPageChanged: (val, carouselPageChangedReason) {
                      setState(() {
                        _dotPosition = val;
                      });
                    })),
          ),
          SizedBox(
            height: 10,
          ),
          DotsIndicator(
            dotsCount:
            _carouselImages.length == 0 ? 1 : _carouselImages.length,
            position: _dotPosition.toInt(),
            decorator: DotsDecorator(
              activeColor: Color(0xFF282828),
              color: Color(0xFF282828).withOpacity(0.5),
              spacing: EdgeInsets.all(2),
              activeSize: Size(8, 8),
              size: Size(6, 6),
            ),
          ),
        ],
      ),
    );
  }
}
