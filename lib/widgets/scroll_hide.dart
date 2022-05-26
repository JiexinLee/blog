import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollHideWidget extends StatefulWidget {
  final Widget child;
  final ScrollController controller;
  final Duration duration;
  const ScrollHideWidget(
      {Key? key,
      required Widget this.child,
      required ScrollController this.controller,
      this.duration = const Duration(milliseconds: 300)})
      : super(key: key);

  @override
  State<ScrollHideWidget> createState() => _ScrollHideWidgetState();
}

class _ScrollHideWidgetState extends State<ScrollHideWidget> {
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(listener);
  }

  @override
  void dispose() {
    widget.controller.removeListener(listener);
    super.dispose();
  }

  void listener() {
    final direction = widget.controller.position.userScrollDirection;
    if (direction == ScrollDirection.reverse) {
      print("hide");
      hide();
    } else if (direction == ScrollDirection.forward) {
      print("show");
      show();
    }
  }

  void show() {
    if (!isVisible) setState(() => isVisible = true);
  }

  void hide() {
    if (isVisible) setState(() => isVisible = false);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: widget.duration,
      child: Wrap(children: [widget.child]),
      height: isVisible ? kBottomNavigationBarHeight + 15 : 0,
    );
  }
}
