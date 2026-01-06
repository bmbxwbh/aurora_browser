import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';
import '../providers/browser_provider.dart';

class WebViewContainer extends StatefulWidget {
  const WebViewContainer({super.key});

  @override
  State<WebViewContainer> createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  late WebViewController _controller;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            context.read<BrowserProvider>()
              ..updateLoading(true)
              ..updateUrl(url)
              ..setError(false);
            _hasError = false;
          },
          onPageFinished: (String url) async {
            context.read<BrowserProvider>()
              ..updateLoading(false)
              ..updateUrl(url);
            
            final title = await _controller.runJavaScriptReturningResult(
              "document.title.toString()"
            );
            if (title != "null" && title.isNotEmpty) {
              context.read<BrowserProvider>().updateTitle(title);
            }
            
            final canGoBack = await _controller.canGoBack();
            final canGoForward = await _controller.canGoForward();
            context.read<BrowserProvider>().updateNavigation(canGoBack, canGoForward);
          },
          onWebResourceError: (WebResourceError error) {
            if (!_hasError) {
              setState(() => _hasError = true);
              context.read<BrowserProvider>()
                ..updateLoading(false)
                ..setError(true);
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://www.google.com'));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedOpacity(
          opacity: _hasError ? 0.0 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: WebViewWidget(controller: _controller),
        ),
        if (_hasError) _buildErrorPage(),
      ],
    );
  }

  Widget _buildErrorPage() {
    return Container(
      color: Colors.grey[50],
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 80, color: Colors.red[200]),
              const SizedBox(height: 24),
              Text('无法访问此页面', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.grey[800])),
              const SizedBox(height: 12),
              Text('请检查您的网络连接或网址是否正确', style: TextStyle(fontSize: 16, color: Colors.grey[600]), textAlign: TextAlign.center),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() => _hasError = false);
                  _controller.reload();
                },
                icon: const Icon(Icons.refresh),
                label: const Text('重新加载'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[400],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
