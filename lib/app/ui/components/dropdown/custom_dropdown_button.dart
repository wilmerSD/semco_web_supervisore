import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton({
    super.key,
    required this.initialValue,
    required this.items,
    required this.onChanged
  });
  final String initialValue;
  final List<String> items;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      value: initialValue,
      icon: Row(
        children: [
          // icon: Icon(Icons.arrow_drop_down,
          //         color: AppColors.grayBlue, size: 28),
          //     openMenuIcon: Icon(Icons.arrow_drop_up,
          //         color: AppColors.primaryConst,
          //         size: 28), // cuando está abierto
          Icon(Icons.arrow_drop_down,
                  color: AppColors.grayBlue, size: 28),
          const SizedBox(
            width: 12.0,
          ),
        ],
      ),
      iconSize: 23,
      elevation: 10,
      style: TextStyle(color: AppColors.textBasic(context)),
      underline: Container(
        height: 1,
        color: AppColors.underlineColorGen,
      ),
      onChanged: (String? value) {
        onChanged(value ?? '');
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
