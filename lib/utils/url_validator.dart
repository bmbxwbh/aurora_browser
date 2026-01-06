class UrlValidator {
  static String formatUrl(String url) {
    if (url.isEmpty) return '';
    String formatted = url;
    if (formatted.startsWith('https://')) {
      formatted = formatted.substring(8);
    } else if (formatted.startsWith('http://')) {
      formatted = formatted.substring(7);
    }
    if (formatted.startsWith('www.')) {
      formatted = formatted.substring(4);
    }
    return formatted;
  }

  static String validateAndFormatUrl(String input) {
    if (input.isEmpty) return '';
    if (input.contains(' ')) {
      return 'https://www.google.com/search?q=${Uri.encodeComponent(input)}';
    }
    if (!input.startsWith('http://') && !input.startsWith('https://')) {
      if (input.contains('.') && !input.contains(' ')) {
        return 'https://$input';
      } else {
        return 'https://www.google.com/search?q=${Uri.encodeComponent(input)}';
      }
    }
    return input;
  }

  static bool isValidUrl(String url) {
    return url.startsWith('http://') || url.startsWith('https://');
  }
}
