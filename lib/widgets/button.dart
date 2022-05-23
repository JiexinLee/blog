import 'package:flutter/material.dart';

Widget buildSmallButton(bool isDone) {
  final color = isDone ? Colors.green : Colors.indigo;
  return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Center(
        child: isDone
            ? const Icon(Icons.done, size: 52, color: Colors.white)
            : const CircularProgressIndicator(color: Colors.white),
      ));
}
