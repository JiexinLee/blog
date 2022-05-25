import 'package:flutter/material.dart';

class NumbersWidget extends StatelessWidget {
  const NumbersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildButton(text: "Projects", value: 3),
        buildDivider(),
        buildButton(text: "Following", value: 10),
        buildDivider(),
        buildButton(text: "Follower", value: 0),
      ],
    );
  }

  Widget buildDivider() => const SizedBox(height: 24, child: VerticalDivider());

  Widget buildButton({required String text, required int value}) =>
      MaterialButton(
        onPressed: () {},
        padding: const EdgeInsets.symmetric(vertical: 4),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$value',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: value == 0 ? Colors.red : Colors.black),
            ),
            const SizedBox(height: 2),
            Text(
              text,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            )
          ],
        ),
      );
}
