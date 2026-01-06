import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/browser_provider.dart';
import '../widgets/address_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/web_view_container.dart';
import '../widgets/progress_bar.dart';
import '../widgets/loading_indicator.dart';

class BrowserScreen extends StatefulWidget {
  const BrowserScreen({super.key});

  @override
  State<BrowserScreen> createState() => _BrowserScreenState();
}

class _BrowserScreenState extends State<BrowserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            const AddressBar(),
            Expanded(
              child: Stack(
                children: [
                  const WebViewContainer(),
                  const CustomProgressBar(),
                  const LoadingIndicator(),
                ],
              ),
            ),
            const BottomNavBar(),
          ],
        ),
      ),
    );
  }
}
