import 'package:flutter/material.dart';

class AppTextColor {
  static Color textStatusAsignedColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(122, 122, 122, 1) //dark
        : const Color.fromRGBO(122, 122, 122, 1); //light
  }

  static Color textStatusInWorkColorColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(0, 72, 121, 1) //dark
        : const Color.fromRGBO(0, 72, 121, 1); //light
  }

  static Color textStatusReviewColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(124, 80, 0, 1) //dark
        : const Color.fromRGBO(124, 80, 0, 1); //light
  }

  static Color textStatusFinishedColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(25, 126, 0, 1) //dark
        : const Color.fromRGBO(25, 126, 0, 1); //light
  }

  static Color textStatusPauseColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(122, 122, 122, 1) //dark
        : const Color.fromRGBO(122, 122, 122, 1); //light
  }

  static Color textDaysToFinishOnTime(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(122, 201, 67, 1) //dark
        : const Color.fromRGBO(122, 201, 67, 1); //light
  }

  static Color textDaysToFinishAbout(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(255, 165, 0, 1) //dark
        : const Color.fromRGBO(255, 165, 0, 1); //light
  }

  static Color textDaysToFinishNegative(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(255, 86, 86, 1) //dark
        : const Color.fromRGBO(255, 86, 86, 1); //light
  }

  static Color textTittleStepper(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(219, 219, 219, 1) //dark
        : const Color.fromRGBO(107, 114, 128, 1); //light
  }

  static Color textSubTittleStepper(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(205, 205, 205, 1) //dark
        : const Color.fromRGBO(159, 166, 168, 1); //light
  }

  static Color textValueProject(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(178, 178, 178, 1) //dark
        : const Color.fromRGBO(115, 115, 115, 1); //light
  }

  static Color textHeadProject(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(211, 211, 211, 1) //dark
        : const Color.fromRGBO(68, 68, 68, 1); //light
  }

  static Color textClientSelected(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(211, 211, 211, 1) //dark
        : const Color.fromRGBO(68, 68, 68, 1); //light
  }

  static Color textClientNotSelected(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromARGB(134, 211, 211, 211) //dark
        : const Color.fromARGB(136, 68, 68, 68); //light
  }

  static const Color textKanbanColor = Color.fromRGBO(0, 151, 255, 1);
  static const Color textKanbanNoSelectedColor =
      Color.fromARGB(255, 138, 193, 238);
}
