import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6709113357040647/5039761733';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-6709113357040647/4518346545';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-6709113357040647/2562606353";
    } else if (Platform.isIOS) {
      return "ca-app-pub-6709113357040647/3205264873";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
