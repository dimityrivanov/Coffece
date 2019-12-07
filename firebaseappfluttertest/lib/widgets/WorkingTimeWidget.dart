import 'package:flutter/material.dart';

class WorkingTimeWidget extends StatelessWidget {
  final bool isOpened;
  final String opened = "Отворено";
  final String closed = "Затворено";

  WorkingTimeWidget({this.isOpened});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          isOpened ? opened : closed,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: isOpened ? Colors.green : Colors.red,
      ),
    );
  }
}
