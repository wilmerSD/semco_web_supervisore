import 'package:app_tasking/app/ui/views/subtask/subtask_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeaderSubTask extends StatefulWidget {
  const HeaderSubTask({super.key});

  @override
  _HeaderSubTaskState createState() => _HeaderSubTaskState();
}

class _HeaderSubTaskState extends State<HeaderSubTask>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double subTaskProgress = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final subtaskController =
          Provider.of<SubtaskProvider>(context, listen: false);
      double progressFromDB = (subtaskController.subTaskObject.ordenAvance ?? 0) / 100;

      setState(() {
        subTaskProgress = progressFromDB;
        _animation = Tween<double>(begin: 0, end: subTaskProgress).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        );

        _controller.forward(); // Iniciar la animación después de configurar
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Progreso Animado")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: subTaskProgress == 0
              ? const CircularProgressIndicator() // Indicador de carga mientras se obtiene el valor
              : AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return LinearProgressIndicator(
                      value: _animation.value,
                      minHeight: 10,
                      backgroundColor: Colors.grey[300],
                      color: Colors.blue,
                    );
                  },
                ),
        ),
      ),
    );
  }
}
