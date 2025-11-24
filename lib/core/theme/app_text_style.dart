import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
  AppTextStyle(this.context);
  final BuildContext context;

  TextStyle titleAppBar({
    Color color = AppColors.grayLight,
  }) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
          color: color, fontWeight: FontWeight.bold, fontFamily: 'Montserrat');

  TextStyle bold33({Color color = Colors.white}) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 33.0,
          fontFamily: 'Montserrat');

  TextStyle bold32({Color color = Colors.white}) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 32.0,
          fontFamily: 'Montserrat');

  TextStyle bold31({Color color = Colors.white}) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 31.0,
          fontFamily: 'Montserrat');

  TextStyle bold30({Color color = Colors.white}) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 30.0,
          fontFamily: 'Montserrat');

  TextStyle bold29({Color color = Colors.white}) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 29.0,
          fontFamily: 'Montserrat');

  TextStyle bold28({Color color = Colors.white}) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 28.0,
          fontFamily: 'Montserrat');

  TextStyle bold27({Color color = Colors.white}) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 27.0,
          fontFamily: 'Montserrat');

  TextStyle bold26({Color color = Colors.white}) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 26.0,
          fontFamily: 'Montserrat');

  TextStyle bold25({Color color = Colors.white}) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 25.0,
          fontFamily: 'Montserrat');

  TextStyle bold24({Color color = Colors.white}) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 24.0,
          fontFamily: 'Montserrat');

  TextStyle bold23(
          {Color? color = AppColors.grayDark,
          FontWeight fontWeight = FontWeight.w700}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 23.0,
          fontFamily: 'Montserrat');

  TextStyle bold22(
          {Color? color = AppColors.grayDark,
          FontWeight fontWeight = FontWeight.w700}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 22.0,
          fontFamily: 'Montserrat');

  TextStyle bold21(
          {Color? color = AppColors.grayDark,
          FontWeight? fontWeight = FontWeight.w700}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 21.0,
          fontFamily: 'Montserrat');

  TextStyle bold20(
          {Color? color = AppColors.grayDark,
          FontWeight fontWeight = FontWeight.w700}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 20,
          fontFamily: 'Montserrat');

  TextStyle bold18(
          {Color? color = AppColors.grayDark,
          FontWeight fontWeight = FontWeight.w700}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 18,
          fontFamily: 'Montserrat');

  TextStyle bold16(
          {Color? color = AppColors.grayDark,
          FontWeight fontWeight = FontWeight.w700}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 16,
          fontFamily: 'Montserrat');

  TextStyle bold15(
          {Color? color,
          FontWeight fontWeight = FontWeight.w700}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 15,
          fontFamily: 'Montserrat');

  TextStyle bold14(
          {Color? color,
          FontWeight fontWeight = FontWeight.w500}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 14,
          fontFamily: 'Montserrat');

  TextStyle bold13(
          {Color? color = AppColors.grayDark,
          FontWeight fontWeight = FontWeight.w500}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 13,
          fontFamily: 'Montserrat');

  TextStyle bold12(
          {Color? color = AppColors.grayDark,
          FontWeight fontWeight = FontWeight.w500}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 12,
          fontFamily: 'Montserrat');
  TextStyle bold11(
          {Color? color = AppColors.grayDark,
          FontWeight fontWeight = FontWeight.w500}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 11,
          fontFamily: 'Montserrat');

  TextStyle bold10(
          {Color? color = AppColors.grayDark,
          FontWeight fontWeight = FontWeight.w500}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 10,
          fontFamily: 'Montserrat');
  TextStyle bold9(
          {Color? color = AppColors.grayDark,
          FontWeight fontWeight = FontWeight.w500}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 9,
          fontFamily: 'Montserrat');
  TextStyle bold8(
          {Color? color = AppColors.grayDark,
          FontWeight fontWeight = FontWeight.w500}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 8,
          fontFamily: 'Montserrat');

  TextStyle bold7(
          {Color? color = AppColors.grayDark,
          FontWeight fontWeight = FontWeight.w500}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 7.0,
          fontFamily: 'Montserrat');
  //-----------------------------

  TextStyle normal12({
    Color color = AppColors.grayLight,
  }) =>
      Theme.of(context)
          .textTheme
          .bodySmall!
          .copyWith(color: color, fontSize: 12.0, fontFamily: 'Montserrat');

  TextStyle semi12({
    Color color = AppColors.grayLight,
  }) =>
      Theme.of(context).textTheme.bodySmall!.copyWith(
          color: color,
          fontWeight: FontWeight.w500,
          fontSize: 12.0,
          fontFamily: 'Montserrat');

  TextStyle semi16({Color color = AppColors.grayLight}) =>
      Theme.of(context).textTheme.titleMedium!.copyWith(
          color: color,
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
          fontFamily: 'Montserrat');

  TextStyle semi14({
    Color color = AppColors.grayLight,
  }) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: FontWeight.w500,
          fontSize: 14,
          fontFamily: 'Montserrat');

  TextStyle medium14({
    Color color = AppColors.grayLight,
  }) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: FontWeight.w400,
          fontSize: 14,
          fontFamily: 'Montserrat');

  TextStyle medium12({
    Color color = AppColors.grayLight,
  }) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: FontWeight.w400,
          fontSize: 12,
          fontFamily: 'Montserrat');

  TextStyle extra20({Color? color = Colors.white}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
          fontFamily: 'Montserrat');

  TextStyle extra22({Color? color = Colors.white}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: color,
            fontWeight: FontWeight.w900,
            fontSize: 22.0,
          );

  TextStyle extra14({Color? color = Colors.white}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: color,
            fontWeight: FontWeight.w300,
            fontSize: 14,
          );

  TextStyle extra16({Color? color = Colors.white}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          fontFamily: 'Montserrat');
  TextStyle textToast({
    Color? color,
  }) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color ?? Colors.white, //AppColors.textTittleContent(context),
          fontWeight: FontWeight.w400,
          fontSize: 13.0,
          fontFamily: 'Montserrat');

  TextStyle extra40({
    Color? color = Colors.white,
  }) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 40,
            fontFamily: 'Montserrat',
          );
}
