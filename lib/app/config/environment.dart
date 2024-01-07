class Environment {
  static const AppMode appMode = AppMode.testing;

  static url() {
    switch (appMode) {
      case AppMode.testing:
      case AppMode.staging:
        return '';
      case AppMode.live:
        return '';
    }
  }
}

enum AppMode {
  testing,
  staging,
  live,
}
