import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:meditation_app/features/home/data/mood_data.dart';
import 'package:meditation_app/features/home/data/recommendations.dart';
import 'package:meditation_app/features/home/model/recommendation_model.dart';
import 'package:meditation_app/features/home/widgets/balls_widget.dart';
import 'package:meditation_app/features/player/screens/player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<String> _notifier =
      ValueNotifier<String>(MoodData.calm.name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 70),
            Row(
              children: [
                SizedBox(
                  height: 60,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(120),
                      child: Image.asset('assets/images/model.jpeg')),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Good Morning, Sara!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "We wish you have a good day",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: Colors.indigo.withOpacity(.6),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(
                  Icons.more_vert_rounded,
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 150,
              child: ValueListenableBuilder<String>(
                  valueListenable: _notifier,
                  builder: (context, value, _) {
                    return ListView.builder(
                      itemCount: MoodData.moods.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var mood = MoodData.moods[index];
                        return GestureDetector(
                          onTap: () {
                            if (value != mood.name) {
                              _notifier.value = mood.name;
                            }
                          },
                          child: Column(
                            children: [
                              AnimatedContainer(
                                curve: Curves.fastEaseInToSlowEaseOut,
                                duration: const Duration(milliseconds: 500),
                                height: 70,
                                width: 70,
                                padding: EdgeInsets.all(
                                    value == mood.name ? 15 : 10),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 7.5, vertical: 10),
                                decoration: ShapeDecoration(
                                  color: value == mood.name
                                      ? Colors.indigo
                                      : Theme.of(context)
                                          .colorScheme
                                          .background,
                                  // color: Colors.indigo,
                                  shape: value == mood.name
                                      ? const StarBorder(
                                          pointRounding: .8,
                                          points: 4,
                                          innerRadiusRatio: .75,
                                        )
                                      : const CircleBorder(
                                          eccentricity: 1,
                                          side: BorderSide(
                                            color: Colors.indigo,
                                            width: 2,
                                          ),
                                        ),
                                  // shape: BoxShape.circle,
                                  // border: Border.all(
                                  //   color: Colors.indigo,
                                  //   width: 2,
                                  // ),
                                ),
                                child: Image.asset(
                                  mood.icon,
                                  color: value == mood.name
                                      ? Colors.white
                                      : Colors.indigo,
                                ),
                              ),
                              Text(
                                mood.name,
                                style: TextStyle(
                                  color: Colors.indigo,
                                  fontWeight: value == mood.name
                                      ? FontWeight.w900
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }),
            ),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Stack(
                children: [
                  Container(
                    height: 220,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.indigo.shade300,
                        border: Border.all(color: Colors.indigo.shade300)),
                  ),
                  Positioned(
                    height: 220,
                    right: -80,
                    bottom: -30,
                    child: Lottie.asset('assets/lottie/yoga.json'),
                  ),
                  Positioned.fill(
                    top: 35,
                    left: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Ready to start\nyour first session?",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Meditation 5-10 min",
                          style: TextStyle(
                            color: Colors.white.withOpacity(.8),
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 140,
                          child: FilledButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.indigo,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => PlayerScreen(
                                      model: RecommendationsData.mindfulMoments,
                                    ),
                                  ),
                                );
                              },
                              child: const Text("START")),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Recommended for you",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("View all"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: RecommendationsData.all.length,
                itemBuilder: (context, index) {
                  RecommendationModel model = RecommendationsData.all[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Balls(model: model),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
