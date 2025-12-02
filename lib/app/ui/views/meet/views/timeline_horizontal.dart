import 'package:flutter/material.dart';

class TimelineHorizontal extends StatelessWidget {
  final List<TimelineEvent> events;

  const TimelineHorizontal({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          final isUp = index % 2 == 0; // alternar arriba/abajo

          return Container(
            // color: Colors.red,
            width: 165,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isUp
                    ? Column(
                        children: [
                          Row(
                            children: [
                              _verticalLineFirst(),
                              _eventCard(event),
                            ],
                          ),
                          _horizontalLine(),
                          const SizedBox(height: 50),
                        ],
                      )
                    : Column(
                        children: [
                          const SizedBox(height: 48),
                          _horizontalLine(),
                          Row(
                            children: [
                              _eventCard(event),
                              _verticalLineSecond(),
                            ],
                          ),
                        ],
                      )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _horizontalLine() {
    return Container(
      // width: 40,
      height: 2,
      color: Colors.blue,
    );
  }

  Widget _verticalLineFirst() {
    return Column(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: 2,
          height: 40,
          color: Colors.orange,
        ),
      ],
    );
  }

  Widget _verticalLineSecond() {
    return Column(
      children: [
        Container(
          width: 2,
          height: 40,
          color: Colors.orange,
        ),
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }

  Widget _eventCard(TimelineEvent event) {
    return Column(
      children: [
        Text(
          event.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          event.date,
          style: const TextStyle(color: Colors.grey, fontSize: 11),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

class TimelineEvent {
  final String title;
  final String date;

  TimelineEvent({
    required this.title,
    required this.date,
  });
}
