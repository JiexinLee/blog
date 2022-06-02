import 'package:flutter/material.dart';
import 'package:flutter_abnhelper/constants/colors.dart';
import 'package:get/get.dart';

class Post extends StatefulWidget {
  Post({Key? key}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

enum ButtonState { init, loading, done }

class _PostState extends State<Post> {
  ButtonState state = ButtonState.init;

  /// Stepper : current step
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    /// Animated Button globals
    bool isAnimated = false;
    final isStretched = isAnimated || state == ButtonState.init;
    final isDone = state == ButtonState.done;

    /// create each step, each step contain widgets that can be customized
    List<Step> getSteps() => [
          Step(
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 0,
            title: currentStep == 0
                ? const Text(
                    'Title',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  )
                : const Text('Title'),
            // costumized widget
            content: Container(
              height: 200,
              child: ListView(
                children: [
                  Container(
                    height: 100,
                    color: Colors.blue,
                  )
                ],
              ),
            ),
          ),
          Step(
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 1,
            title: currentStep == 1
                ? const Text(
                    'Content',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  )
                : const Text('Content'),
            // costumized widget
            content: Container(),
          ),
          Step(
            isActive: currentStep >= 2,
            title: currentStep == 2
                ? const Text(
                    'Complete',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  )
                : const Text('Complete'),
            // costumized widget
            content: Container(),
          ),
        ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.accentColor,
        title: const Text(
          "Post New Blog",
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
      body: Theme(
        data: Theme.of(context).copyWith(
            colorScheme:
                const ColorScheme.light(primary: AppColor.mainThemeColor)),
        child: Stepper(
          onStepTapped: (step) => setState(() => currentStep = step),
          steps: getSteps(),
          currentStep: currentStep,
          // press next button
          onStepContinue: () {
            // if the step is the last step, run the function,
            // otherwise, go to next step
            final isLastStep = currentStep == getSteps().length - 1;
            if (isLastStep) {
              //send data to server
              print("last step");
            } else {
              setState(() => currentStep += 1);
            }
          },
          // press back button
          onStepCancel: currentStep == 0
              ? null
              : () => setState(() => currentStep -= 1), //null -> unable button
          controlsBuilder: (context, details) => Container(
            margin: const EdgeInsets.only(top: 50),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // display button if step >= 1
                if (currentStep != 2)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: details.onStepCancel,
                      child: const Text("BACK"),
                    ),
                  ),
                const SizedBox(
                  width: 12,
                ),
                currentStep != 2 // show submit button if is the last step
                    ? Expanded(
                        child: ElevatedButton(
                          onPressed: details.onStepContinue,
                          child: const Text("NEXT"),
                        ),
                      )
                    : Expanded(
                        child: ElevatedButton(
                          onPressed: details.onStepContinue,
                          child: const Text("SUBMIT"),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
