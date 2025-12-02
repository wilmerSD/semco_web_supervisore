import 'package:app_tasking/core/helpers/constant.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_decorators.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class InputDescription extends StatelessWidget {
  const InputDescription({
    this.textEditingController,
    required this.onChanged,
    this.labelText,
    this.hintText,
    this.isMandatory = false,
    super.key,
  });
  final TextEditingController? textEditingController;
  final Function(String value) onChanged;
  final String? labelText;
  final String? hintText;
  final bool isMandatory;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style:
            AppTextStyle(context).bold13(color: AppColors.textBasic(context)),
        onChanged: (value) => onChanged(value),
        controller: textEditingController,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.multiline,
        maxLines: 3,
        minLines: 1,
        decoration: AppDecorators.inputDecorationGen(
            context, hintText ?? '', labelText ?? '', null, isMandatory));
  }
}
