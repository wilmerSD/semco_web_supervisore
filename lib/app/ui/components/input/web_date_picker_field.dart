import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vph_web_date_picker/vph_web_date_picker.dart';

import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_decorators.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';

class WebDatePickerField extends StatefulWidget {
  final bool enableRange; // true = rango de fechas, false = una fecha
  final String? helperText;
  final String? label;
  final IconData? icon;
  final bool isMandatory;
  final TextEditingController controller;
  final void Function(DateTimeRange)? onDateSelected; // callback opcional

  const WebDatePickerField({
    super.key,
    required this.controller,
    this.enableRange = false,
    this.helperText,
    this.icon,
    this.isMandatory = false,
    this.onDateSelected,
    this.label,
  });

  @override
  State<WebDatePickerField> createState() => _WebDatePickerFieldState();
}

class _WebDatePickerFieldState extends State<WebDatePickerField> {
  final GlobalKey _keyField = GlobalKey();

  DateTimeRange _range = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  );

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      widget.helperText != null
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  spacing: 8.0,
                  children: [
                    if (widget.icon != null)
                      Row(
                        children: [
                          Icon(widget.icon, size: 15.0),
                          const SizedBox(width: 3.0),
                        ],
                      ),
                    Text(widget.helperText!,
                        style: AppTextStyle(context)
                            .bold13(color: AppColors.textBasic(context))),
                    if (widget.isMandatory) const Text('*'),
                  ],
                ),
                const SizedBox(width: 10.0),
              ],
            )
          : const SizedBox(),
      Expanded(
        child: TextField(
          style: AppTextStyle(context)
                .bold13(color: AppColors.textBasic(context)),
          key: _keyField,
          controller: widget.controller,
          readOnly: true,
          decoration: AppDecorators.inputDecorationGen(
              context, 'Fecha', widget.label ?? '', null),
          onTap: () async {
            final result = await showWebDatePicker(
              backgroundColor: AppColors.backgroundColor(context),
              context: _keyField.currentContext!,
              firstDate: DateTime.now().subtract(const Duration(days: 7)),
              lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
              enableRangeSelection: widget.enableRange,
              weekendDaysColor: Colors.red,
              asDialog: false,
              width: 360,
              initialDate: DateTime.now(),
            );

            if (result != null) {
              setState(() {
                _range = result;
                final dateFormatted =
                    DateFormat('dd/MM/yyyy').format(result.start);
                widget.controller.text = dateFormatted;

                // Llamar callback si está definido
                widget.onDateSelected?.call(result);
              });
            }
          },
        ),
      ),
    ]);
  }
}
