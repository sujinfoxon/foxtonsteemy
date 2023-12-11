import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

const String apiKey = "AIzaSyBCJTGfWjJu4J43O_jHDs8Xt3o_QfFV838";

Color kblue = Color(0xFF4756DF);
Color kwhite = Color(0xFFFFFFFF);
Color kblack = Color(0xFF000000);
Color kbrown300 = Color(0xFF8D6E63);
Color kbrown = Color(0xFF795548);
Color kgrey = Color(0xFFC0C0C0);

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print("No image selected");

}
showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(content)));
}
const Color login_bg = Color(0xff00C470);
const Color signup_bg = Color(0xff000a54);
const double defaultPadding = 16.0;
const Duration defaultDuration = Duration(milliseconds: 300);
