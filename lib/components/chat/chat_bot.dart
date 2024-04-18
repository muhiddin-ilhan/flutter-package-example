import 'package:flutter/material.dart';
import 'package:vc_product_widgets/helper/loading_spinner/vc_loading_spinner.dart';
import 'package:vc_product_widgets/helper/sizer_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class ChatBotComponent extends StatefulWidget {
  const ChatBotComponent({super.key});

  @override
  State<ChatBotComponent> createState() => _ChatBotComponentState();
}

class _ChatBotComponentState extends State<ChatBotComponent> {
  final WebViewController _controller = WebViewController();
  String chatHtml = "";
  String chatStartJS = "";
  String chatMinimizeJS = "";
  String chatCloseJS = "";
  @override
  initState() {
    super.initState();
    chatStartJS = """window.addEventListener(\"lcw:ready\", function(){Microsoft.Omnichannel.LiveChatWidget.SDK.startChat({inNewWindow: false});})""";
    chatMinimizeJS = """window.addEventListener(\"lcw:onMinimize\", function(){ChatBotListener.postMessage("Minimized");})""";
    chatCloseJS = """window.addEventListener(\"lcw:onClose\", function(){ChatBotListener.postMessage("Closed");})""";
   chatHtml = """<html>
            <head>
                <meta http-equiv="no-cache">
                <meta http-equiv="Expires" content="-1">
                <meta http-equiv="Cache-Control" content="no-cache">
                <script id="Microsoft_Omnichannel_LCWidget"
                src="https://oc-cdn-public-eur.azureedge.net/livechatwidget/scripts/LiveChatBootstrapper.js"
                data-app-id="8e200b88-9979-4bfa-a2e9-1057e4149b07"
                data-org-id="71e68e9b-9e98-486d-b8a5-39c33a70ee32"
                data-org-url="https://orge601e24b-crm4.omnichannelengagementhub.com"></script>

                <script type="text/javascript" id="chattrigger">



                window.addEventListener("lcw:ready", function handleLivechatReadyEvent() {
                Microsoft.Omnichannel.LiveChatWidget.SDK.setContextProvider(function contextProvider() {
                return {
                'ChatType': { 'value': 'Basic', 'isDisplayable': true }
                };
                });
                });



                </script>
                <script 
                    type="text/javascript"
                    src = "Use src from widget code snippet"
                    id = Microsoft_Omnichannel_LCWidget
                    data-app-id = "Use data-app-Id from widget code snippet"
                    data-org-id = "Use data-org-Id from widget code snippet"
                    data-org-url = "Use data-org-url from widget code snippet"
                    data-render-mobile = "true"
                    data-hide-chat-button = "true"
                    data-color-override = "desired color code eg. #008577">
                </script>
            </head>
            <body>
            </body>
        </html>
    """;

    _controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'ChatBotListener',
        onMessageReceived: (JavaScriptMessage message) {
          if(message.message=="Closed" || message.message=="Minimized"){
            Navigator.of(context).pop();
          }
        },
      )
  ..setBackgroundColor(const Color(0x00000000))
  ..setNavigationDelegate(
    NavigationDelegate(
      onProgress: (int progress) {
        VCLoadingSpinner.show();

      },
      onPageStarted: (String url) {},
      onPageFinished: (String url) {

        VCLoadingSpinner.dismiss();
        setState(() {
      _controller.runJavaScript(chatStartJS);
      _controller.runJavaScript(chatMinimizeJS);
      _controller.runJavaScript(chatCloseJS);
        });
      },
      onWebResourceError: (WebResourceError error) {},
      onNavigationRequest: (NavigationRequest request) {
        return NavigationDecision.navigate;
      },
    ),
  )
  ..loadHtmlString(chatHtml);
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }

}
