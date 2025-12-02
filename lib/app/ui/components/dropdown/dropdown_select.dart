import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_decorators.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropdownSelect<T> extends StatelessWidget {
  const DropdownSelect({
    super.key,
    this.label,
    this.hint,
    this.items,
    this.onChanged,
    this.validator,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.onTap,
    this.isHint = false,
    this.value,
    this.isActive = true,
    this.autoValidate,
    this.height,
    this.selectedItemBuilder,
    this.hintText,
    this.isPadLeft,
    this.helperText,
    this.isMandatory = false,
    this.icon,
    this.hintTextSearch,
    this.dropdownSearchData,
    this.onMenuStateChange,
  });
  final String? label;
  final String? hint;
  final void Function(T?)? onChanged;
  final List<DropdownMenuItem<T>>? items;
  final String? Function(T?)? validator;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final Function()? onTap;
  final bool isHint;
  final T? value;
  final bool isActive;
  final double? height;
  final String? hintText;
  final double? isPadLeft;
  final AutovalidateMode? autoValidate;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;
  final String? helperText;
  final bool isMandatory;
  final IconData? icon;
  final String? hintTextSearch;
  final DropdownSearchData<T>? dropdownSearchData;
  final void Function(bool)? onMenuStateChange;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        helperText != null
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    spacing: 8.0,
                    children: [
                      icon != null
                          ? Row(
                              children: [
                                Icon(icon, size: 15.0),
                                const SizedBox(
                                  width: 3.0,
                                )
                              ],
                            )
                          : const SizedBox(),
                      Text(helperText!,
                          style: AppTextStyle(context)
                              .bold13(color: AppColors.textBasic(context))),
                      isMandatory ? const Text('*') : const SizedBox(),
                    ],
                  ),
                  const SizedBox(width: 10.0),
                ],
              )
            : const SizedBox(),
        Expanded(
          child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField2<T>(
              dropdownSearchData: dropdownSearchData,
              onMenuStateChange: onMenuStateChange,
              iconStyleData: const IconStyleData(
                icon: Icon(Icons.arrow_drop_down,
                    color: AppColors.grayBlue, size: 20),
                openMenuIcon: Icon(Icons.arrow_drop_up,
                    color: AppColors.primaryConst,
                    size: 20), // cuando está abierto
              ),
              value: value,
              autofocus: false,
              isExpanded: true,
              selectedItemBuilder: selectedItemBuilder,
              decoration: AppDecorators.inputDecorationComboBox(
                  context, hintText ?? "", label ?? '', null, isMandatory),
              hint: Text(
                hint ?? "Seleccione",
                style: TextStyle(
                    fontSize: 9,
                    color: isActive
                        ? AppColors.textBasic(context)
                        : AppColors.textBasic(context)),
                overflow: TextOverflow.ellipsis,
              ),

              items: items,
              validator: validator,
              autovalidateMode:
                  autoValidate ?? AutovalidateMode.onUserInteraction,
              onChanged: onChanged,
              dropdownStyleData: DropdownStyleData(
                maxHeight: height ?? 300.0,
                useSafeArea: false,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: AppColors.backgroundColor(context),
                ),
                offset: const Offset(0, 20),
                scrollbarTheme: const ScrollbarThemeData(
                  radius: Radius.circular(40),
                  // thickness: WidgetStateProperty.all<double>(6),
                  // thumbVisibility: WidgetStateProperty.all<bool>(true),
                ),
              ),

              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 0),
                width: double.infinity,
              ),

              menuItemStyleData: MenuItemStyleData(
                height: 45,
                padding: EdgeInsets.symmetric(
                    horizontal: isPadLeft ?? 10.0, vertical: 5),
              ),

              // onTap: onTap
            ),
          ),
        ),
      ],
    );
  }
}


/* class DropdownSelect extends StatelessWidget {
  const DropdownSelect({
    super.key,
    this.label,
    this.hint,
    this.items,
    this.onChanged,
    this.validator,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.onTap,
    this.isHint = false,
    this.value,
    this.isActive = true,
    this.autoValidate,
    this.height,
    this.selectedItemBuilder,
    this.hintText,
    this.isPadLeft,
    this.helperText,
    this.isMandatory = false,
    this.icon,
  });
  final String? label;
  final String? hint;
  final void Function(Object?)? onChanged;
  final List<DropdownMenuItem<Object>>? items;
  final String? Function(Object?)? validator;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final Function()? onTap;
  final bool isHint;
  final Object? value;
  final bool isActive;
  final double? height;
  final String? hintText;
  final double? isPadLeft;
  final AutovalidateMode? autoValidate;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;
  final String? helperText;
  final bool isMandatory;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        helperText != null
            ? Column(
                children: [
                  Row(
                    children: [
                      icon != null ? Row(
                        children: [
                          Icon(icon, size: 12.0),
                          const SizedBox(width: 3.0,)
                        ],
                      ) : const SizedBox(),
                      Text(helperText!),
                      isMandatory ? const Text('*') : const SizedBox(),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                ],
              )
            : const SizedBox(),
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField2(
            // dropdownSearchData: DropdownSearchData(
            // // searchController: searchController,
            // searchInnerWidgetHeight: 50,
            // searchInnerWidget: Padding(
            //   padding: const EdgeInsets.all(8),
            //   child: TextField(
            //     // controller: searchController,
            //     decoration: InputDecoration(
            //       hintText: 'Buscar participante...',
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //       isDense: true,
            //     ),
            //   ),
            // ),
            iconStyleData: const IconStyleData(
              icon: Icon(Icons.arrow_drop_down,
                  color: AppColors.grayBlue, size: 28),
              openMenuIcon: Icon(Icons.arrow_drop_up,
                  color: AppColors.primaryConst,
                  size: 28), // cuando está abierto
            ),
            value: value,
            autofocus: false,
            isExpanded: true,
            selectedItemBuilder: selectedItemBuilder,
            hint: Text(hint ?? "Seleccione",
                style: TextStyle(
                    fontSize: 14,
                    color: isActive ? AppColors.grayBlue : AppColors.black)),
            decoration: InputDecoration(
                hintText: hintText,
                border: const OutlineInputBorder(
                    // borderSide: BorderSide.none,
                    // borderRadius: BorderRadius.circular(kRadiusSmall),
                    ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColors.primaryConst, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14.0, vertical: 14.0),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                label: Text(label ?? "",
                    style: const TextStyle(
                        fontSize: 14, color: AppColors.grayBlue)),
                enabled: true,
                filled: false,
                isDense: true),
            items: items,
            validator: validator,
            autovalidateMode:
                autoValidate ?? AutovalidateMode.onUserInteraction,
            onChanged: onChanged,
            dropdownStyleData: DropdownStyleData(
              maxHeight: height ?? 200.0,
              useSafeArea: false,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.white,
              ),
              offset: const Offset(0, 20),
              scrollbarTheme: const ScrollbarThemeData(
                radius: Radius.circular(40),
                // thickness: WidgetStateProperty.all<double>(6),
                // thumbVisibility: WidgetStateProperty.all<bool>(true),
              ),
            ),
            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.symmetric(horizontal: 0),
              width: double.infinity,
              /* decoration: BoxDecoration(
                color: Color.fromRGBO(215, 214, 214, 100),
              ), */
            ),

            menuItemStyleData: MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.only(left: isPadLeft ?? 14.0, right: 0),
            ),
            // onTap: onTap
          ),
        ),
      ],
    );
  }
}
 */