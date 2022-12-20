import 'package:flutter/material.dart';
import 'package:image_to_text_converter_app/home_page.dart';
import './main.dart';
import './home_page.dart';
//import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:splashscreen/splashscreen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 15,
      navigateAfterSeconds: HomePage(),
      title: Text(
        'Image to Text Converter',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      image: Image.asset("assets/imagetext.png"),
      photoSize: 120,
      backgroundColor: Colors.white,
      loaderColor: Colors.black,
      loadingText: Text(
        'Image is loading',
        style: TextStyle(
          fontSize: 10,
          //fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
