import 'package:flutter/material.dart';
import 'package:hangman/components/colors.dart';
import 'package:hangman/components/text_format.dart';

Widget letter(String character, bool hidden) {
  return Container(
    height: 65,
    width: 50,
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: secondaryColor,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Visibility(
      visible: !hidden,
      child: Center(
        child: PoppinsText(
          text: character,
          fontS: 35,
          color: Colors.white,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );
}
