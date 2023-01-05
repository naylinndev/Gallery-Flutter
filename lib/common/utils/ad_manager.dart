import 'dart:io';

class AdManager {
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-5535366343807080~7528164639";
    } else if (Platform.isIOS) {
      return "ca-app-pub-5535366343807080~2055867173";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-5535366343807080/3259964173";
    } else if (Platform.isIOS) {
      return "ca-app-pub-5535366343807080/7947338167";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-5535366343807080/9771184594";
    } else if (Platform.isIOS) {
      return "ca-app-pub-5535366343807080/2503439794";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-5535366343807080/4189902467";
    } else if (Platform.isIOS) {
      return "ca-app-pub-5535366343807080/4760554587";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
