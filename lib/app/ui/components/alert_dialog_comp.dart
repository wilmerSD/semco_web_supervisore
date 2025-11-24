import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AlertDialogComp extends StatelessWidget {
  final String headerTitle;
  final Widget widgetContent;
  final Widget? date;

  const AlertDialogComp({
    super.key,
    required this.headerTitle,
    required this.widgetContent,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Personaliza el radio
      ),
     /*  title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            headerTitle,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          // IconButton(
          //   icon: const Icon(Bootstrap.x_circle),
          //   onPressed: () {
          //     Navigator.of(context).pop();  // Cierra el diálogo
          //   },
          // ),
        ],
      ), */
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      content: widgetContent,
      actions: [
        date ?? 
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Entendido',
              style: TextStyle(
                  color: AppColors.blueDark(context),
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0)),
        ),
      ],
    );
  }
}
