import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_abnhelper/constants/colors.dart';
import 'package:flutter_abnhelper/pages/welcome/welcome.dart';
import 'package:flutter_abnhelper/widgets/card.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool("showHome", false);
              Get.offAll(()=>Welcome());
            },
            icon: const Icon(Icons.exit_to_app_rounded),
            color: Colors.white,
          ),
        ],
        backgroundColor: AppColor.accentColor,
        title: Text(
          'jiexin',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        child: ListView.separated(
          itemCount: 10,
          itemBuilder: (context, index) => card(index, context),
          separatorBuilder: (BuildContext context, int index) => const SizedBox(
            height: 20,
          ),
        ),
      ),
    );
  }
}
