import 'package:flutter/material.dart';
import 'package:flutter_abnhelper/constants/colors.dart';

class Find extends StatefulWidget {
  Find({Key? key}) : super(key: key);

  @override
  State<Find> createState() => _FindState();
}

class _FindState extends State<Find> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                focusColor: AppColor.mainThemeColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: AppColor.mainThemeColor)
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
