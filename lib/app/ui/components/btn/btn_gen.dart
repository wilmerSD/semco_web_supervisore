import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class BtnGen extends StatelessWidget {
  const BtnGen({
    super.key,
    required this.text,
    this.loading = false,
    this.onTap,
    this.isGreen = false,
    this.margin,
    this.showBoxShadow = true,
    this.color,
    this.border = true,
  });
  final String text;
  final bool loading;
  final bool? isGreen;
  final void Function()? onTap;
  final EdgeInsetsGeometry? margin;
  final bool showBoxShadow;
  final Color? color;
  final bool border;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: border ? 39.0 : 40,
      margin: margin,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: color,
          border:
              border ? Border.all(width: 0.5, color: const Color.fromRGBO(28, 28, 28, 1)) : null
          // boxShadow: showBoxShadow
          //     ? [
          //         BoxShadow(
          //           color: AppColors.primary(context).withValues(),
          //           spreadRadius: 5,
          //           blurRadius: 20,
          //           offset: const Offset(0, 4),
          //         ),
          //       ]
          //     : [],
          ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8.0),
        child: InkWell(
          onTap: loading ? null : onTap,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    textScaler: const TextScaler.linear(1.0),
                    text,
                    style: AppTextStyle(context)
                        .bold14(fontWeight: FontWeight.w400),
                  ),
                ),
                if (loading)
                  const Row(
                    children: [
                      SizedBox(
                        width: 30.0,
                      ),
                      SizedBox(
                        width: 15,
                        height: 15,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color.fromRGBO(28, 28, 28, 1),
                        ),
                      ),
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
