import 'package:flutter/material.dart';
import '../models/browser_state.dart';
import '../utils/url_validator.dart';

class BrowserProvider with ChangeNotifier {
  BrowserState _state = BrowserState();
  
  BrowserState get state => _state;

  void updateUrl(String url) {
    _state = _state.copyWith(currentUrl: url);
    notifyListeners();
  }

  void updateLoading(bool isLoading) {
    _state = _state.copyWith(isLoading: isLoading);
    notifyListeners();
  }

  void updateProgress(double progress) {
    _state = _state.copyWith(progress: progress);
    notifyListeners();
  }

  void updateNavigation(bool canGoBack, bool canGoForward) {
    _state = _state.copyWith(canGoBack: canGoBack, canGoForward: canGoForward);
    notifyListeners();
  }

  void updateTitle(String title) {
    _state = _state.copyWith(title: title);
    notifyListeners();
  }

  void updateThemeColor(Color color) {
    _state = _state.copyWith(themeColor: color);
    notifyListeners();
  }

  void setError(bool hasError) {
    _state = _state.copyWith(hasError: hasError);
    notifyListeners();
  }

  void reset() {
    _state = BrowserState();
    notifyListeners();
  }

  String getFormattedUrl() {
    return UrlValidator.formatUrl(_state.currentUrl);
  }
}
