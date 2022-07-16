import 'package:flutter/material.dart';
import 'package:Islands/pages/splash_screen_page.dart';
import 'package:Islands/provider/islands_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState();


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => IslandsProvider(), lazy: false),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Islands',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        fontFamily: 'Renogare',
      ),
      home: const SplashCajero(),
    );
  }
}