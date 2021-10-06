import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CustomText extends StatelessWidget {
  String text;
  double size;
  FontWeight weight;
  Color color;
  CustomText(
      {required this.text,
      this.size = 28,
      this.weight = FontWeight.bold,
      this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.elMessiri(
          fontWeight: weight, fontSize: size, color: color),
    );
  }
}
