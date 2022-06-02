import 'package:flutter/material.dart';

/// stretch to a small button via Animation
Widget buildSmallButton(bool isDone) {
  final color = isDone ? Colors.green : Colors.red.shade600;
  return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Center(
        child: isDone
            ? const Icon(Icons.done, size: 52, color: Colors.white)
            : const CircularProgressIndicator(color: Colors.white),
      ));
}

/// Animated loading button for re-use
Widget loadingButton() => OutlinedButton(
      onPressed: () async {
        // setState(() => state = ButtonState.loading);
        // await Future.delayed(const Duration(milliseconds: 2000));
        // setState(() => state = ButtonState.done);
        // await Future.delayed(const Duration(milliseconds: 1000));
        // setState(() => state = ButtonState.init);
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.indigo,
      ),
      child: const FittedBox(
        child: Text(
          'SUBMIT',
          style: TextStyle(
            fontSize: 21,
            color: Colors.white,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
