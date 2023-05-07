import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:i_dance/views/student/student_home.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'home_screen.dart';


class PaymentPage extends StatelessWidget {
  String url;
  PaymentPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Get.offAll(HomeScreen());
        return Future.value(true);

      },
      child: Scaffold(
        appBar: AppBar(),
        body: WebViewWidget(controller: WebViewController() 
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              // Update loading bar.
            },
            onPageStarted: (String url) {},
            onPageFinished: (String url) {
            },
            onWebResourceError: (WebResourceError error) {},
            onNavigationRequest: (NavigationRequest request) {
              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(Uri.parse(url))
        )
      ),
    );
  }
}