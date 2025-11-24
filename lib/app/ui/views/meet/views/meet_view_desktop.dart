import 'package:app_tasking/app/ui/components/dropdown/dropdown_select.dart';
import 'package:app_tasking/app/ui/components/dropdown/option_select.dart';
import 'package:app_tasking/app/ui/components/header/header_options_meet.dart';
import 'package:app_tasking/app/ui/components/input/input_gen.dart';
import 'package:app_tasking/app/ui/views/meet/meet_provider.dart';
import 'package:app_tasking/app/ui/views/meet/modeview/list_meets_director.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_style.dart';
import 'package:app_tasking/domain/entities/area.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MeetViewDesktop extends StatelessWidget {
  const MeetViewDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final meetProvider = Provider.of<MeetProvider>(context);
    print('lista meet longitud w ${meetProvider.listMeet.length}');

    return Column(
      children: [
        const HeaderOptionsMeet(),
        const SizedBox(height: 10.0),
        _customTextsOption(context),
        const SizedBox(height: 10.0),
        /* meetProvider.listMeets.isEmpty
                      ? const Text("No hay reuniones")
                      :  */
        ListMeetsDirector(),
      ],
    );
  }
}

Widget _customTextsOption(BuildContext context) {
  return Container(
    // padding: const EdgeInsets.symmetric(/* horizontal: 20.0, */ vertical: 15.0),
    decoration: BoxDecoration(
      // color: AppColors.skyblue,
      borderRadius: BorderRadius.circular(5.0),
    ),
    child: Row(
      spacing: 5.0,
      children: [
        customTextFilter(context, 'Hoy'),
        customTextFilter(context, 'Próximos'),
        customTextFilter(context, 'Semanal'),
        customTextFilter(context, 'Anteriores'),
        customTextFilter(context, 'Mensual'),
        Expanded(
          child: Row(
            spacing: 20.0,
            children: [
              Expanded(child: searchByName()),
              Expanded(child: searchByMonth()),
              Expanded(child: searchByProject()),
              Expanded(child: searchByCliente()),
            ],
          ),
        )
      ],
    ),
  );
}

Widget customTextFilter(BuildContext context, String text) {
  return TextButton(
    onPressed: () {
      switch (text) {
        case 'Hoy':
          context.read<MeetProvider>().getMeetings();
        case 'Próximos':
          context.read<MeetProvider>().getMeetings(datefilter: 1);
        case 'Anteriores':
          context.read<MeetProvider>().getMeetings(datefilter: 2);
        case 'Semanal':
          context.read<MeetProvider>().getMeetings(datefilter: 3);
        case 'Mensual':
          context.read<MeetProvider>().getMeetings(datefilter: 4);
      }
    },
    child: Text(
      text,
      style: AppTextStyle(context).bold14(color: AppColors.secondary(context)),
    ),
  );
}

Widget searchByName() {
  return InputGen(
    labelText: 'Buscar por nombre',
    hintText: 'Reunión semanal de revisión de avances',
    onChanged: (String) {},
  );
}

Widget searchByMonth() {
  return InputGen(
    labelText: 'Buscar por mes',
    hintText: 'Enero',
    onChanged: (String) {},
  );
}

Widget searchByProject() {
  return InputGen(
    labelText: 'Buscar por proyecto',
    hintText: 'Sistema Aconcex',
    onChanged: (String) {},
  );
}

Widget searchByCliente() {
  return Consumer<MeetProvider>(builder: (context, meetProvider, _) {
    return DropdownSelect(
      label: 'Buscar por espacio de trabajo:',
      // helperText: 'Buscar por espacio de traba jo:',
      // icon: Bootstrap.star,
      value: meetProvider.listClient.firstWhere(
        (element) => element.clienteId == meetProvider.clientMeet.clienteId,
        orElse: () => meetProvider.listClient.first, // valor por defecto
      ),
      items: meetProvider.listClient.map((element) {
        return DropdownMenuItem(
          value: element,
          child: OptionSelect(
            nameOption:
                element.clienteNombre ?? element.clienteRazonSocial ?? '',
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        meetProvider.clientMeet = newValue as Area;
      },
    );
  });
}
