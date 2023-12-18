
import 'package:flutter/material.dart';
import 'package:meal_monkey/Advanced/model/product_model.dart';
import 'package:meal_monkey/widgets/favourite_page.dart';

class SimpleProductWidget extends StatelessWidget {
  final ProductModel productModel;
  const SimpleProductWidget({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                  Favourite()));
      },
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Image.network(productModel.url),
          ),
        ),
      ),
    );
  }
}
