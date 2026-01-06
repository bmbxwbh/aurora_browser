class BrowserState {
  final String currentUrl;
  final bool isLoading;
  final double progress;
  final bool canGoBack;
  final bool canGoForward;
  final String title;
  final Color? themeColor;
  final bool hasError;

  BrowserState({
    this.currentUrl = '',
    this.isLoading = false,
    this.progress = 0.0,
    this.canGoBack = false,
    this.canGoForward = false,
    this.title = '',
    this.themeColor,
    this.hasError = false,
  });

  BrowserState copyWith({
    String? currentUrl,
    bool? isLoading,
    double? progress,
    bool? canGoBack,
    bool? canGoForward,
    String? title,
    Color? themeColor,
    bool? hasError,
  }) {
    return BrowserState(
      currentUrl: currentUrl ?? this.currentUrl,
      isLoading: isLoading ?? this.isLoading,
      progress: progress ?? this.progress,
      canGoBack: canGoBack ?? this.canGoBack,
      canGoForward: canGoForward ?? this.canGoForward,
      title: title ?? this.title,
      themeColor: themeColor ?? this.themeColor,
      hasError: hasError ?? this.hasError,
    );
  }
}
