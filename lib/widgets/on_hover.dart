import 'package:flutter/material.dart';

class OnHover extends StatefulWidget {
  final Widget child;
  const OnHover({required this.child});

  @override
  _OnHoverState createState() => _OnHoverState();
}

class _OnHoverState extends State<OnHover> {
  bool isHoverd = false;

  @override
  Widget build(BuildContext context) {
    final hoverTransform = Matrix4.identity()..scale(1.05);
    final transform = isHoverd ? hoverTransform : Matrix4.identity();
    return MouseRegion(
        onEnter: (event) => onEntered(true),
        onExit: (event) => onEntered(false),
        child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            transform: transform,
            child: widget.child));
  }

  void onEntered(bool isHovered) {
    this.isHoverd = isHovered;
  }
}
