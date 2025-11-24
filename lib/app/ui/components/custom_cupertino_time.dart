import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCupertinoTime {
  static Future<void> showCupertinoModal(
    BuildContext context, {
    required String title,
    required ValueChanged<DateTime> onChanged,
    required ValueChanged<DateTime> onPressed,
    required bool use24hFormat,
  }) async {
    DateTime selectedDate =
        DateTime.now(); 

    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 320.0.h,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12.0),
                child: Text(title,
                    style: AppTextStyle(context).bold15(
                color: AppColors.textBasic(context),
                        ),)
              ),
              SizedBox(
                height: 190,
                child: CupertinoDatePicker(
                  initialDateTime: DateTime.now(),
                  mode: CupertinoDatePickerMode.time,
                  use24hFormat: use24hFormat, 
                  onDateTimeChanged: (DateTime newDate) {
                    selectedDate = newDate;
                    onChanged(
                        newDate); // Aquí llamamos la función correctamente
                  },
                ),
              ),
              CupertinoButton(
                child: Text('Hecho', style: AppTextStyle(context).bold15(
                color: AppColors.primary(context),
                        ),),
                onPressed: () {
                  Navigator.of(context).pop();
                  onPressed(
                      selectedDate); // Llamamos la función y pasamos la fecha como String
                },
              ),
            ],
          ),
        );
      },
    );
  }
}