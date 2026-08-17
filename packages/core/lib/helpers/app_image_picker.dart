import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wasel_core/networking/errors/error_message.dart';

enum AppImageSource { camera, gallery }

class AppImagePickerException implements Exception {
  const AppImagePickerException(this.message);

  final String message;

  @override
  String toString() => message;
}

class AppImagePicker {
  AppImagePicker._();

  static const _accessDeniedCodes = {
    'camera_access_denied',
    'photo_access_denied',
  };

  static Future<File?> pick(AppImageSource source) async {
    try {
      final picked = await ImagePicker().pickImage(
        source: switch (source) {
          AppImageSource.camera => ImageSource.camera,
          AppImageSource.gallery => ImageSource.gallery,
        },
      );

      return picked == null ? null : File(picked.path);
    } on PlatformException catch (e) {
      throw AppImagePickerException(
        _accessDeniedCodes.contains(e.code)
            ? 'يرجى السماح بالوصول للكاميرا أو الصور من إعدادات التطبيق.'
            : defaultErrorMessage,
      );
    }
  }
}
