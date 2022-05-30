import 'package:flutter/material.dart';
import 'package:flutter_abnhelper/constants/border.dart';
import 'package:flutter_abnhelper/constants/colors.dart';
import 'package:flutter_abnhelper/pages/home/blog.dart';
import 'package:get/get.dart';

Widget card(
  int index,
  BuildContext context,
  List<String> titleList,
  List<String> imageUrls,
  List<String> linksList,
) =>
    InkWell(
      onTap: () {
        Get.to(
          () => BlogDetail(),
          arguments: linksList[index],
        );
      },
      child: Container(
        height: 200.0,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppBorder.kBorderRadius),
            gradient: const LinearGradient(colors: [
              Colors.white,
              Colors.indigo,
              Colors.indigo,
              Colors.indigo
            ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
        child: Center(
          child: Column(
            children: [
              Text(
                titleList[index],
                maxLines: 2,
                overflow: TextOverflow.fade,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(child: Container()),
              SizedBox(
                height: 120,
                width: double.infinity,
                child: Image.network(
                  imageUrls[index],
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
        ),
      ),
    );
