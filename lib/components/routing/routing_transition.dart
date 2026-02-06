import 'package:flutter/material.dart';

class RoutingTransition extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;
  const RoutingTransition(
      {super.key, required this.animation, required this.child});

  @override
  Widget build(BuildContext context) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;
    Animatable<Offset> tween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    Animation<Offset> offsetAnimation = animation.drive(tween);
    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }
}
