import 'package:flutter/material.dart';
import 'package:flutter_abnhelper/constants/colors.dart';
import 'package:flutter_abnhelper/widgets/button.dart';
import 'package:get/get.dart';

class Post extends StatefulWidget {
  Post({Key? key}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

enum ButtonState { init, loading, done }

class _PostState extends State<Post> {
  ButtonState state = ButtonState.init;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    bool isAnimated = false;
    final isStretched = isAnimated || state == ButtonState.init;
    final isDone = state == ButtonState.done;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.accentColor,
        title: const Text(
          "Post New Article",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: 80,
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(32),
            child: AnimatedContainer(
              width: state == ButtonState.init ? width : 60,
              height: 60,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
              onEnd: () => setState(() => isAnimated = !isAnimated),
              child: isStretched ? loadingButton() : buildSmallButton(isDone),
            ),
          )
        ],
      ),
    );
  }

  Widget loadingButton() => OutlinedButton(
        onPressed: () async {
          setState(() => state = ButtonState.loading);
          await Future.delayed(const Duration(milliseconds: 2500));
          setState(() => state = ButtonState.done);
          await Future.delayed(const Duration(milliseconds: 2500));
          setState(() => state = ButtonState.init);
        },
        style: OutlinedButton.styleFrom(
          shape: const StadiumBorder(),
          side: const BorderSide(
            width: 2,
            color: Colors.indigo,
          ),
        ),
        child: const FittedBox(
          child: Text(
            'SUBMIT',
            style: TextStyle(
              fontSize: 21,
              color: Colors.indigo,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
}
