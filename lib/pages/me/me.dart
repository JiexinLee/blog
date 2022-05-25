import 'package:flutter/material.dart';
import 'package:flutter_abnhelper/constants/colors.dart';
import 'package:flutter_abnhelper/pages/me/numbers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Me extends StatefulWidget {
  Me({Key? key}) : super(key: key);

  @override
  State<Me> createState() => _MeState();
}

class _MeState extends State<Me> {
  double coverHeight = 280.0;
  double profileHeight = 144.0;

  String intro =
      "Flutter Software Developer for Flutter& Dart with years experience as Freelancer now. \n My mission is to create a better software world with awesome Flutter app designs!";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          buildTop(),
          buildContent(),
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
            children: [
              const Text(
                "About",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                intro,
                style: const TextStyle(fontSize: 16, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildCoverImage() => Container(
        color: Colors.grey,
        child: Image.asset(
          'assets/images/cover.png',
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );

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
}
