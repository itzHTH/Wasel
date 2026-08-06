import 'dart:io' show Platform;

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

part 'navigation_handoff_provider.g.dart';

enum NavigationApp { waze, googleMaps, appleMaps, web }

@riverpod
class NavigationHandoff extends _$NavigationHandoff {
  @override
  Future<List<NavigationApp>> build() async {
    final installed = <NavigationApp>[];

    if (await _isInstalled('waze://')) installed.add(NavigationApp.waze);
    if (await _isInstalled('comgooglemaps://')) {
      installed.add(NavigationApp.googleMaps);
    }
    if (Platform.isIOS && await _isInstalled('maps://')) {
      installed.add(NavigationApp.appleMaps);
    }

    return [...installed, NavigationApp.web];
  }

  Future<void> open(NavigationApp app, double lat, double lng) async {
    final uri = Uri.parse(_urlFor(app, lat, lng));

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      await launchUrl(
        Uri.parse(_urlFor(NavigationApp.web, lat, lng)),
        mode: LaunchMode.externalApplication,
      );
    }
  }

  Future<bool> _isInstalled(String scheme) async {
    try {
      return await canLaunchUrl(Uri.parse(scheme));
    } catch (_) {
      return false;
    }
  }

  String _urlFor(NavigationApp app, double lat, double lng) => switch (app) {
    NavigationApp.waze => 'waze://?ll=$lat,$lng&navigate=yes',
    NavigationApp.googleMaps =>
      'comgooglemaps://?daddr=$lat,$lng&directionsmode=driving',
    NavigationApp.appleMaps => 'maps://?daddr=$lat,$lng&dirflg=d',
    NavigationApp.web =>
      'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng',
  };
}
