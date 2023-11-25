import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
// ignore: depend_on_referenced_packages
import 'package:image/image.dart' as img;

class MediaInfo {
  String path;
  MediaType type;
  MediaInfo(this.path, this.type);
}

enum MediaType {
  FILE,
  IMAGE,
  VIDEO,
  UNKNOWN,
}

class MediaHelper {
  String tag = 'MediaHelper :';
  static const imageExtensions = ["png", "jpg", "jpeg", "gif", "webp"];
  static const videoExtensions = ["mp4", "mov", "mkv", "avi"];
  static const fileExtensions = [
    "pdf",
    "doc",
    "docx",
    "odt",
    'ppt',
    'pptx',
    "xls",
    "xlsx",
    "csv",
    "psd",
    "txt",
    "zip",
    "rar"
  ];

  static String generateAvatarByName(String name) {
    return 'https://ui-avatars.com/api/?size=256&name=$name';
  }

  static MediaInfo getMediaType(String path) {
    final extension = path.startsWith('http')
        ? p.extension(path).replaceFirst(".", "").split("?").first
        : p.extension(path).replaceFirst(".", "");

    if (imageExtensions.contains(extension.toLowerCase())) {
      return MediaInfo(path, MediaType.IMAGE);
    } else if (videoExtensions.contains(extension.toLowerCase())) {
      return MediaInfo(path, MediaType.VIDEO);
    } else if (fileExtensions.contains(extension.toLowerCase())) {
      return MediaInfo(path, MediaType.FILE);
    } else {
      return MediaInfo(path, MediaType.UNKNOWN);
    }
  }

  static Future<Uint8List> compressBytes(Uint8List list) async {
    Uint8List result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 1920,
      minWidth: 1080,
      quality: 20,
    );
    debugPrint(list.length.toString());
    debugPrint(result.length.toString());
    return result;
  }

  static Future<File> compressImage({
    required File file,
    required int limit,
  }) async {
    int minLimit = 1000000;
    if (limit < minLimit) limit = minLimit;
    int size = file.lengthSync();
    while (size >= limit) {
      Uint8List? result = await FlutterImageCompress.compressWithFile(
        file.absolute.path,
        minWidth: 1024,
        minHeight: 1024,
        quality: 80,
      );
      img.Image image = img.decodeJpg(result!)!;
      File(file.path).writeAsBytesSync(img.encodePng(image));
      size = file.lengthSync();
    }
    return file;
  }

  static Future<File?> pickImage({
    required ImageSource source,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
    bool withCompression = false,
    double? maxHeight,
    double? maxWidth,
    int? imageQuality,
    int sizeLimit = 2000000,
  }) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: source,
      maxHeight: withCompression ? 1024 : maxHeight,
      maxWidth: withCompression ? 1024 : maxWidth,
      imageQuality: imageQuality,
      preferredCameraDevice: preferredCameraDevice,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      if (withCompression) {
        imageFile = await compressImage(
          file: imageFile,
          limit: sizeLimit,
        );
      }
      return imageFile;
    }
    return null;
  }

  static Future<File?> pickVideo({
    required ImageSource source,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
    Duration? maxDuration,
  }) async {
    XFile? pickedFile = await ImagePicker().pickVideo(
      source: source,
      preferredCameraDevice: preferredCameraDevice,
      maxDuration: maxDuration ?? const Duration(seconds: 20),
    );
    return File(pickedFile!.path);
  }
}