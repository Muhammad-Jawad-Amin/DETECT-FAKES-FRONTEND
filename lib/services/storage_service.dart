import 'package:detect_fakes/utils/exceptions/firebase_exceptions.dart';
import 'package:detect_fakes/utils/exceptions/format_exceptions.dart';
import 'package:detect_fakes/utils/exceptions/platform_exceptions.dart';
import 'package:detect_fakes/utils/constants/app_texts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'dart:io';

class StorageService {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> uploadProfilePicture({
    required File file,
    required String userId,
    String fileType = "ProfilePicture",
  }) async {
    try {
      String fileName =
          '${AppTexts.profilePicsStorage}/$userId/${basename(file.path)}_$fileType';
      Reference storageRef = storage.ref().child(fileName);
      UploadTask uploadTask = storageRef.putFile(File(file.path));
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AppFormatException();
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong please try agin later.";
    }
  }

  Future<String> uploadFile({
    required File file,
    required String userId,
    required String fileId,
    required String detectionDateTime,
    required bool isImage,
  }) async {
    try {
      late String fileName;
      if (isImage) {
        fileName =
            '${AppTexts.imagesStorage}/$userId/$detectionDateTime$fileId';
      } else {
        fileName =
            '${AppTexts.videosStorage}/$userId/$detectionDateTime$fileId';
      }
      Reference storageRef = storage.ref().child(fileName);
      UploadTask uploadTask = storageRef.putFile(File(file.path));
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AppFormatException();
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong please try agin later.";
    }
  }
}
