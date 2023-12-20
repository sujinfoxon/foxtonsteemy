import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meal_monkey/Advanced/components/page_title_bar.dart';
import 'package:meal_monkey/Advanced/components/under_part.dart';
import 'package:meal_monkey/Advanced/components/upside.dart';
import 'package:meal_monkey/Advanced/resources/auth_methods.dart';
import 'package:meal_monkey/Advanced/screens/login_screen.dart';
import 'package:meal_monkey/Advanced/widgets/rounded_button.dart';
import 'package:meal_monkey/Advanced/widgets/rounded_input_field.dart';
import 'package:meal_monkey/Advanced/widgets/rounded_password_field.dart';
import 'package:meal_monkey/utils/utils.dart';
import 'package:meal_monkey/widgets/nav_bar.dart';

class AddFoods extends StatefulWidget {
  const AddFoods({super.key});

  @override
  State<AddFoods> createState() => _AddFoodsState();
}

class _AddFoodsState extends State<AddFoods> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _volumeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _foodtypeController = TextEditingController();
  final TextEditingController _foodfromController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _priceController.dispose();
    _caloriesController.dispose();
    _volumeController.dispose();
    _descriptionController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    _distanceController.dispose();
    _foodfromController.dispose();
    _foodtypeController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().addFoods(
      file: _image!,
      calories: _caloriesController.text,
      description: _descriptionController.text,
      name: _nameController.text,
      price: int.parse(_priceController.text),
      volume: _volumeController.text,
      latitude: double.parse(_latitudeController.text),
      longitude: double.parse(_longitudeController.text),
      distance: int.parse(_distanceController.text),
      foodtype: _foodtypeController.text,
      from: _foodfromController.text,
    );
    if (res != "success") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NavBarRoots()));
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                const Upside(
                  imgUrl: "assets/popular_foods.json",
                ),
                const PageTitleBar(title: 'Add Popular Foods'),
                Padding(
                  padding: const EdgeInsets.only(top: 320.0),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Stack(
                          children: [
                            _image != null
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundImage: MemoryImage(_image!))
                                : const CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.white38,
                                    backgroundImage: NetworkImage(
                                        "https://cdn.iconscout.com/icon/premium/png-256-thumb/data-transfer-6769504-5569021.png")),
                            Positioned(
                                bottom: -10,
                                left: 60,
                                child: IconButton(
                                  onPressed: () {
                                    selectImage();
                                  },
                                  icon: const Icon(Icons.add_a_photo),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Form(
                          child: Column(
                            children: [
                              RoundedInputField(
                                hintText: "Food Name",
                                icon: Icons.fastfood_sharp,
                                controller: _nameController,
                              ),
                              RoundedInputField(
                                  hintText: "Food Price",
                                  icon: Icons.price_change,
                                  controller: _priceController),
                              RoundedInputField(
                                  hintText: "Food Description",
                                  icon: Icons.note_alt,
                                  controller: _descriptionController),
                              RoundedInputField(
                                  hintText: "Food Volume",
                                  icon: Icons.scale,
                                  controller: _volumeController),
                              RoundedInputField(
                                  hintText: "Food Calories",
                                  icon: Icons.thermostat_outlined,
                                  controller: _caloriesController),
                              RoundedInputField(
                                  hintText: "Latitude",
                                  icon: Icons.location_on,
                                  controller: _latitudeController),
                              RoundedInputField(
                                  hintText: "Longitude",
                                  icon: Icons.gps_fixed,
                                  controller: _longitudeController),
                              RoundedInputField(
                                  hintText: "Distance Make Sure Add 0",
                                  icon: Icons.social_distance,
                                  controller: _distanceController),
                              RoundedInputField(
                                  hintText: "Food Type",
                                  icon: Icons.food_bank,
                                  controller: _foodtypeController),
                              RoundedInputField(
                                  hintText: "Hotel Name",
                                  icon: Icons.restaurant,
                                  controller: _foodfromController),
                              Container(
                                child: _isLoading
                                    ? const Center(
                                        child: SpinKitThreeBounce(
                                        color: Color(0xFFefcf18),
                                      ))
                                    : RoundedButton(
                                        text: 'Add Food',
                                        press: () {
                                          signUpUser();
                                        }),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
