import 'package:flutter/services.dart';

class BBClipboard {
  static Future<String?> paste() async {
    try {
      final data = await Clipboard.getData(Clipboard.kTextPlain);
      return data?.text;
    } catch (e) {
      return null;
    }
  }

  static Future<void> copy(String data) async {
    try {
      await Clipboard.setData(ClipboardData(text: data));
      HapticFeedback.mediumImpact();
    } catch (e) {}
  }
}
