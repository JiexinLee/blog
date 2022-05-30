import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_abnhelper/constants/colors.dart';
import 'package:flutter_abnhelper/constants/url.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BlogDetail extends StatefulWidget {
  BlogDetail({Key? key}) : super(key: key);

  @override
  State<BlogDetail> createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail> {
  late WebViewController controller;
  late final String initialUrl;
  double loadingPercentage = 0;
  bool isloading = true;
  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    initialUrl = Get.arguments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // For Android platform
      onWillPop: () async {
        if (await controller.canGoBack()) {
          // Stay in App when press back button
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: AppBar(
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.clear_rounded),
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  if (await controller.canGoBack()) controller.goBack();
                },
                icon: const Icon(Icons.arrow_back),
              ),
              IconButton(
                onPressed: () => controller.reload(),
                icon: const Icon(Icons.refresh_rounded),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            if (isloading)
              SizedBox(
                height: 20,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    LinearProgressIndicator(
                      value: loadingPercentage,
                      color: AppColor.mainThemeColor,
                      backgroundColor: Colors.black,
                    ),
                    Center(
                      child: Text(
                        "${ (loadingPercentage*100).toInt()} %",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
            Expanded(
              child: WebView(
                onWebViewCreated: (webcontroller) => controller = webcontroller,
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: URL.prefixLink + initialUrl,
                onProgress: (progress) {
                  setState(() {
                    loadingPercentage = progress / 100;
                    if (progress == 100) isloading = false;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
