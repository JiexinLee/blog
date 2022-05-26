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
  // Stepper
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    /// Animated Button
    bool isAnimated = false;
    final isStretched = isAnimated || state == ButtonState.init;
    final isDone = state == ButtonState.done;

    List<Step> getSteps() => [
          Step(
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 0,
            title: Text('Title'),
            content: Container(),
          ),
          Step(
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 1,
            title: Text('Content'),
            content: Container(),
          ),
          Step(
            isActive: currentStep >= 2,
            title: Text('Complete'),
            content: Container(),
          ),
        ];

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
      body: Column(
        children: [
          Theme(
            data: Theme.of(context).copyWith(
                colorScheme:
                    const ColorScheme.light(primary: AppColor.mainThemeColor)),
            child: Stepper(
              onStepTapped: (step) => setState(() => currentStep = step),
              steps: getSteps(),
              currentStep: currentStep,
              onStepContinue: () {
                final isLastStep = currentStep == getSteps().length - 1;
                if (isLastStep) {
                  print("complete");
                  //send data to server
                } else {
                  setState(() => currentStep += 1);
                  print(123);
                }
              },
              onStepCancel: currentStep == 0
                  ? null
                  : () => setState(() => currentStep -= 1),
              controlsBuilder: (context, details) => Container(
                margin: const EdgeInsets.only(top: 50),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (currentStep != 2)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: details.onStepContinue,
                          child: const Text("NEXT"),
                        ),
                      ),
                    const SizedBox(
                      width: 12,
                    ),
                    if (currentStep != 0)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: details.onStepCancel,
                          child: const Text("BACK"),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(child: Container()),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(32),
            child: AnimatedContainer(
              width: state == ButtonState.init ? width : 60,
              height: 54,
              duration: const Duration(milliseconds: 300),
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
          await Future.delayed(const Duration(milliseconds: 2000));
          setState(() => state = ButtonState.done);
          await Future.delayed(const Duration(milliseconds: 1000));
          setState(() => state = ButtonState.init);
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.indigo,
        ),
        child: const FittedBox(
          child: Text(
            'SUBMIT',
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
