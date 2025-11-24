import 'package:animate_do/animate_do.dart';
import 'package:app_tasking/app/ui/components/icon_wrapper.dart';
import 'package:app_tasking/app/ui/views/meet/meet_provider.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class ListPersonSelected extends StatelessWidget {
  const ListPersonSelected({super.key});

  @override
  Widget build(BuildContext context) {
    final meetProvider = Provider.of<MeetProvider>(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height:  60,//meetProvider.personSelected.isEmpty ? 0.0 : 85,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          // color: Colors.red
          ),
      child: RefreshIndicator(
        onRefresh: () async {},
        child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            controller: meetProvider.scrollControllerListPersonSelected,
            itemCount: meetProvider.personSelected.length,
            itemBuilder: (context, index) {
              final dataPerson = meetProvider.personSelected[index];
              return Padding(
                padding: meetProvider.personSelected.isEmpty
                    ? const EdgeInsets.all(0)
                    : const EdgeInsets.only(left: 10.0),
                child: FadeIn(
                  delay: const Duration(milliseconds: 250),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 45,
                            height: meetProvider.personSelected.isEmpty
                                ? 0.0
                                : 45.0,
                          ),
                          const Positioned(
                            bottom: 0.0,
                            child: CircleAvatar(
                              radius: 20.0,
                              child: Icon(Bootstrap.person, size: 15.0),
                            ),
                          ),
                          Positioned(
                              right: 0.0,
                              top: 0.0,
                              child: IconWrapper(
                                radius: meetProvider.personSelected.isEmpty
                                    ? 0.0
                                    : 12,
                                onTap: () {
                                  meetProvider
                                      .removeOrAddPersonSelected(dataPerson);
                                  meetProvider.scrollToBottom();
                                },
                                child: CircleAvatar(
                                  radius: meetProvider.personSelected.isEmpty
                                      ? 0.0
                                      : 9,
                                  backgroundColor:
                                      const Color.fromRGBO(154, 154, 154, 1),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: meetProvider.personSelected.isEmpty
                                        ? 0.0
                                        : 8.0,
                                  ),
                                ),
                              ))
                        ],
                      ),
                      Text(
                        maxLines: 1,
                        dataPerson.personalNombres ?? 'Sin nombre',
                        style: AppTextStyle(context).bold10(
                          fontWeight: FontWeight.w300,
                          color: AppColors.textBasic(context),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
