import 'package:VIN/utilites/constants.dart';
import 'package:VIN/widgets/custom_parent_widget.dart';
import 'package:VIN/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class WebViewScreens extends StatefulWidget {
   String? screenName;
   String? url;
   WebViewScreens({
     this.screenName,
     this.url,
     super.key});

  @override
  State<WebViewScreens> createState() => _WebViewScreensState();
}

class _WebViewScreensState extends State<WebViewScreens> {

  WebViewController? webViewController;
  bool isLoading = true;
  String url="";
  void onWebView(webViewController) async{
    url = await "${widget.url.toString()}";
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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back,color: blackColor,),
          ),
          title: CustomText(
            title: "${widget.screenName}",
            fontSize: 17,
            color: blackColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        body: url==""||url==null ? Center(
            child: CupertinoActivityIndicator()):
        Container(
          padding: EdgeInsets.symmetric(vertical: 15),
              child: WebView(
          initialUrl: url,
          onWebViewCreated: onWebView,
          javascriptMode: JavascriptMode.unrestricted,
        ),
            ),
      ),
    );
  }
}
