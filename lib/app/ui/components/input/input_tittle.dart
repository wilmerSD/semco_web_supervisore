import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_decorators.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTittle extends StatelessWidget {
  const InputTittle({
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
    return Row(
      children: [
        helperText != null
            ? Row(
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
                  isMandatory
                      ? const Text(
                          '*',
                          style: TextStyle(color: Colors.red),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    width: 4.0,
                  ),
                ],
              )
            : const SizedBox(),
        Expanded(
          child: TextFormField(
              style: AppTextStyle(context)
                  .bold13(color: AppColors.textBasic(context)),
              inputFormatters: inputFormats,
              onChanged: (value) => onChanged(value),
              controller: textEditingController,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.multiline,
              maxLines: 1,
              minLines: 1,
              decoration: AppDecorators.inputDecorationGen(
                  context, hintText, labelText, suffixIcon)),
        ),
      ],
    );
  }
}

/*   @override
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
            inputFormatters: inputFormats,
            onChanged: (value) => onChanged(value),
            // controller: textEditingController,
            textAlignVertical: TextAlignVertical.center,
            keyboardType: TextInputType.multiline,
            maxLines: 1,
            minLines: 1,
            decoration: AppDecorators.inputDecorationGen(
                context, hintText, labelText, suffixIcon)),
      ],
    );
  }
}
 */
