import 'package:flutter/material.dart';
import 'package:Islands/pages/navigator_bar_controller.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashCajero extends StatelessWidget {
  
  const SplashCajero({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  SplashScreenView(
      navigateRoute: const NavigatorBarController(),
      duration: 5000,
      imageSize: 250,
      imageSrc: "assets/images/Islas.png",
      text: "Cargando",
      textType: TextType.ColorizeAnimationText,
      textStyle: const TextStyle(
        fontSize: 20.0,
        fontFamily: 'TypoGrotesk'
      ),
      colors: const [
        Color.fromARGB(255, 43, 241, 115),
        Color.fromARGB(255, 60, 222, 184),
        Color.fromARGB(255, 54, 200, 244),
        Color.fromARGB(255, 37, 72, 245),
        Color.fromARGB(255, 37, 155, 245),
        Color.fromARGB(255, 37, 197, 245),
        Color.fromARGB(255, 43, 241, 115),
        Color.fromARGB(255, 60, 222, 184),
        Color.fromARGB(255, 54, 200, 244),
        Color.fromARGB(255, 37, 72, 245),
      ],
      backgroundColor: Colors.white,
    );
  }

}