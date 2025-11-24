import 'package:app_tasking/app/ui/components/icon_wrapper.dart';
import 'package:app_tasking/app/ui/views/home/widgets/pop_up_order.dart';
import 'package:app_tasking/app/ui/views/home/widgets/pop_up_type_list.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class OptionDirector extends StatelessWidget {
  const OptionDirector({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(
          height: 10.0,
        ),
        Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              children: [
                Row(
                  children: [
                    Text("Proyectos",
                        style: AppTextStyle(context)
                            .bold16(color: AppColors.textBasic(context))),
                    const SizedBox(
                      width: 3.0,
                    ),
                    IconWrapper(
                      child: const Icon(Icons.sort_by_alpha),
                      onTap: () => showCustomPopup(context),
                    )
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    IconWrapper(
                        onTap: () => popUpTypeList(context),
                        child: const Icon(Icons.list_alt))
                  ],
                )
              ],
            )),
        const SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}
