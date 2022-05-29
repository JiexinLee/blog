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
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              centerTitle: true,
              title: const Text(
                "LEE'S BLOG",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold),
              ),
              expandedHeight: 150,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  "assets/images/home_cover.png",
                  fit: BoxFit.cover,
                ),
              ),
              backgroundColor: AppColor.mainThemeColor,
              floating: true,
              snap: true,
              pinned: true,
            ),
          ];
        },
        body: Container(
          margin: const EdgeInsets.only(top: 5),
          child: ListView.separated(
            itemCount: 20,
            itemBuilder: (context, index) => card(index, context),
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
              height: 20,
            ),
          ),
        ),
      ),
    );
  }
}
