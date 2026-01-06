import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/browser_provider.dart';
import '../utils/url_validator.dart';

class AddressBar extends StatefulWidget {
  const AddressBar({super.key});

  @override
  State<AddressBar> createState() => _AddressBarState();
}

class _AddressBarState extends State<AddressBar> {
  late TextEditingController _controller;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSubmitted(String value) {
    final provider = context.read<BrowserProvider>();
    final formattedUrl = UrlValidator.validateAndFormatUrl(value);
    setState(() => _isEditing = false);
    _controller.clear();
    provider.updateUrl(formattedUrl);
  }

  void _startEditing() {
    setState(() => _isEditing = true);
    final provider = context.read<BrowserProvider>();
    _controller.text = provider.state.currentUrl;
  }

  void _cancelEditing() {
    setState(() => _isEditing = false);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BrowserProvider>();
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          AnimatedScale(
            scale: provider.state.currentUrl.isNotEmpty ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.lock, size: 14, color: Colors.green),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _isEditing ? _buildTextField() : _buildDisplayMode(provider),
          ),
          const SizedBox(width: 8),
          _buildOptionsButton(),
        ],
      ),
    );
  }

  Widget _buildTextField() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: _controller,
        autofocus: true,
        textInputAction: TextInputAction.go,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, size: 20, color: Colors.grey[600]),
          suffixIcon: IconButton(
            icon: Icon(Icons.close, size: 20, color: Colors.grey[600]),
            onPressed: _cancelEditing,
          ),
          hintText: '搜索或输入网址',
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
        ),
        onSubmitted: _handleSubmitted,
      ),
    );
  }

  Widget _buildDisplayMode(BrowserProvider provider) {
    return GestureDetector(
      onTap: _startEditing,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                UrlValidator.formatUrl(provider.state.currentUrl),
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.edit, size: 16, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionsButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => _buildOptionsMenu(context),
          );
        },
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.more_vert, size: 20, color: Colors.grey[700]),
        ),
      ),
    );
  }

  Widget _buildOptionsMenu(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildOptionItem(context, Icons.share, '分享链接', () => Navigator.pop(context)),
          _buildOptionItem(context, Icons.bookmark, '添加书签', () => Navigator.pop(context)),
          _buildOptionItem(context, Icons.open_in_new, '外部打开', () => Navigator.pop(context)),
          _buildOptionItem(context, Icons.settings, '设置', () => Navigator.pop(context)),
        ],
      ),
    );
  }

  Widget _buildOptionItem(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Icon(icon, size: 22, color: Colors.grey[700]),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
