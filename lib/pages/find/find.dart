import 'package:flutter/material.dart';
import 'package:flutter_abnhelper/constants/colors.dart';
import 'package:flutter_abnhelper/pages/find/grids.dart';

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
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 10),
        child: AppBar(),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintMaxLines: 1,
                hintText: "Search Blogs",
                prefixIcon: const Icon(Icons.search_rounded),
                hoverColor: AppColor.mainThemeColor,
                focusColor: AppColor.mainThemeColor,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        const BorderSide(color: AppColor.mainThemeColor)),
              ),
            ),
          ),
          BasicGridView(),
        ],
      ),
    );
  }
}
