import 'package:app_tasking/app/ui/components/btn/btn_cancel_second.dart';
import 'package:app_tasking/app/ui/components/btn/btn_save_second.dart';
import 'package:app_tasking/app/ui/views/subtask/subtask_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SaveCancelButtons extends StatelessWidget {
  final VoidCallback onSave;
  const SaveCancelButtons({
    super.key,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final subtaskProvider = Provider.of<SubtaskProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            width: 150.0.w,
            child: BtnSaveSecond(
                loading: subtaskProvider.isCreatingNote,
                text: subtaskProvider.isCreatingNote ? 'Enviando' : 'Guardar',
                showBoxShadow: false,
                onTap: onSave,
                )),
        SizedBox(
            width: 150.0.w,
            child: BtnCancelSecond(
              text: 'Cancelar',
              onTap: () => Navigator.pop(context),
            ))
      ],
    );
    /*  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: onSave,
          child: Container(
            height: 43.0.h,
            width: 150,
            child: Center(
                child: Text("Guardar",
                    style: AppTextStyle(context).bold14(
                        color: Colors.white, fontWeight: FontWeight.w600))),
            decoration: BoxDecoration(
                color: AppColors.primary(context),
                borderRadius: BorderRadius.circular(8.0.r)),
          ),
        ),
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            height: 43.0.h,
            width: 150.0.w,
            child: Center(
                child: Text("Cancelar",
                    style: AppTextStyle(context).bold14(
                        color: AppColors.primary(context),
                        fontWeight: FontWeight.w600))),
            decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(8.0.r),
                border: Border.all(
                  color: AppColors.primary(context),
                )),
          ),
        ),
      ],
    ); */
  }
}
