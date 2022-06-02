import 'package:flutter/material.dart';
import 'package:flutter_abnhelper/constants/text.dart';
import 'package:flutter_abnhelper/main.dart';
import 'package:flutter_abnhelper/widgets/welcome.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Welcome extends StatefulWidget {
  Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  /// page controller for page view at welcome page
  final controller = PageController();

  /// loading indicator for button
  var isLoading = false;

  /// indicate is the page is the last page
  var isLastPage = false;

  /// page amount
  var pageCount = 3;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              isLastPage = index == 2;
            });
          },
          children: [
            buildWelcomePage(
              title: "JIEXIN LI",
              color: Colors.amber.shade100,
              urlImage: "assets/images/business.png",
              subtitle: IntroText.firstPageIntro,
            ),
            buildWelcomePage(
              title: "PASSION",
              color: Colors.indigo.shade100,
              urlImage: "assets/images/working.png",
              subtitle: IntroText.secondPageIntro,
            ),
            buildWelcomePage(
              title: "MOBILE DEV",
              color: Colors.lime.shade100,
              urlImage: "assets/images/taxation.png",
              subtitle: IntroText.lastPageIntro,
            ),
          ],
        ),
      ),
      /**
       * if is the last page, the bottom will show a big button for going to home page
       */
      bottomSheet: isLastPage
          ? ElevatedButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: Colors.indigo.shade400,
                primary: Colors.white,
                minimumSize: const Size.fromHeight(80),
              ),
              onPressed: () async {
                /// get instance for local storage
                final prefs = await SharedPreferences.getInstance();

                /// set the instance to true, if restart the device,
                /// will not go to [welcome] page again
                await prefs.setBool("showHome", true);
                if (isLoading) return;
                setState(() => isLoading = true);
                await Future.delayed(const Duration(milliseconds: 2200));
                Get.offAll(() => const MyHomePage(title: "Jiexin Li"));
                setState(() => isLoading = false);
              },
              child: Container(
                padding: const EdgeInsets.only(bottom: 5),
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "GET START",
                        style: TextStyle(fontSize: 24),
                      ),
              ),
            )
          : Container(
              padding: const EdgeInsets.all(20),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 70,
                    height: 38,
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade400,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton(
                      onPressed: () =>
                          Get.offAll(const MyHomePage(title: "Jiexin Li")),
                      child: const Text(
                        "SKIP",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: pageCount,

                      /// style of the page dots
                      effect: const WormEffect(
                        activeDotColor: Colors.indigo,
                        dotColor: Colors.grey,
                        spacing: 16,
                      ),
                      onDotClicked: (index) => controller.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      ),
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 38,
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade400,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton(
                      onPressed: () => controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut),
                      child: const Text(
                        "NEXT",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
