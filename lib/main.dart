import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: CircleAnimation());
  }
}

class CircleAnimation extends StatefulWidget {
  const CircleAnimation({super.key});

  @override
  State<CircleAnimation> createState() => _CircleAnimationState();
}

class _CircleAnimationState extends State<CircleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 8), // 旋转动画时间
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111827),
      body: Center(
        child: Stack(
          children: List.generate(8, (index) {
            return AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                double angle = (index * 45.0) * (pi / 180.0);
                return Transform.rotate(
                  angle: _controller.value * 2 * pi,
                  child: Transform.translate(
                    offset: Offset(100 * cos(angle), 100 * sin(angle)),
                    child: ScaleTransition(
                      scale: Tween(begin: 1.0, end: 1.5).animate(
                        CurvedAnimation(
                          parent: _controller,
                          curve: Interval(
                            index * 0.125,
                            (index * 0.125) + 0.125,
                            curve: Curves.ease,
                          ),
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: _getColor(index),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }

  Color _getColor(int index) {
    const colors = [
      Color(0xFF63F78A),
      Color(0xFF5FF19F),
      Color(0xFF5DEEA8),
      Color(0xFF5CEBB2),
      Color(0xFF5AE7BB),
      Color(0xFF58E4C3),
      Color(0xFF57E0CC),
      Color(0xFF56DCD3),
    ];
    return colors[index % colors.length];
  }
}
