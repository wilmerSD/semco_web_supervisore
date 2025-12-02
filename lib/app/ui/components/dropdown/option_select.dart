import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class OptionSelect extends StatelessWidget {
  const OptionSelect({super.key, this.nameOption});
  final String? nameOption;
  @override
  Widget build(BuildContext context) {
    return Text(
      nameOption ?? "",
      style: AppTextStyle(context).bold13(color: AppColors.textBasic(context)),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }
}
