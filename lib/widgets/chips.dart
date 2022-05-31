import 'package:flutter/material.dart';

Widget buildChipsPanel() => Container(
      height: 200,
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      color: Colors.amber,
    );

Widget buildChip() => const Chip(
      label: Text("CHIP"),
      labelPadding: EdgeInsets.all(4),
      backgroundColor: Colors.indigo,
    );
