import 'package:flutter/material.dart';
import 'package:flutter_abnhelper/constants/colors.dart';
import 'package:flutter_abnhelper/constants/text.dart';
import 'package:flutter_abnhelper/pages/me/numbers.dart';
import 'package:flutter_abnhelper/pages/welcome/welcome.dart';
import 'package:flutter_abnhelper/widgets/button.dart';
import 'package:flutter_abnhelper/widgets/chips.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Me extends StatefulWidget {
  Me({Key? key}) : super(key: key);

  @override
  State<Me> createState() => _MeState();
}

enum ButtonState { init, loading, done }

/// button press status

class _MeState extends State<Me> {
  ButtonState state = ButtonState.init;
  double coverHeight = 280.0;
  double profileHeight = 144.0;

  @override
  Widget build(BuildContext context) {
    // device width
    final width = MediaQuery.of(context).size.width;

    /// Animated Button
    bool isAnimated = false;
    final isStretched = isAnimated || state == ButtonState.init;
    final isDone = state == ButtonState.done;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(width, 8),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 15, 15, 15),
        ),
      ),
      body: ListView(
        children: [
          buildTop(),
          buildContent(),
          // const Divider(),
          // buildChipsPanel(),
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(32),
            child: AnimatedContainer(
              // animated container for any changes in button status
              width: state == ButtonState.init ? width : 60,
              height: 60,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
              onEnd: () => setState(() => isAnimated = !isAnimated),
              child: isStretched ? loadingButton() : buildSmallButton(isDone),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTop() {
    final top = coverHeight - profileHeight / 2;
    final bottom = profileHeight / 2;
    return Container(
      margin: EdgeInsets.only(bottom: bottom),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          buildCoverImage(),
          Positioned(top: top, child: buildProfileImage()),
        ],
      ),
    );
  }

  Widget buildContent() {
    return Column(
      children: [
        Column(
          children: [
            const Text(
              "Jiexin Li",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "Flutter Software Developer",
              style: TextStyle(fontSize: 20, color: Colors.grey.shade400),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildSocialIcon(FontAwesomeIcons.github),
            const SizedBox(width: 20),
            buildSocialIcon(FontAwesomeIcons.facebook),
            const SizedBox(width: 20),
            buildSocialIcon(FontAwesomeIcons.linkedin),
            const SizedBox(width: 20),
            buildSocialIcon(FontAwesomeIcons.slack),
          ],
        ),
        const SizedBox(height: 24),
        const Divider(),
        const NumbersWidget(),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "About",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                IntroText.introForMePage,
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// build cover image for top
  Widget buildCoverImage() => Container(
        color: Colors.grey,
        child: Image.asset(
          'assets/images/cover.png',
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );

  /// rounded profile image for lee
  Widget buildProfileImage() => Container(
        width: profileHeight,
        height: profileHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          image: const DecorationImage(
              fit: BoxFit.cover, image: AssetImage('assets/images/lee.jpg')),
          border: Border.all(
            width: 8,
            color: Colors.indigo,
          ),
        ),
      );

  /// social media badget/avatar
  Widget buildSocialIcon(IconData icon) => CircleAvatar(
        backgroundColor: AppColor.mainThemeColor,
        radius: 25,
        child: InkWell(
            onTap: () {},
            child: Center(
                child: Icon(
              icon,
              size: 32,
              color: Colors.white,
            ))),
      );

  /// animated button
  Widget loadingButton() => OutlinedButton(
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          setState(() => state = ButtonState.loading);
          await Future.delayed(const Duration(milliseconds: 2500));
          setState(() => state = ButtonState.done);
          await Future.delayed(const Duration(milliseconds: 2500));
          setState(() => state = ButtonState.init);
          // delete local storage, after restart the app, will not go to home page
          await prefs.setBool("showHome", false);
          Get.offAll(() => Welcome());
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.red.shade600,
        ),
        child: const FittedBox(
          child: Text(
            "Go To WELCOME",
            style: TextStyle(
              fontSize: 21,
              color: Colors.white,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
}
