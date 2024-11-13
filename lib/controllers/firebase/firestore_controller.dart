import 'package:detect_fakes/utils/exceptions/firebase_exceptions.dart';
import 'package:detect_fakes/utils/exceptions/format_exceptions.dart';
import 'package:detect_fakes/utils/constants/app_texts.dart';
import 'package:detect_fakes/models/profilepic_model.dart';
import 'package:detect_fakes/models/user_model.dart';
import 'package:detect_fakes/models/image_model.dart';
import 'package:detect_fakes/models/video_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FireStoreController extends GetxController {
  static FireStoreController get instance => Get.find();

  final String isDeletedAttribute = 'isDeleted';
  final String userIdAttribute = "userId";
  final FirebaseFirestore dataBase = FirebaseFirestore.instance;

  // ----------- User Related Methods ------------
  Future<void> addUser(UserModel user) async {
    try {
      await dataBase
          .collection(AppTexts.usersCollection)
          .doc(user.userId)
          .set(user.toMap());
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AppFormatException();
    } catch (e) {
      throw "Something went wrong please try agin later.";
    }
  }

  Future<UserModel?> getUserById(String userId) async {
    try {
      DocumentSnapshot doc =
          await dataBase.collection(AppTexts.usersCollection).doc(userId).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AppFormatException();
    } catch (e) {
      throw "Something went wrong please try agin later.";
    }
  }

  // ----------- Image Related Methods ------------
  Future<void> addImage(ImageModel image) async {
    try {
      await dataBase
          .collection(AppTexts.imagesCollection)
          .doc(image.imageId)
          .set(image.toMap());
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AppFormatException();
    } catch (e) {
      throw "Something went wrong please try agin later.";
    }
  }

  Future<ImageModel?> getImageById(String imageId) async {
    try {
      DocumentSnapshot doc = await dataBase
          .collection(AppTexts.imagesCollection)
          .doc(imageId)
          .get();
      if (doc.exists) {
        return ImageModel.fromMap(doc.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AppFormatException();
    } catch (e) {
      throw "Something went wrong please try agin later.";
    }
  }

  Future<List<ImageModel>> getAllImages() async {
    QuerySnapshot snapshot = await dataBase
        .collection(AppTexts.imagesCollection)
        .where(isDeletedAttribute, isEqualTo: false)
        .get();

    return snapshot.docs
        .map((doc) => ImageModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<void> deleteImage(String imageId) async {
    try {
      await dataBase
          .collection(AppTexts.imagesCollection)
          .doc(imageId)
          .update({isDeletedAttribute: true});
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AppFormatException();
    } catch (e) {
      throw "Something went wrong please try agin later.";
    }
  }

  // ----------- Video Related Methods ------------
  Future<void> addVideo(VideoModel video) async {
    try {
      await dataBase
          .collection(AppTexts.videosCollection)
          .doc(video.videoId)
          .set(video.toMap());
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AppFormatException();
    } catch (e) {
      throw "Something went wrong please try agin later.";
    }
  }

  Future<VideoModel?> getVideoById(String videoId) async {
    try {
      DocumentSnapshot doc = await dataBase
          .collection(AppTexts.videosCollection)
          .doc(videoId)
          .get();
      if (doc.exists) {
        return VideoModel.fromMap(doc.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AppFormatException();
    } catch (e) {
      throw "Something went wrong please try agin later.";
    }
  }

  Future<void> deleteVideo(String videoId) async {
    try {
      await dataBase
          .collection(AppTexts.videosCollection)
          .doc(videoId)
          .update({isDeletedAttribute: true});
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AppFormatException();
    } catch (e) {
      throw "Something went wrong please try agin later.";
    }
  }

  Future<List<VideoModel>> getAllVideos() async {
    QuerySnapshot snapshot = await dataBase
        .collection(AppTexts.videosCollection)
        .where(isDeletedAttribute, isEqualTo: false)
        .get();

    return snapshot.docs
        .map((doc) => VideoModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // ----------- Profile Picture Related Methods ------------

  Future<void> updateProfilePicture(ProfilePicModel profilePicture) async {
    try {
      await dataBase
          .collection(AppTexts.profilePicsCollection)
          .doc(profilePicture.userId)
          .set(profilePicture.toMap(), SetOptions(merge: true));
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AppFormatException();
    } catch (e) {
      throw "Something went wrong please try agin later.";
    }
  }

  Future<ProfilePicModel?> getUserProfilePicture(String userId) async {
    try {
      DocumentSnapshot doc = await dataBase
          .collection(AppTexts.profilePicsCollection)
          .doc(userId)
          .get();
      if (doc.exists) {
        return ProfilePicModel.fromMap(doc.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AppFormatException();
    } catch (e) {
      throw "Something went wrong please try agin later.";
    }
  }

  // Collection Listeners

  void listenToImagesCollection(RxList<ImageModel> dataList, String userId) {
    try {
      dataBase
          .collection(AppTexts.imagesCollection)
          .where(userIdAttribute, isEqualTo: userId)
          .snapshots()
          .listen(
        (snapshot) {
          dataList.clear();
          for (var doc in snapshot.docs) {
            ImageModel image = ImageModel.fromMap(doc.data());
            if (!image.isDeleted) {
              dataList.add(image);
            }
          }
        },
      );
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AppFormatException();
    } catch (e) {
      throw "Something went wrong please try agin later.";
    }
  }

  void listenToVideoCollection(RxList<VideoModel> dataList, String userId) {
    try {
      dataBase
          .collection(AppTexts.videosCollection)
          .where(userIdAttribute, isEqualTo: userId)
          .snapshots()
          .listen(
        (snapshot) {
          dataList.clear();
          for (var doc in snapshot.docs) {
            VideoModel video = VideoModel.fromMap(doc.data());
            if (!video.isDeleted) {
              dataList.add(video);
            }
          }
        },
      );
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AppFormatException();
    } catch (e) {
      throw "Something went wrong please try again later.";
    }
  }
}
