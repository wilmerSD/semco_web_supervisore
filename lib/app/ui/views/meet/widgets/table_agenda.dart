import 'package:app_tasking/app/ui/components/custom_icon_button.dart';
import 'package:app_tasking/app/ui/views/meet/meet_provider.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/domain/entities/agenda.dart';
import 'package:app_tasking/infrastructure/models/option__select_model.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TableAgenda extends StatelessWidget {
  final List<Agenda> listAgenda;

  const TableAgenda({super.key, required this.listAgenda});

  @override
  Widget build(BuildContext context) {
    final seedDerivedColor = Theme.of(context).colorScheme;
    return DataTable2(
      // decoration: BoxDecoration(
      //   color: seedDerivedColor.surface,
      // ),//background
      dataRowColor: WidgetStateProperty.all(AppColors.backgroundColor(context)),
      dividerThickness: 0, // grosor de la línea divisoria
      // dividerColor: Colors.blueGrey, // color de las divisiones (solo DataTable2)
      dataRowHeight: 50,
      headingRowDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 300,
      headingRowHeight: 56,
      headingRowColor: WidgetStateProperty.all(AppColors.secondaryConst),
      headingTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      border: TableBorder(
        horizontalInside: BorderSide(
          width: 7.0,
          color: seedDerivedColor.surface,
        ), // const Color.fromARGB(255, 216, 4, 4)),
      ),
      columns: const [
        DataColumn2(
            label: Text(
              'Nro',
            ),
            size: ColumnSize.S),
        DataColumn2(label: Text('Tema de agenda'), size: ColumnSize.L),
        DataColumn2(label: Text('Tipo'), size: ColumnSize.S),
        DataColumn2(label: Text('Asociado a'), size: ColumnSize.S),
        DataColumn2(label: Text('Responsable'), size: ColumnSize.S),
        DataColumn2(label: SizedBox(), size: ColumnSize.S),
      ],

      // 🔥 Aquí se genera dinámicamente
      rows: List.generate(listAgenda.length, (index) {
        final item = listAgenda[index];
        return DataRow(
          cells: [
            DataCell(_customRow(context, "${index + 1}".padLeft(2, '0'))),
            DataCell(Text(item.tittle ?? "-")),
            DataCell(Text(item.type ?? "-")),
            DataCell(Text(item.associatedTypeName ?? "-")),
            DataCell(Text(item.responsibleNames ?? "-")),
            DataCell(Row(
              spacing: 10.0,
              children: [
                CustomIconButton(
                    iconData: Icons.edit,
                    onPressed: () {
                      context.read<MeetProvider>().passValuesToUpdate(item);
                    }),
                CustomIconButton(
                    iconData: Icons.delete,
                    onPressed: () {
                      context.read<MeetProvider>().removeRowAgenda(item);
                    }),
              ],
            )),
          ],
        );
      }),
    );
  }
}

Widget _customRow(BuildContext context, String text) {
  return Text(text);
}
