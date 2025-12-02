import 'package:app_tasking/core/helpers/constant.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_decorators.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputDate extends StatelessWidget {
  const InputDate(
      {required this.textEditingController,
      required this.onChanged,
      super.key,
      this.suffixIcon,
      this.labelText,
      this.inputFormats,
      this.hintText,
      this.readOnly = false,
      this.helperText,
      this.icon,
      this.isMandatory = false,
      this.focusNode});
  final TextEditingController textEditingController;
  final Function(String) onChanged;
  final Widget? suffixIcon;
  final String? labelText;
  final List<TextInputFormatter>? inputFormats;
  final String? hintText;
  final bool? readOnly;
  final String? helperText;
  final IconData? icon;
  final bool isMandatory;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      helperText != null
          ? Row(
              children: [
                icon != null
                    ? Row(
                        spacing: 8.0,
                        children: [
                          Icon(icon, size: 15.0),
                          const SizedBox(
                            width: 3.0,
                          )
                        ],
                      )
                    : const SizedBox(),
                Text(helperText!),
                isMandatory
                    ? const Text(
                        '*',
                        style: TextStyle(color: Colors.red),
                      )
                    : const SizedBox(),
                const SizedBox(
                  width: 10.0,
                ),
              ],
            )
          : const SizedBox(),
      Expanded(
        child: TextFormField(
          focusNode: focusNode,
          style:
              AppTextStyle(context).bold13(color: AppColors.textBasic(context)),
          maxLength: 10,
          readOnly: readOnly ?? false,
          onChanged: (value) => onChanged(value),
          controller: textEditingController,
          textAlignVertical: TextAlignVertical.center,
          keyboardType: TextInputType.multiline,
          maxLines: 1,
          minLines: 1,
          inputFormatters: inputFormats,
          decoration: AppDecorators.inputDecorationGen(
              context, hintText ?? "", '', null, isMandatory),
        ),
      )
    ]);
  }
}
