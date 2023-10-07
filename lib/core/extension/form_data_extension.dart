import 'dart:io';

import 'package:dio/dio.dart';

extension FileExtension on File? {
  MultipartFile? get toFormDataFile {
    return this != null ? MultipartFile.fromFileSync(this!.path) : null;
  }
}

extension FileNullListExtension on List<File>? {
  List<MultipartFile>? get toFormDataFiles {
    return this?.map((e) => MultipartFile.fromFileSync(e.path)).toList();
  }
}
