import 'dart:math';

import 'package:flutter/material.dart';
import 'package:meditation_app/features/home/model/recommendation_model.dart';
import 'package:meditation_app/features/player/screens/player.dart';

class Balls extends StatefulWidget {
  const Balls({
    super.key,
    required this.model,
  });

  @override
  State<Balls> createState() => _BallsState();

  final RecommendationModel model;
}

class _BallsState extends State<Balls> {
  List<double> positions = [0, 0, 0, 0];

  void randomize() {
    positions[0] = Random().nextInt(100) + 80;
    positions[1] = Random().nextInt(150) - 50;
    positions[2] = Random().nextInt(100) + 80;
    positions[3] = Random().nextInt(150) - 50;
  }

  initMoment() async {
    if (mounted && context.mounted) {
      randomize();

      setState(() {});
    }
    await Future.delayed(const Duration(seconds: 3));
    if (mounted && context.mounted) {
      initMoment();
    }
  }

  @override
  void initState() {
    super.initState();
    randomize();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      randomize();
      setState(() {});
      initMoment();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: Container(
        width: 170,
        decoration: BoxDecoration(
          color: widget.model.color.shade300,
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(seconds: 3),
              top: positions[0],
              right: positions[1],
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.model.color,
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(seconds: 3),
              bottom: positions[2],
              left: positions[3],
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.model.color,
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 10,
              right: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.model.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Text(
                    'course',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        widget.model.duration,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PlayerScreen(model: widget.model),
                            ),
                          );
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/icons/play.png',
                            height: 30,
                            width: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
