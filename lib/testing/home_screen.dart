import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_monkey/contoller/location_controller.dart';
import 'package:meal_monkey/widgets/text_field_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String fullName = "";
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
        init: LocationController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Get Current Location'),
            ),
            body: Center(
              child: controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      controller.currentLocation == null
                          ? 'No Address Found'
                          : controller.currentLocation!,
                      style: const TextStyle(fontSize: 23),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await controller.getCurrentLocation();
                    },
                    child: const Text('Get Current Location'),
                  ),
                  TextFormField(
                    style:TextStyle(color: Colors.black),
                    decoration:textInputDecoration.copyWith(

                        labelText: "Full Name",
                        suffixIcon: IconButton(onPressed: ()async {
                          await controller.getCurrentLocation();

                 }, icon: Icon(Icons.gps_fixed)),
                        labelStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(Icons.person,color:  Color(0xFFefcf18),

                        )
                    ),
                    onChanged: (val){
                      setState(() {
                        fullName = val;
                        print(fullName);
                      });
                    },
                    validator: (val){
                      if(val!.isNotEmpty){
                        return null;
                      }
                      else{
                        return "Name cannot be empty";
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}