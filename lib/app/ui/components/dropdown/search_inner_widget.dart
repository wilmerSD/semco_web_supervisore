import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class SearchInnerWidget extends StatelessWidget {
  const SearchInnerWidget(
      {super.key, required this.searchController, required this.hintText});
  final TextEditingController searchController;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextField(
        controller: searchController,
        style:
            AppTextStyle(context).bold13(color: AppColors.textBasic(context)),
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
