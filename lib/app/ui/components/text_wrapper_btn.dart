import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextWrapperBtn extends StatelessWidget {
  const TextWrapperBtn(
      {super.key,
      required this.child,
      this.radius = 18.0,
      this.onTap,
      this.backgroundColor = Colors.transparent,
      this.isMini = false});
  final Widget child;
  final double radius;
  final void Function()? onTap;
  final Color backgroundColor;
  final bool isMini;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(isMini ? 5 : 10),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical:  5.0.h,horizontal: 3.0.w),
          child: child),
      ),
    );
  }
}