import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class InfoContacto extends StatelessWidget {
const InfoContacto({ super.key });

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary(context),
        title: Text("Info del contacto", style: AppTextStyle(context).bold16(),),),
      body: Column(
        children: [
          SizedBox(height: 20.0),
          Center(
            child: CircleAvatar(
              radius: 45,
              child: Icon(Icons.person_2_rounded, size: 50,),
            ),
          ),
          SizedBox(height: 12.0),
          Text("Marco Orihuela", style: AppTextStyle(context).bold24(color: AppColors.textBasic(context))),
          
        ],
      ),
    );
  }
}