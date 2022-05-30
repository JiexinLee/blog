import 'package:flutter/material.dart';

Widget buildWelcomePage({
  required String title,
  required Color color,
  required String urlImage,
  required String subtitle,
}) =>
    Container(
      padding: const EdgeInsets.all(10.0),
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            urlImage,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.indigo,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              subtitle,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
