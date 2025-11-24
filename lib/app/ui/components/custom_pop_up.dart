import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomPopup extends StatelessWidget {
  final String title;
  final List<String> options;
  final List<VoidCallback> actions;
  final double borderRadius; // Nuevo parámetro para ajustar el radio
  final TextStyle? titleStyle; // Estilo del título
  final TextStyle? optionStyle; // Estilo de las opciones

  const CustomPopup({
    super.key,
    required this.title,
    required this.options,
    required this.actions,
    this.borderRadius = 8.0, // Valor predeterminado
    this.titleStyle,
    this.optionStyle,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      title: Text(title, style: titleStyle ?? AppTextStyle(context).bold26(
                                          color: AppColors.textBasic(context)),),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(options.length, (index) {
          return ListTile(
            title: Text(options[index], style: optionStyle ??  AppTextStyle(context).bold16(
                                          color: AppColors.textBasic(context), fontWeight: FontWeight.normal),),
            onTap: () {
              actions[index]();
              // Navigator.pop(context); // Cierra el pop-up después de seleccionar
            },
          );
        }),
      ),
    );
  }
}
