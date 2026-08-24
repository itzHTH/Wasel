import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// The brand-coloured vector assets are checked in, not generated at runtime,
/// so nothing else stops an old brand colour from surviving a repaint.
void main() {
  const retiredBrandColours = <String, String>{
    '#4F46E5': 'the retired rider indigo',
    '#7C3AED': 'the retired rider violet',
    '#047857': 'the retired captain green',
    '#059669': 'the retired captain green',
    '#34D399': 'the retired captain mint',
  };

  final assetDirs = <String, List<String>>{
    'rider': ['apps/rider/assets/icons', 'apps/rider/assets/map_styles'],
    'driver': ['apps/driver/assets/icons', 'apps/driver/assets/map_styles'],
  };

  // The suite runs from the package dir or the repo root depending on how
  // it is invoked, so find the root rather than assuming it.
  Directory root() {
    var dir = Directory.current;
    while (!Directory('${dir.path}/apps').existsSync()) {
      final parent = dir.parent;
      if (parent.path == dir.path) {
        fail('could not locate the repo root from ${Directory.current.path}');
      }
      dir = parent;
    }
    return dir;
  }

  String repoPath(String p) => '${root().path}/$p';

  group('no retired brand colour survives in a shipped asset', () {
    assetDirs.forEach((app, dirs) {
      test(app, () {
        for (final dir in dirs) {
          final directory = Directory(repoPath(dir));
          if (!directory.existsSync()) continue;
          for (final file in directory.listSync().whereType<File>()) {
            final text = file.readAsStringSync().toUpperCase();
            retiredBrandColours.forEach((hex, why) {
              expect(
                text.contains(hex.toUpperCase()),
                isFalse,
                reason: '${file.path} still carries $hex — $why',
              );
            });
          }
        }
      });
    });
  });

  test('each brand mark carries its own identity colour', () {
    final rider = File(
      repoPath('apps/rider/assets/icons/wasel-icon.svg'),
    ).readAsStringSync().toUpperCase();
    final driver = File(
      repoPath('apps/driver/assets/icons/wasel-icon.svg'),
    ).readAsStringSync().toUpperCase();

    expect(rider, contains('#097A8F'), reason: 'rider mark is Velocity Teal');
    expect(driver, contains('#FFB020'), reason: 'captain mark is Signal Amber');

    // Amber carries ink, never white — the rule the identity rests on.
    expect(driver, contains('#1A1206'));
    expect(
      driver.contains('FILL="#FFFFFF"'),
      isFalse,
      reason: 'white on amber measures 1.6:1',
    );
  });
}
