import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:meditation_app/features/home/screens/home.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.indigo.shade800,
                  Colors.indigoAccent.shade200,
                  Colors.indigoAccent.shade200,
                ],
              ),
            ),
          ),
          const Positioned(
            top: 200,
            left: 0,
            right: 0,
            child: Text(
              "Welcome To\nMeditation Centre",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w900,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(),
          Positioned(
            bottom: 0,
            left: -10,
            right: -10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.9),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(
                    2000,
                  ),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 300),
                  FractionallySizedBox(
                    widthFactor: .6,
                    child: FilledButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HomeScreen(),
                            ),
                          );
                        },
                        child: const Text("GET STARTED")),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: Lottie.asset('assets/lottie/yoga2.json'),
          ),
        ],
      ),
    );
  }
}
