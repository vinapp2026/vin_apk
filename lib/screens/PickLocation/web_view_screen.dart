import 'package:VIN/utilites/constants.dart';
import 'package:VIN/widgets/custom_parent_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class WebViewScreen extends StatefulWidget {
   WebViewScreen({Key? key}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  WebViewController? webViewController;
  bool isLoading = true;
  String url="";
  void onWebView(webViewController) async{
    url = await "https://gstempire.com/tournament.gstempire.com/public/admin/dashboard";
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    onWebView(webViewController);
  }
  @override
  Widget build(BuildContext context) {
    return CustomParentWidget(
      child: Scaffold(
        body: url==""||url==null ? Center(
            child: CupertinoActivityIndicator()):  WebView(
          initialUrl: url,
          onWebViewCreated: onWebView,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
