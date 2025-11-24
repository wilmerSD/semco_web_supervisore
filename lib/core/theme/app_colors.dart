import 'package:app_tasking/core/helpers/constant.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class AppColors {
  static Color backgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(28, 28, 28, 1) //dark
        : const Color.fromARGB(255, 255, 255, 255); //light
  }

  static Color primary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(228, 67, 26, 1) //dark
        : const Color.fromRGBO(228, 67, 26, 1); //light
  }

  static Color blueDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromARGB(255, 204, 213, 255) //dark
        : const Color.fromRGBO(59, 79, 170, 1); //light
  }

  static Color primaryThird(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(24, 43, 57, 1) //dark
        : const Color.fromRGBO(232, 242, 250, 1); //light
  }

  static Color listProyectsColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(41, 41, 41, 1) //dark
        : const Color.fromARGB(255, 255, 255, 255); //light
  }

  static Color borderListProyectsColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(63, 63, 63, 1) //dark
        : const Color.fromRGBO(232, 242, 250, 1); //light
  }

  /*Estados de trabajo*/
  static Color statusReviewColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(255, 165, 0, 1) //dark
        : const Color.fromRGBO(255, 165, 0, 1); //light
  }

  static Color statusInWorkColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(147, 207, 255, 1) //dark
        : const Color.fromRGBO(147, 207, 255, 1); //light
  }

  static Color statusToDoColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(232, 242, 250, 1) //dark
        : const Color.fromRGBO(232, 242, 250, 1); //light
  }

  static Color statusFinishedColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(62, 63, 64, 1) //dark
        : const Color.fromRGBO(88, 211, 57, 1); //light
  }

  static Color statusAsignedColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(219, 219, 219, 1) //dark
        : const Color.fromRGBO(219, 219, 219, 1); //light
  }

  /* Otros */
  static Color textBasic(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromARGB(255, 253, 253, 253) //dark
        : const Color.fromARGB(255, 0, 0, 0); //light
  }

  static Color timeToFinishedColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(20, 229, 27, 1) //dark
        : const Color.fromRGBO(20, 229, 27, 1); //light
  }

  static Color shadowListColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromARGB(255, 99, 99, 102)
        : //dark
        const Color.fromARGB(255, 220, 220, 231); //light
  }

  static Color menuSelectedColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? primaryConst
        : //dark
        primaryConst; //light
  }

  static Color reportColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(255, 165, 0, 1)
        : //dark
        const Color.fromRGBO(255, 165, 0, 1); //light
  }

  static Color reportColorSec(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromARGB(255, 253, 213, 139)
        : //dark
        const Color.fromARGB(255, 253, 213, 139); //light
  }

  static Color noteColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(139, 195, 74, 1)
        : //dark
        const Color.fromRGBO(139, 195, 74, 1); //light
  }

  static Color noteColorSec(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromARGB(255, 197, 223, 168)
        : //dark
        const Color.fromARGB(255, 197, 223, 168); //light
  }

  static Color commentColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(33, 150, 243, 1)
        : //dark
        const Color.fromRGBO(33, 150, 243, 1); //light
  }

  static Color commentColorSec(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromARGB(19, 101, 180, 244)
        : //dark
        const Color.fromARGB(141, 110, 183, 243); //light
  }

  static Color evaluationColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(255, 165, 0, 1)
        : //dark
        const Color.fromRGBO(255, 165, 0, 1); //light
  }

  static Color evaluationColorSec(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(255, 203, 109, 1)
        : //dark
        const Color.fromRGBO(255, 203, 109, 1); //light
  }

  static Color backgroundColorSec(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(223, 223, 223, 1) //dark
        : const Color.fromRGBO(240, 243, 253, 1); //light
  }

  static Color backgroundKanbanColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(28, 28, 30, 1) //dark
        : const Color.fromRGBO(189, 229, 241, 1); //dark
  }

  static Color groupBackgroundKanbanColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(37, 37, 39, 1) //dark
        : const Color.fromRGBO(240, 249, 255, 0.46); //dark
  }

  static Color listKanbanColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(44, 44, 46, 1) //dark
        : const Color.fromRGBO(255, 255, 255, 1); //dark
  }

  static Color listHorizProjectCardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(44, 44, 46, 1) //dark
        : const Color.fromRGBO(255, 255, 255, 1); //light
  }

  static Color firstPartColorLogo(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(225, 255, 255, 1) //dark
        : const Color.fromRGBO(89, 89, 89, 1); //light
  }

  static Color closeBtnColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(81, 81, 81, 1) //dark
        : const Color.fromRGBO(249, 249, 249, 1); //dark
  }

  static Color shadowAppBarColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(70, 70, 70, 1) //dark
        : const Color.fromRGBO(239, 239, 239, 1); //light
  }

  static Color backgroundContainer(BuildContext context) {
    //Por ejemplo para la lista de reuniones
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(28, 28, 30, 100) //dark
        : const Color.fromARGB(255, 246, 246, 246); //light
  }

  static Color firstBackgroundContainer(BuildContext context) {
    //Por ejemplo para la lista de reuniones
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(44, 44, 46, 100) //light
        : const Color.fromARGB(255, 246, 246, 246); //dark
  }

  static Color secondary(BuildContext context) {
    //Por ejemplo: Hoy, Proximos, Anteriores ...
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromARGB(255, 246, 246, 246)
        : const Color.fromRGBO(11, 0, 105, 1);
  }

  static const Color primaryWC = Color.fromRGBO(0, 114, 192, 1);

  static const Color primaryConst = Color.fromRGBO(228, 67, 26, 1);
  static const Color secondaryConst = Color.fromRGBO(11, 0, 105, 1);
  static const Color primarySec = Color.fromRGBO(44, 152, 226, 1);

  static const Color headerCreate = Color.fromRGBO(24, 90, 151, 1);
  static const Color headerOptions = Color.fromRGBO(255, 255, 255, .2);
  static const Color skyblue = Color.fromRGBO(189, 220, 241, 1);

  static const Color red = Color.fromRGBO(231, 44, 49, 1.0);
  static const Color orange = Color.fromRGBO(242, 140, 3, 1.0);
  static const Color grayLight = Color.fromRGBO(230, 230, 241, 1);
  static const Color grayBlue = Color.fromRGBO(125, 126, 138, 1);
  static const Color radiusMap = Color.fromRGBO(38, 52, 113, 0.219);
  static const Color grey = Color.fromRGBO(71, 71, 73, 1);
  static const Color blueRecoverPass = Color.fromRGBO(0, 85, 184, 1);
  static const Color grayMiddle = Color.fromRGBO(147, 147, 178, 1);
  //----------------------------------------------------------------
  static const Color validationTimely = Color.fromRGBO(0, 196, 140, 1);
  static const Color validationMissing = Color.fromRGBO(231, 44, 49, 1);
  static const Color validationLate = Color.fromRGBO(239, 202, 102, 1);
  static const Color validationJustified = Color.fromRGBO(242, 140, 3, 1);

  //----------------------------------------------------------------
  static const Color degradedInitial = Color.fromARGB(255, 247, 85, 45);
  static const Color shadowButton = Color.fromARGB(137, 71, 70, 70);
  static const Color logoBad = Color.fromARGB(255, 244, 55, 22);
  static const Color logoRight = Color.fromARGB(255, 76, 201, 170);
  static const Color degradedStart = Color.fromRGBO(18, 124, 196, 0.98);
  static const Color modalBarrier = Color.fromARGB(33, 87, 85, 85);
  static const Color contentNotification = Color.fromRGBO(247, 248, 253, 1);
  static const Color redLoading = Color.fromRGBO(230, 0, 0, 0.8);
  static const Color black = Color.fromRGBO(27, 21, 61, 1.0);

  static const Color grayDark = Color.fromRGBO(47, 46, 65, 1);
  static const Color light = Color.fromRGBO(239, 239, 239, 1.0);
  static const Color green = Color.fromRGBO(76, 175, 80, 1);
  static const Color yellow = Color.fromRGBO(255, 235, 59, 1);
  //-----------
  static const Color purpleCustom = Color.fromRGBO(53, 43, 200, 1);
  static const Color blueCustom = Color.fromRGBO(47, 119, 234, 1);

  static const Color borderForm = Color.fromRGBO(230, 230, 241, 1);

  static const Color green02 = Color.fromRGBO(0, 166, 90, 1);
  static const Color green03 = Color.fromRGBO(0, 166, 90, 0.65);
  static const Color orangeCustom = Color.fromRGBO(221, 75, 57, 1);
  static const Color purpleCustomLoading = Color.fromRGBO(53, 43, 200, 0.8);
  static const Color blueCustomLoading = Color.fromRGBO(47, 119, 234, 0.8);
  static const Color giftColor = Color.fromRGBO(223, 240, 216, 1.0);
  static const Color noConectionColor = Color.fromRGBO(246, 185, 278, 1.0);

  static const Color graySchedule = Color.fromARGB(255, 243, 243, 243);

  static const Color underlineColorGen = Color.fromARGB(255, 93, 93, 93);

  static const BoxShadow boxShadowGeneral = BoxShadow(
    blurRadius: 4,
    spreadRadius: -2,
    offset: Offset(0, 1),
    // color: Colors.black.withOpacity(0.08), // sombra sutil
  );

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      primaryConst,
      primaryConst,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient gradientToLogin = LinearGradient(
    colors: [
      primaryWC,
      Color.fromRGBO(255, 229, 195, 1),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient gradientToHeader = LinearGradient(
    colors: [
      secondaryConst,
      primaryConst,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  //---
  static const LinearGradient primaryGradientLoading = LinearGradient(
    colors: [
      redLoading,
      redLoading,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient greenGradientLoading = LinearGradient(
      colors: [green03, green03],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);

  //----------------------------------------------------------------
}
