import 'package:flutter/material.dart';
import 'package:meditation_app/features/onboarding/screens/onboarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigoAccent,
        ),
        useMaterial3: true,
      ),
      home: const OnBoardingScreen(),
    );
  }
}
