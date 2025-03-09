import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_webview/fwfh_webview.dart';

class OjsPage extends StatefulWidget {
  const OjsPage({super.key});

  @override
  State<OjsPage> createState() => _OjsPageState();
}

class _OjsPageState extends State<OjsPage> {
  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return HtmlWidget(
        '<div style = "display:flex; align:center; justify-content:center;"><iframe src="http://40.81.31.63:8000/index.php/files/dashboard/editorial" title="Iframe Example"></iframe></div>',
        factoryBuilder: () => MyWidgetFactory(),
      );
    } else {
      // Handle unsupported platforms
      return Center(
        child: Text(
          'This page is not supported on this platform',
          style: TextStyle(fontSize: 24),
        ),
      );
    }
  }
}

class MyWidgetFactory extends WidgetFactory with WebViewFactory {}
