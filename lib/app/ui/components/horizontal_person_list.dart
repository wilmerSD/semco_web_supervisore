import 'package:animate_do/animate_do.dart';
import 'package:app_tasking/app/ui/views/meet/meet_provider.dart';
import 'package:app_tasking/core/helpers/helpers.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class HorizontalPersonList extends StatelessWidget {
/*   final List<Person> people; */
  const HorizontalPersonList({super.key,/*  required this.people */});

  @override
  Widget build(BuildContext context) {
    final meetProvider = Provider.of<MeetProvider>(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: 45, //meetProvider.participantsDetail.isEmpty ? 0.0 : 85,
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
            itemCount: meetProvider.participantsDetail.length,
            itemBuilder: (context, index) {
              final dataPerson = meetProvider.participantsDetail[index];
              return Padding(
                padding: meetProvider.participantsDetail.isEmpty
                    ? const EdgeInsets.all(0)
                    : const EdgeInsets.only(left: 8.0),
                child: FadeIn(
                  delay: const Duration(milliseconds: 250),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       CircleAvatar(
                        radius: 15.0,
                        backgroundColor: Helpers.getColorInvitationMeet(dataPerson.state), 
                         child: const CircleAvatar(
                                radius: 12.5,
                                child: Icon(Bootstrap.person, size: 12.0),
                              ),
                       ),
                      // Stack(
                      //   children: [
                      //     SizedBox(
                      //       width: 45,
                      //       height: meetProvider.participantsDetail.isEmpty
                      //           ? 0.0
                      //           : 45.0,
                      //     ),
                      //     const Positioned(
                      //       bottom: 0.0,
                      //       child: CircleAvatar(
                      //         radius: 15.0,
                      //         child: Icon(Bootstrap.person, size: 10.0),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      Text(
                        maxLines: 1,
                        Helpers.getInitial(dataPerson.fullName ?? 'Sin nombre'),
                        // dataPerson.fullName ?? 'Sin nombre',
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
