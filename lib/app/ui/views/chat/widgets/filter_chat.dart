import 'package:app_tasking/app/ui/components/custom_filter_chat.dart';
import 'package:flutter/material.dart';

class FilterChat extends StatelessWidget {
  const FilterChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(5),
      height: 45,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          CustomFilterChat(
            optionText: "Todos",
            option: 1,
            lastOption: 1,
          ),
          SizedBox(
            width: 15.0,
          ),
          CustomFilterChat(
            optionText: "Personas",
            option: 2,
            lastOption: 1,
          ),
          SizedBox(
            width: 15.0,
          ),
          CustomFilterChat(
            optionText: "Grupos",
            option: 3,
            lastOption: 1,
          ),
          SizedBox(
            width: 15.0,
          ),
          CustomFilterChat(
            optionText: "No leidos",
            option: 4,
            lastOption: 1,
          ),
          SizedBox(
            width: 15.0,
          ),
          CustomFilterChat(
            optionText: "Proyectos",
            option: 5,
            lastOption: 1,
          ),
        ],
      ),
    );
  }
}
