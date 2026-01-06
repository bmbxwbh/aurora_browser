import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/browser_provider.dart';

class CustomProgressBar extends StatelessWidget {
  const CustomProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BrowserProvider>();
    return AnimatedOpacity(
      opacity: provider.state.isLoading ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        height: 3,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue[400]!, Colors.blue[600]!]),
          borderRadius: BorderRadius.circular(2),
        ),
        child: LinearProgressIndicator(
          value: provider.state.progress,
          backgroundColor: Colors.transparent,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[400]!),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
