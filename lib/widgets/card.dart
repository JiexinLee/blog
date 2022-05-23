import 'package:flutter/material.dart';
import 'package:flutter_abnhelper/constants/colors.dart';

Widget card(int index, BuildContext context) => Container(
      height: 120.0,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.pinkColor,
      ),
      child: Center(
        child: Text(
          "Card$index",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
