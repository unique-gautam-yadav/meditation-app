import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:meditation_app/features/home/model/recommendation_model.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key, required this.model});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();

  final RecommendationModel model;
}

class _PlayerScreenState extends State<PlayerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progress;

  final ValueNotifier<double> _player = ValueNotifier<double>(0);
  bool _isDark = false;

  controllerListener() {
    if (_controller.status == AnimationStatus.forward ||
        _controller.status == AnimationStatus.completed) {
      increasePlayer();
    }
  }

  increasePlayer() async {
    if (_controller.status == AnimationStatus.forward ||
        _controller.status == AnimationStatus.completed) {
      if ((_player.value + .0005) > 1) {
        _player.value = 1;
        _controller.reverse();
      } else {
        _player.value += .00005;
      }

      await Future.delayed(
        const Duration(milliseconds: 100),
      );
      if (_player.value < 1) {
        increasePlayer();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _progress = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.addListener(() {
      controllerListener();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _isDark ? Colors.black : Colors.white,
      child: Scaffold(
        backgroundColor: widget.model.color.withOpacity(.1),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    highlightColor: widget.model.color.withOpacity(.2),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.keyboard_backspace_rounded,
                      color: widget.model.color.shade300,
                    ),
                  ),
                  IconButton(
                    highlightColor: widget.model.color.withOpacity(.2),
                    onPressed: () {
                      setState(() {
                        _isDark = !_isDark;
                      });
                    },
                    icon: Icon(
                      _isDark
                          ? CupertinoIcons.sun_max_fill
                          : CupertinoIcons.moon_stars_fill,
                      color: widget.model.color.shade300,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              SizedBox.square(
                dimension: MediaQuery.sizeOf(context).width - 40,
                child: Stack(
                  children: [
                    Positioned.fill(
                      left: 30,
                      top: 30,
                      bottom: 30,
                      right: 30,
                      child: ValueListenableBuilder(
                          valueListenable: _player,
                          builder: (context, value, _) {
                            return CircularProgressIndicator(
                              color: widget.model.color.shade300,
                              value: value,
                              strokeCap: StrokeCap.round,
                              strokeWidth: 10,
                              backgroundColor:
                                  widget.model.color.withOpacity(.4),
                            );
                          }),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: Container(
                          padding: const EdgeInsets.only(top: 120, left: 20),
                          height: 200,
                          width: 200,
                          color: widget.model.color.shade300,
                          child: Transform.scale(
                            scale: 3,
                            child: Lottie.asset('assets/lottie/yoga.json'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.model.title,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: widget.model.color.shade300,
                ),
              ),
              Text(
                widget.model.author,
                style: TextStyle(
                  fontSize: 16,
                  color: widget.model.color.shade300,
                ),
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  const Spacer(),
                  IconButton(
                    highlightColor: widget.model.color.withOpacity(.2),
                    onPressed: () {},
                    icon: Icon(
                      Icons.skip_previous_rounded,
                      size: 50,
                      color: widget.model.color.withOpacity(.3),
                    ),
                  ),
                  const SizedBox(width: 30),
                  IconButton(
                    highlightColor: widget.model.color.withOpacity(.2),
                    onPressed: () {
                      if (_controller.status == AnimationStatus.completed) {
                        _controller.reverse();
                      } else {
                        _controller.forward();
                      }
                    },
                    icon: AnimatedIcon(
                      icon: AnimatedIcons.play_pause,
                      progress: _progress,
                      size: 50,
                      color: widget.model.color.shade300,
                    ),
                  ),
                  const SizedBox(width: 30),
                  IconButton(
                    highlightColor: widget.model.color.withOpacity(.2),
                    onPressed: () {},
                    icon: Icon(
                      Icons.skip_next_rounded,
                      size: 50,
                      color: widget.model.color.withOpacity(.3),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              ValueListenableBuilder(
                valueListenable: _player,
                builder: (context, value, _) {
                  return Slider(
                    thumbColor: widget.model.color.shade300,
                    activeColor: widget.model.color.shade300,
                    inactiveColor: widget.model.color.withOpacity(.4),
                    secondaryActiveColor: widget.model.color.withOpacity(.4),
                    secondaryTrackValue: .8,
                    value: value,
                    onChanged: (_) {
                      _controller.reverse();
                      _player.value = _;
                    },
                  );
                },
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  widget.model.slogan,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: widget.model.color.shade300,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
