import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'page_load.dart';
import 'package:flutter/services.dart';

void main() {
  //SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  runApp(
    MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const WebViewApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://reup-front-stage.vercel.app/'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: WebViewStack(
            controller: controller,
          ),
        ),
        onWillPop: () async {
          if (await controller.canGoBack()) {
            controller.goBack();
          } else {
            //
            // прописать тут предупреждение о выходе
          }
          return false;
        });
  }
}
