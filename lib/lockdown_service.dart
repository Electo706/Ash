import 'dart:io';

class LockdownService {
  static final File _file = File('lib/lockdown.txt');

  static bool _enabled = false;

  static bool get enabled => _enabled;

  static Future<void> load() async {
    if (await _file.exists()) {
      final content = await _file.readAsString();
      _enabled = content.trim().toLowerCase() == 'true';
    }
  }

  static Future<void> set(bool enabled) async {
    _enabled = enabled;
    await _file.writeAsString(enabled.toString());
  }
}
