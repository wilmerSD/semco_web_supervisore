import 'package:app_tasking/core/helpers/helpers.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomNote extends StatelessWidget {
  final String comment;
  final int typeNote;
  final int? maxLines;
  const CustomNote({
    super.key,
    required this.comment,
    required this.typeNote,
    this.maxLines
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: AppColors.listProyectsColor(context),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowListColor(context),
            blurRadius: 2.0,
            spreadRadius: 0.1,
          )
        ],
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 8.0,
                decoration: BoxDecoration(
                  color: typeNote == 0
                      ? AppColors.commentColor(context)
                      : typeNote == 1
                          ? AppColors.noteColor(context)
                          : typeNote == 2
                              ? AppColors.reportColor(context)
                              : AppColors.primary(context),
                  borderRadius: const BorderRadius.only(
                    topLeft:  Radius.circular(5.0),
                    bottomLeft: Radius.circular(5.0),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
                start: 15.0, top: 8, bottom: 8, end: 8),
            child: Text(
              Helpers.formattedRecords(comment),
              overflow: maxLines == 3 ? TextOverflow.ellipsis : null,
              maxLines: maxLines,
              style: AppTextStyle(context).bold14(
                color: AppColors.textBasic(context),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
