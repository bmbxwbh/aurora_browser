import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/browser_provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BrowserProvider>();
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavButton(Icons.arrow_back, provider.state.canGoBack, () => Navigator.of(context).pop()),
          _buildNavButton(Icons.arrow_forward, provider.state.canGoForward, () => Navigator.of(context).pop()),
          _buildNavButton(Icons.refresh, true, () => Navigator.of(context).pop()),
          _buildNavButton(Icons.home, true, () => Navigator.of(context).pop()),
          _buildNavButton(Icons.bookmark_border, true, () => Navigator.of(context).pop()),
        ],
      ),
    );
  }

  Widget _buildNavButton(IconData icon, bool enabled, VoidCallback? onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: enabled ? onTap : null,
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: enabled ? Colors.grey[200] : Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: enabled ? Colors.grey[700] : Colors.grey[400], size: 22),
        ),
      ),
    );
  }
}
