import 'dart:convert';
import 'package:http/http.dart' as http;

class UpdateInfo {
  final bool hasUpdate;
  final String latestVersion;
  final String? downloadUrl;
  final String? releaseNotes;

  UpdateInfo({
    required this.hasUpdate,
    required this.latestVersion,
    this.downloadUrl,
    this.releaseNotes,
  });
}

class UpdateService {
  static const String _owner = 'zyf2492313716-cloud';
  static const String _repo = 'rushi-app';
  static const String currentVersion = '1.4.0';

  Future<UpdateInfo> checkForUpdate() async {
    try {
      final response = await http
          .get(
            Uri.parse(
                'https://api.github.com/repos/$_owner/$_repo/releases/latest'),
            headers: {'Accept': 'application/vnd.github.v3+json'},
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) {
        return UpdateInfo(
            hasUpdate: false, latestVersion: currentVersion);
      }

      final data = jsonDecode(response.body);
      final tagName = data['tag_name'] as String? ?? '';
      final latestVer =
          tagName.startsWith('v') ? tagName.substring(1) : tagName;

      final assets = data['assets'] as List? ?? [];
      String? apkUrl;
      for (final asset in assets) {
        final name = asset['name'] as String? ?? '';
        if (name.endsWith('.apk')) {
          apkUrl = asset['browser_download_url'] as String?;
          break;
        }
      }

      final body = data['body'] as String?;

      return UpdateInfo(
        hasUpdate: _isNewerVersion(latestVer, currentVersion),
        latestVersion: latestVer,
        downloadUrl: apkUrl,
        releaseNotes: body,
      );
    } catch (_) {
      return UpdateInfo(hasUpdate: false, latestVersion: currentVersion);
    }
  }

  bool _isNewerVersion(String latest, String current) {
    final latestParts =
        latest.split('.').map((e) => int.tryParse(e) ?? 0).toList();
    final currentParts =
        current.split('.').map((e) => int.tryParse(e) ?? 0).toList();

    for (int i = 0; i < 3; i++) {
      final l = i < latestParts.length ? latestParts[i] : 0;
      final c = i < currentParts.length ? currentParts[i] : 0;
      if (l > c) return true;
      if (l < c) return false;
    }
    return false;
  }
}
