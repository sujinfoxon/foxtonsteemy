import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meal_monkey/Advanced/resources/cloud_firestore_methods.dart';
import 'package:meal_monkey/Advanced/utils/utils.dart';
import 'package:meal_monkey/widgets/custom_main_button.dart';
import 'package:meal_monkey/widgets/text_field_test.dart';
import 'package:provider/provider.dart';

import '../provider/user_details_provider.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({Key? key}) : super(key: key);

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  bool isLoading = false;
  int selected = 1;
  Uint8List? image;
  TextEditingController nameController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController volumeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();
  List<int> keysForDiscount = [0, 70, 60, 50];

  //keysofdiscoutn[selected -1]

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    costController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: !isLoading
          ? SingleChildScrollView(
              child: SizedBox(
                height: screenSize.height,
                width: screenSize.width,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Stack(
                          children: [
                            image == null
                                ? Image.network(
                                    "https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png",
                                    height: screenSize.height / 10,
                                  )
                                : Image.memory(
                                    image!,
                                    height: screenSize.height / 10,
                                  ),
                            IconButton(
                                onPressed: () async {
                                  Uint8List? temp = await Utils().pickImage();
                                  if (temp != null) {
                                    setState(() {
                                      image = temp;
                                    });
                                  }
                                },
                                icon: Icon(Icons.file_upload))
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 35, vertical: 10),
                          height: screenSize.height * 0.7,
                          width: screenSize.width * 0.7,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFieldWidget(
                                  title: "Name",
                                  controller: nameController,
                                  obscureText: false,
                                  hintText: "Enter the name of the food"),
                              TextFieldWidget(
                                  title: "Cost",
                                  controller: costController,
                                  obscureText: false,
                                  hintText: "Enter the cost of the food"),
                              TextFieldWidget(
                                  title: "Volume",
                                  controller: volumeController,
                                  obscureText: false,
                                  hintText: "Enter the Volume of the food"),
                              TextFieldWidget(
                                  title: "Description",
                                  controller: descriptionController,
                                  obscureText: false,
                                  hintText: "Enter the description of the food"),
                              TextFieldWidget(
                                  title: "Calories",
                                  controller: caloriesController,
                                  obscureText: false,
                                  hintText: "Enter the calories of the food"),
                            ],
                          ),
                        ),
                        CustomMainButton(
                            child: const Text(
                              "Sell",
                              style: TextStyle(color: Colors.black),
                            ),
                            color: Colors.yellow,
                            isLoading: isLoading,
                            onPressed: () async {
                              String output = await CloudFirestoreClass()
                                  .uploadProductToDatabase(
                                image: image,
                                productName: nameController.text,
                                rawCost: costController.text,
                                discount: keysForDiscount[selected - 1], calories:caloriesController.text, volume:volumeController.text, description:descriptionController.text,
                              );
                              if (output == "success") {
                                Utils().showSnackBar(
                                    context: context,
                                    content: "Posted Product");
                              } else {
                                Utils().showSnackBar(
                                    context: context, content: output);
                              }
                            }),
                        CustomMainButton(
                            child: const Text(
                              "Back",
                              style: TextStyle(color: Colors.black),
                            ),
                            color: Colors.grey[300]!,
                            isLoading: false,
                            onPressed: () {
                              Navigator.pop(context);
                            })
                      ],
                    ),
                  ),
                ),
              ),
            )
          : const CircularProgressIndicator(),
    ));
  }
}
