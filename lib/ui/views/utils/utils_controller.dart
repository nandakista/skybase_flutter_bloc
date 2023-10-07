import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UtilsController extends GetxController {
  final currency = 125000;
  final imageFile = Rxn<File>();
  final currencyCtr = TextEditingController();

  final RxList pickedImages = <File>[].obs;

  final sampleImage = [
    'https://assets.suitdev.com/csi/storage/858/Sample-video.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    'https://picsum.photos/200/200.jpg',
    'https://picsum.photos/200/200.jpg',
    'https://picsum.photos/200/200.jpg',
    'https://picsum.photos/200/200.jpg',
    'https://picsum.photos/200/200.jpg',
  ];
}