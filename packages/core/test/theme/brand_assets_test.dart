import 'dart:io';
import 'dart:typed_data';

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

  test('the bundled family covers every glyph the shipped copy uses', () {
    final fonts = Directory(repoPath('packages/core/assets/fonts'))
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('.ttf'))
        .where((f) => !f.path.contains('IBMPlexMono'))
        .toList();
    expect(fonts, isNotEmpty);

    final covered = fonts.map((f) => _cmapCodepoints(f)).toList();

    // Every Arabic codepoint that appears in a shipped .arb value.
    final used = <int>{};
    for (final dir in ['apps', 'packages']) {
      for (final file
          in Directory(repoPath(dir))
              .listSync(recursive: true)
              .whereType<File>()
              .where((f) => f.path.endsWith('_ar.arb'))) {
        for (final rune in file.readAsStringSync().runes) {
          if (rune >= 0x0600 && rune <= 0x06FF) used.add(rune);
        }
      }
    }
    expect(used, isNotEmpty, reason: 'no Arabic copy found to check');

    for (final codes in covered) {
      final missing = used.difference(codes);
      expect(
        missing,
        isEmpty,
        reason:
            'the shipped copy uses '
            '${missing.map((c) => 'U+${c.toRadixString(16).toUpperCase()}').join(', ')} '
            'which the bundled family cannot render; a fallback font will not '
            'fix it, because Arabic joining is resolved per font run',
      );
    }
  });
}

/// Minimal format-4 `cmap` reader — enough to know which codepoints a face
/// can actually render.
Set<int> _cmapCodepoints(File file) {
  final b = ByteData.sublistView(file.readAsBytesSync());
  final numTables = b.getUint16(4);
  var cmapOffset = -1;
  for (var i = 0; i < numTables; i++) {
    final rec = 12 + i * 16;
    final tag = String.fromCharCodes(
      List.generate(4, (k) => b.getUint8(rec + k)),
    );
    if (tag == 'cmap') cmapOffset = b.getUint32(rec + 8);
  }
  expect(cmapOffset, greaterThan(0), reason: 'no cmap in ${file.path}');

  final codes = <int>{};
  final numSub = b.getUint16(cmapOffset + 2);
  for (var i = 0; i < numSub; i++) {
    final sub = cmapOffset + b.getUint32(cmapOffset + 4 + i * 8 + 4);
    if (b.getUint16(sub) != 4) continue;
    final segX2 = b.getUint16(sub + 6);
    final segs = segX2 ~/ 2;
    final endBase = sub + 14;
    final startBase = endBase + segX2 + 2;
    for (var s = 0; s < segs; s++) {
      final end = b.getUint16(endBase + s * 2);
      final start = b.getUint16(startBase + s * 2);
      if (end == 0xFFFF) continue;
      for (var c = start; c <= end; c++) {
        codes.add(c);
      }
    }
  }
  return codes;
}
