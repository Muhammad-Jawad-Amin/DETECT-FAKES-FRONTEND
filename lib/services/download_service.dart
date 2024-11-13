import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DownloadService {
  final Dio _dio = Dio();

  Future<bool> _requestPermissions() async {
    bool isGranted = false;

    if (Platform.isAndroid) {
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.androidInfo;
      final sdkInt = deviceInfo.version.sdkInt;

      if (sdkInt > 33) {
        if (await Permission.photos.isGranted) {
          isGranted = true;
        } else {
          isGranted = await Permission.photos.request().isGranted;
        }
      } else if (sdkInt < 29) {
        if (await Permission.storage.isGranted) {
          isGranted = true;
        } else {
          isGranted = await Permission.storage.request().isGranted;
        }
      } else {
        isGranted = true;
      }
    } else if (Platform.isIOS) {
      if (await Permission.photosAddOnly.isGranted) {
        isGranted = true;
      } else {
        isGranted = await Permission.photosAddOnly.request().isGranted;
      }
    }

    return isGranted;
  }

  Future<void> saveImageToGallery(String imageUrl) async {
    try {
      bool isGranted = await _requestPermissions();
      if (!isGranted) {
        throw Exception("Storage permissions not granted");
      }

      String imageName = imageUrl.split('?')[0].split('/').last;
      var response = await _dio.get(
        imageUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      final result = await SaverGallery.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: imageName,
        androidRelativePath: "Pictures/DetectFakes",
        androidExistNotSave: true,
      );

      debugPrint("Image saved: $result");
    } catch (e) {
      debugPrint("Error saving image: $e");
      throw e.toString();
    }
  }

  Future<void> saveVideoToGallery(String videoUrl) async {
    try {
      bool isGranted = await _requestPermissions();
      if (!isGranted) {
        throw Exception("Storage permissions not granted");
      }

      String videoName = videoUrl.split('?')[0].split('/').last;
      var tempDir = await getTemporaryDirectory();
      String tempPath = "${tempDir.path}/$videoName";
      await _dio.download(videoUrl, tempPath);

      final result = await SaverGallery.saveFile(
        file: tempPath,
        name: videoName,
        androidRelativePath: "Movies/DetectFakes",
        androidExistNotSave: true,
      );

      debugPrint("Video saved: $result");
    } catch (e) {
      debugPrint("Error saving video: $e");
      throw e.toString();
    }
  }
}
