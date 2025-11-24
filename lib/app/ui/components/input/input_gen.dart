import 'package:app_tasking/core/helpers/constant.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_decorators.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputGen extends StatelessWidget {
  const InputGen({
    this.textEditingController,
    required this.onChanged,
    super.key,
    required this.labelText,
    required this.hintText,
    this.helperText,
    this.icon,
    this.isMandatory = false,
    this.inputFormats,
    this.suffixIcon,
  });
  final TextEditingController? textEditingController;
  final Function(String) onChanged;
  final String labelText;
  final String hintText;
  final String? helperText;
  final IconData? icon;
  final bool isMandatory;
  final List<TextInputFormatter>? inputFormats;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        helperText != null
            ? Column(
                children: [
                  Row(
                    children: [
                      icon != null
                          ? Row(
                              children: [
                                Icon(icon, size: 12.0),
                                const SizedBox(
                                  width: 3.0,
                                )
                              ],
                            )
                          : const SizedBox(),
                      Text(helperText!),
                      isMandatory ? const Text('*') : const SizedBox(),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                ],
              )
            : const SizedBox(),
        TextFormField(
            style: AppTextStyle(context)
                .bold13(color: AppColors.textBasic(context)),
            inputFormatters: inputFormats,
            onChanged: (value) => onChanged(value),
            controller: textEditingController,
            textAlignVertical: TextAlignVertical.center,
            keyboardType: TextInputType.multiline,
            maxLines: 1,
            minLines: 1,
            decoration: InputDecoration(
              counterText: "",
              filled: false,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 12.0,
              ),
              //floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIconColor: AppColors.primary(context),
              floatingLabelStyle: AppTextStyle(context).medium14(
                color: AppColors.grayBlue,
              ),
              labelStyle: AppTextStyle(context).medium14(
                color: AppColors.grayBlue,
              ),
              hintText: hintText,
              hintStyle: AppTextStyle(context).medium14(
                color: AppColors.black,
              ),
              labelText: labelText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kRadiusMin),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kRadiusMin),
                borderSide: const BorderSide(
                  width: 1.0,
                  color: AppColors.grayLight,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kRadiusMin),
                borderSide: BorderSide(
                  width: 0.5,
                  color: AppColors.primary(context),
                ),
              ),
              suffixIcon: suffixIcon,
            )),
      ],
    );
  }
}
