import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class DropdownButtonCustom<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final String Function(T) getLabel; // Función para extraer el texto a mostrar
  final String? helperText;
  final bool isMandatory;
  final IconData? icon;

  const DropdownButtonCustom({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.getLabel,
    this.helperText,
    this.isMandatory = false,
    this.icon,
  });

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
        Container(
          height: 48.0,
          decoration: BoxDecoration(
            color: AppColors.backgroundColor(context),
            border: Border.all(color: AppColors.backgroundColor(context), width: 1.0),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: DropdownButton<T>(
            padding: const EdgeInsets.only(left: 10.0),
            alignment: AlignmentDirectional.bottomEnd,
            // itemHeight: 100,
            isDense: true,
            menuWidth: 180,
            // menuMaxHeight: 350.0,
            borderRadius: BorderRadius.circular(4.0),
            isExpanded: true,
            // dropdownColor:
            //     Colors.red, //const Color.fromARGB(255, 247, 247, 247),
            value: value,
            icon: const Row(
              children: [
                Icon(Icons.arrow_drop_down,
                    color: AppColors.grayBlue, size: 28),
                SizedBox(
                  width: 12.0,
                ),
              ],
            ),
            iconSize: 23.0,
            elevation: 10,
            style: AppTextStyle(context)
                .bold13(color: AppColors.textBasic(context)),
            underline: Container(
              height: 0,
              color: AppColors.underlineColorGen,
            ),
            onChanged: onChanged,
            items: items.map<DropdownMenuItem<T>>((T item) {
              return DropdownMenuItem<T>(
                alignment : AlignmentDirectional.centerStart,
                value: item,
                child: Text(
                  getLabel(item),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ), // Extrae el texto dinámicamente
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
