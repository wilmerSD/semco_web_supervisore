import 'package:app_tasking/core/helpers/constant.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class InputDescription extends StatelessWidget {
  const InputDescription({
     this.textEditingController,
    required this.onChanged,
    this.labelText,
    this.hintText,
    super.key,
  });
  final TextEditingController? textEditingController;
  final Function(String value) onChanged;
  final String? labelText;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: AppTextStyle(context)
                .bold13(color: AppColors.textBasic(context)),
        onChanged: (value) => onChanged(value),
        controller: textEditingController,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.multiline,
        maxLines: 3,
        minLines: 1,
        decoration: InputDecoration(
          counterText: "",
          filled: false,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18.0,
            vertical: 15.0,
          ),
          //floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIconColor: AppColors.primary(context),
          floatingLabelStyle: AppTextStyle(context).medium14(
            color: AppColors.grayBlue,
          ),
          labelStyle: AppTextStyle(context).medium14(
            color: AppColors.grayBlue,
          ),
          hintText: hintText ?? 
              'Ejm. Esta iniciativa que tiene como objetivo lograr mejoras progresivas...',
          hintStyle: AppTextStyle(context).medium14(
            color: AppColors.black,
          ),
          labelText: labelText ?? "Descripción",
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
              width: .5,
              color: AppColors.primary(context),
            ),
          ),
        ));
  }
}
