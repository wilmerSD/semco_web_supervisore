import 'package:app_tasking/app/ui/components/input/field_form.dart';
import 'package:app_tasking/app/ui/views/subtask/widgets/file_control.dart';
import 'package:app_tasking/app/ui/views/subtask/widgets/save_cancel_buttons.dart';
import 'package:app_tasking/app/ui/views/task/task_provider.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class NewCommentTask extends StatelessWidget {
  const NewCommentTask({super.key});

@override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    String commentText = '';
    Widget commentInput = FieldForm(
        label: "Comentario",
        maxlines: 2,
        hintText: "Ejm. El proyecto tiene un avance del 50% queda pendiente...",
        textInputType: TextInputType.emailAddress,
        textEditingController: taskProvider.ctrlCommentText);

    return Column(
      spacing: 10.0.h,
      mainAxisSize: MainAxisSize.min,
      children: [
        commentInput,
        Row(
          children: [
            Checkbox(
                activeColor: AppColors.primary(context),
                value: taskProvider.sendEmail,
                onChanged: (_) {
                  taskProvider.checkSendEmail();
                }),
            Text("Notificación de Correo Electrónico",
                style: AppTextStyle(context).bold13(
                  color: AppColors.textBasic(context),
                )),
          ],
        ),
        const FileControl(),
        const SizedBox(),
        SaveCancelButtons(onSave: () async{
          await taskProvider.postProcCreateNote(
            pComeComentario: taskProvider.ctrlCommentText.text,
            pSendEmail: taskProvider.sendEmail,
          );
          taskProvider.ctrlCommentText.clear();
          taskProvider.sendEmail = false;
          if(taskProvider.isCreatingNote == false){
            Navigator.pop(context);
          }
        }),
      ],
    );
  }
}
