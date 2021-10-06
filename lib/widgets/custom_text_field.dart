import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CUstomTextField extends StatelessWidget {
  TextEditingController controller;
  TextInputType type;
  Function(String?)? validator;
  Function(String)? onChange;
  double width;
  String hint;
  CUstomTextField(
      {required this.controller,
      required this.validator,
      this.type = TextInputType.text,
      this.onChange,
      this.width = 300,
      this.hint = ''});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: width,
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              validator: (val) {
                validator!(val);
              },
              onChanged: onChange,
              keyboardType: type,
              controller: controller,
              style: GoogleFonts.elMessiri(
                fontSize: 25,
              ),
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: hint),
            ),
          )),
    );
  }
}
