
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';
import 'package:image_picker/image_picker.dart';

class ImageAppPicker {

  final _other = _OtherImageAppPicker();
  final _desktop = _DesktopImageAppPicker();

  Future<Uint8List?> pickFile() async {
    if(kIsWeb || _desktop.platforms.firstWhereOrNull((platform) => platform == defaultTargetPlatform) == null) return _other.pickFile();
    else return _desktop.pickFile();
  }
}


class _DesktopImageAppPicker {
  final platforms = [
    TargetPlatform.macOS,
    TargetPlatform.fuchsia,
    TargetPlatform.linux,
    TargetPlatform.windows,
  ];

  Future<Uint8List?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    return File(result!.files.single.path!).readAsBytes();
  }
}

class _OtherImageAppPicker {
  Future<Uint8List?> pickFile() async {
    final xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    return xFile?.readAsBytes();
  }
}