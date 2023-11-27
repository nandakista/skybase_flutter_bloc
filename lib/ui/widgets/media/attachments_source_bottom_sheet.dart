import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skybase/config/base/main_navigation.dart';
import 'package:skybase/core/helper/file_helper.dart';
import 'package:skybase/core/helper/media_helper.dart';
import 'package:skybase/core/helper/permission_helper.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class AttachmentsSourceBottomSheet extends StatelessWidget {
  final BuildContext pageContext;
  final double? maxHeight;
  final double? maxWidth;
  final int? imageQuality;
  final CameraDevice preferredCameraDevice;
  final void Function(File) onAttachmentsSelected;
  final void Function(List<File>) onMultipleAttachmentsSelected;

  final Widget? cameraIcon;
  final Widget? galleryIcon;
  final Widget? fileIcon;
  final Widget? cameraLabel;
  final Widget? galleryLabel;
  final Widget? fileLabel;
  final bool withImageCompression;
  final int sizeLimit;
  final bool allowMultiple;
  final List<String>? allowedFileExtensions;
  final bool enabledFileSource;

  const AttachmentsSourceBottomSheet({
    super.key,
    required this.pageContext,
    required this.onAttachmentsSelected,
    required this.onMultipleAttachmentsSelected,
    this.maxHeight,
    this.maxWidth,
    this.imageQuality,
    this.preferredCameraDevice = CameraDevice.rear,
    this.cameraIcon = const Icon(Icons.camera_alt_rounded),
    this.galleryIcon = const Icon(Icons.image),
    this.fileIcon = const Icon(CupertinoIcons.doc_text_fill),
    this.cameraLabel,
    this.galleryLabel,
    this.fileLabel,
    this.withImageCompression = false,
    this.sizeLimit = 2000000,
    this.allowMultiple = true,
    this.allowedFileExtensions,
    this.enabledFileSource = true,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        ListTile(
          leading: cameraIcon,
          title: cameraLabel ?? Text('txt_camera'.tr()),
          onTap: () {
            Navigation.instance.pop(context);
            _onPickImage(pageContext, ImageSource.camera);
          },
        ),
        ListTile(
          leading: galleryIcon,
          title: galleryLabel ?? Text('txt_gallery'.tr()),
          onTap: () {
            Navigation.instance.pop(context);
            _onPickImage(pageContext, ImageSource.gallery);
          },
        ),
        if (enabledFileSource)
          ListTile(
            leading: fileIcon,
            title: fileLabel ?? Text('txt_document'.tr()),
            onTap: () {
              Navigation.instance.pop(context);
              _onPickFile(pageContext);
            },
          ),
      ],
    );
  }

  Future<void> _onPickImage(BuildContext context, ImageSource source) async {
    if (source == ImageSource.camera) {
      final permission = await Permission.camera.request();
      if (context.mounted) {
        if (permission.isPermanentlyDenied) {
          PermissionHelper.openSettings(
            context,
            'txt_need_permission_camera'.tr(),
          );
        } else if (permission.isGranted) {
          _pickSingleImage(context, ImageSource.camera);
        }
      }
    } else {
      bool isGranted = await _checkPermission(context);
      if (context.mounted && isGranted) {
        if (allowMultiple) {
          _pickMultipleImage(context);
        } else {
          _pickSingleImage(context, ImageSource.gallery);
        }
      }
    }
  }

  Future<bool> _checkPermission(BuildContext context) async {
    final PermissionStatus permission;
    if (Platform.isIOS) {
      permission = await Permission.photos.request();
      if (permission.isPermanentlyDenied) {
        if (context.mounted) {
          PermissionHelper.openSettings(
              context, 'txt_need_permission_gallery_photo'.tr());
        }
        return false;
      }
      return true;
    } else {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt < 33) {
        permission = await Permission.storage.request();
        if (context.mounted) {
          if (permission.isPermanentlyDenied) {
            PermissionHelper.openSettings(
                context, 'txt_need_permission_gallery_photo'.tr());
          } else if (permission.isDenied) {
            PermissionHelper.error(context, 'txt_need_permission_storage'.tr());
          }
        }

        return permission.isGranted;
      } else {
        Map<Permission, PermissionStatus> permissionList = await [
          Permission.photos,
          Permission.videos,
        ].request();

        bool isGranted = permissionList.values.every((e) => e.isGranted);
        if (context.mounted) {
          if (permissionList.values
              .contains(PermissionStatus.permanentlyDenied)) {
            PermissionHelper.openSettings(
                context, 'txt_need_permission_storage'.tr());
          } else if (!isGranted) {
            PermissionHelper.error(context, 'txt_need_permission_storage'.tr());
          }
        }
        return isGranted;
      }
    }
  }

  Future<void> _pickSingleImage(
    BuildContext context,
    ImageSource source,
  ) async {
    final XFile? pickedFile = await ImagePicker().pickImage(
      source: source,
      maxHeight: withImageCompression ? 1024 : maxHeight,
      maxWidth: withImageCompression ? 1024 : maxWidth,
      imageQuality: imageQuality,
      preferredCameraDevice: preferredCameraDevice,
    );
    if (null != pickedFile) {
      File imageFile = File(pickedFile.path);
      if (withImageCompression) {
        imageFile = await MediaHelper.compressImage(
          file: imageFile,
          limit: sizeLimit,
        );
      }
      onAttachmentsSelected(imageFile);
      if (context.mounted) Navigation.instance.pop(context);
    }
  }

  Future<void> _pickMultipleImage(BuildContext context) async {
    final List<XFile> result = await ImagePicker().pickMultiImage(
      maxHeight: withImageCompression ? 1024 : maxHeight,
      maxWidth: withImageCompression ? 1024 : maxWidth,
      imageQuality: imageQuality,
    );
    onMultipleAttachmentsSelected(result.map((e) => File(e.path)).toList());
    if (context.mounted) Navigation.instance.pop(context);
  }

  Future<void> _onPickFile(BuildContext context) async {
    List<File> result = await FileHelper.pickFile(
          allowMultiple: allowMultiple,
          allowedExtensions:
              allowedFileExtensions ?? MediaHelper.fileExtensions,
        ) ??
        [];
    onMultipleAttachmentsSelected(result);
    if (context.mounted) Navigation.instance.pop(context);
  }
}
