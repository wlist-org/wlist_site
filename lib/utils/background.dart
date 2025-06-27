import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wlist_site/theme.dart';

class BackgroundWithBubbles extends StatefulWidget {
  const BackgroundWithBubbles({super.key});

  @override
  State<BackgroundWithBubbles> createState() => _BackgroundWithBubblesState();
}

class _BackgroundWithBubblesState extends State<BackgroundWithBubbles> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: SizedBox.expand(
          child: Stack(
            children: [
              for (var index = 0; index < 5; ++index)
                _Bubbles(
                  key: ValueKey(index),
                  tickerProvider: this,
                ),
            ],
          ),
        ),
      ),
    );
  }
}


class _Bubbles extends StatefulWidget {
  const _Bubbles({
    super.key,
    required this.tickerProvider,
  });
  final TickerProvider tickerProvider;

  @override
  State<_Bubbles> createState() => _BubblesState();
}

class _BubblesState extends State<_Bubbles> {
  final Random random = Random();

  late AnimationController fadeController;
  late AnimationController moveController;

  late Animation<double> fadeAnimation;
  late Animation<Offset> moveAnimation;

  double left = 0;
  double top = 0;
  double scale = 1;

  bool isDisposed = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimationCycle();
  }

  @override
  void dispose() {
    isDisposed = true;
    fadeController.dispose();
    moveController.dispose();
    super.dispose();
  }

  void _initializeAnimations() {
    fadeController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: widget.tickerProvider,
    );

    moveController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: widget.tickerProvider,
    );

    fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: fadeController,
      curve: Curves.easeInOut,
    ));
  }

  void _startAnimationCycle() {
    if (isDisposed) return;

    left = random.nextDouble();
    top = random.nextDouble();
    scale = random.nextDouble() + 0.3;

    final moveX = (random.nextDouble() * 2 - 1) * 200;
    final moveY = (random.nextDouble() * 2 - 1) * 200;
    moveAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(moveX, moveY),
    ).animate(CurvedAnimation(
      parent: moveController,
      curve: Curves.linear,
    ));

    final startDelay = Duration(milliseconds: random.nextInt(5000));
    final displayDuration = Duration(milliseconds: 2000 + random.nextInt(3000));

    Future.delayed(startDelay, () {
      if (isDisposed) return;

      fadeController.forward();
      moveController.repeat();

      Future.delayed(displayDuration, () {
        if (isDisposed) return;

        fadeController.reverse().then((_) {
          if (isDisposed) return;

          moveController.stop();
          moveController.reset();

          Future.delayed(const Duration(seconds: 5), () {
            _startAnimationCycle();
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([fadeAnimation, moveAnimation]),
      builder: (context, child) {
        return Positioned(
          left: MediaQuery.sizeOf(context).width * left + moveAnimation.value.dx,
          top: MediaQuery.sizeOf(context).height * top + moveAnimation.value.dy,
          child: Transform.scale(
            scale: scale,
            child: Transform.translate(
              offset: const Offset(-250, -250),
              child: Opacity(
                opacity: fadeAnimation.value,
                child: Container(
                  width: 500,
                  height: 500,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: CustomColors.backgroundBubble,
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
