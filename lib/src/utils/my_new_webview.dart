
import 'package:TLSouq/src/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';



class WAppWebView extends StatefulWidget {

  final String? email ;

  const WAppWebView({Key? key,required this.email}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WAppWebView();
  }
}

class _WAppWebView extends State<WAppWebView> {

  bool isLoading = true;

  donePage(){
    setState(() {
      isLoading = false;
    });
  }

  _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          child:const Icon(Icons.arrow_back_ios,color: Colors.black,),
          onTap: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child:Stack(
            children:[
              WebView(
                initialUrl: "https://wa.me/?text=Hello",
                javascriptMode: JavascriptMode.unrestricted,
                navigationDelegate: (NavigationRequest request) async {
                  if (request.url
                      .startsWith('https://api.whatsapp.com/send?phone')) {
                    print('blocking navigation to $request}');
                    List<String> urlSplitted = request.url.split("&text=");

                    String phone = "0123456789";
                    String message =
                    urlSplitted.last.toString().replaceAll("%20", " ");

                    await _launchURL(
                        "https://wa.me/$phone/?text=${Uri.parse(message)}");
                    return NavigationDecision.prevent;
                  }

                  print('allowing navigation to $request');
                  return NavigationDecision.navigate;
                },

              ),
              Positioned(
                  bottom: 0,
                  left: 20,
                  child:ElevatedButton(
                    onPressed: (){
                        print("Hello");
                    },
                    child:isLoading
                        ?null
                        :const Text(
                        'done'
                    ),
                  )
              ),
              Stack()
            ]
        ),
      ),
    );
  }
}
