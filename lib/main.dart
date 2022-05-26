import 'package:flutter/material.dart';
import 'package:flutter_abnhelper/constants/colors.dart';
import 'package:flutter_abnhelper/constants/icons.dart';
import 'package:flutter_abnhelper/constants/theme.dart';
import 'package:flutter_abnhelper/pages/demo.dart';
import 'package:flutter_abnhelper/pages/find/find.dart';
import 'package:flutter_abnhelper/pages/home/home.dart';
import 'package:flutter_abnhelper/pages/me/me.dart';
import 'package:flutter_abnhelper/pages/post/post.dart';
import 'package:flutter_abnhelper/pages/welcome/welcome.dart';
import 'package:flutter_abnhelper/widgets/navigation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool("showHome") ?? false;
  runApp(MyApp(showHome: showHome));
}

class MyApp extends StatelessWidget {
  final bool showHome;
  const MyApp({Key? key, required this.showHome}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      title: "Jiexin Li",
      home: showHome ? const MyHomePage(title: "Jiexin Li") : Welcome(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController pageController = PageController();
  final controller = ScrollController();
  int currentIndex = 0;

  void onIndexChanged(int index) {
    setState(() {
      currentIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // 扩展到Scaffold的底部
      resizeToAvoidBottomInset: false, // 不允许键盘事件影响界面
      // appBar: AppBar(
      //   actions: [
      //     IconButton(
      //       onPressed: () async {
      //         final prefs = await SharedPreferences.getInstance();
      //         prefs.setBool("showHome", false);
      //         Get.offAll(()=>Welcome());
      //       },
      //       icon: const Icon(Icons.exit_to_app_rounded),
      //       color: Colors.white,
      //     ),
      //   ],
      //   backgroundColor: AppColor.accentColor,
      //   title: Text(
      //     widget.title,
      //     style: const TextStyle(color: Colors.white),
      //   ),
      // ),
      // PageController 控制 PageView 呈现页面
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onIndexChanged,
        children: [
          Home(),
          Find(),
          DemoPage(title: "chat"),
          Me(),
        ],
      ),
      // Curve Navigation
      bottomNavigationBar: BuildNavigation(
          currentIndex: currentIndex,
          items: [
            NavigationItemModel(
              label: "home",
              icon: SvgIcon.layout,
            ),
            NavigationItemModel(
              label: "find",
              icon: SvgIcon.search,
            ),
            NavigationItemModel(
              label: "chat",
              icon: SvgIcon.chat,
              count: 9,
            ),
            NavigationItemModel(
              label: "me",
              icon: SvgIcon.user,
            ),
          ],
          onTap: onIndexChanged, // 切换tab事件
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(()=> Post()),
        child: const Icon(Icons.add_circle_rounded, size: 50),
      ), // 浮动按钮
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked, // 浮动按钮 停靠在底部中间位置
    );
  }
}
