import 'package:app_tasking/app/ui/components/input/field_form.dart';
import 'package:app_tasking/app/ui/components/icon_wrapper.dart';
import 'package:app_tasking/core/routes/app_routes_name.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key});

  @override
  Widget build(BuildContext context) {
    // final chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary(context),
        title: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => context.push(AppRoutesName.INFOCONTACTO),
          child: Row(
            spacing: 5.0,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 22,
                child: Icon(Icons.person_2_outlined),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Marco Orihuela',
                    style: AppTextStyle(context)
                        .bold15(fontWeight: FontWeight.w800),
                  ),
                  Text('En linea',
                      style: AppTextStyle(context)
                          .bold13(fontWeight: FontWeight.w400)),
                  // Text('últ. vez hoy a la(s) 8:26 am',
                  //     style: AppTextStyle(context)
                  //         .bold13(fontWeight: FontWeight.w400)),
                  // Text('toca para ver info. del contacto',
                  //     style: AppTextStyle(context)
                  //         .bold13(fontWeight: FontWeight.w400))
                ],
              ),
            ],
          ),
        ),
        actions: [
          Row(
            children: [
              IconWrapper(
                  onTap: () {},
                  child: const Icon(
                    Icons.video_call,
                    size: 28.0,
                  )),
              const SizedBox(
                width: 8.0,
              ),
              IconWrapper(
                  onTap: () {}, child: const Icon(Icons.call, size: 28.0)),
              const SizedBox(
                width: 8.0,
              ),
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(child: Container()),
            Row(
              children: [
                const Expanded(
                  child: FieldForm(
                    label: "Mensaje",
                    // maxlines: 1,
                    textInputType: TextInputType.text,
                    // textEditingController: homecontroller.tittleProyect
                  ),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                IconWrapper(
                    onTap: () {},
                    child: Icon(
                      Icons.send,
                      color: AppColors.primary(context),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
