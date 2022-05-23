import 'package:flutter/widgets.dart';
import 'package:flutter_abnhelper/widgets/card.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: ListView.separated(
        itemCount: 10,
        itemBuilder: (context, index) => card(index, context),
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          height: 20,
        ),
      ),
    );
  }
}
