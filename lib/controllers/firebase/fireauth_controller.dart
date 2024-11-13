import 'package:detect_fakes/controllers/appdata/profilepic_controller.dart';
import 'package:detect_fakes/controllers/appdata/user_controller.dart';
import 'package:detect_fakes/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:detect_fakes/utils/exceptions/platform_exceptions.dart';
import 'package:detect_fakes/utils/exceptions/firebase_exceptions.dart';
import 'package:detect_fakes/screens/account/verifyemail_screen.dart';
import 'package:detect_fakes/utils/exceptions/format_exceptions.dart';
import 'package:detect_fakes/screens/account/login_screen.dart';
import 'package:detect_fakes/screens/main/home_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FireAuthController extends GetxController {
  static FireAuthController get instance => Get.find();

  final deviceStorage = GetStorage();
  final FirebaseAuth authenticator = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  void onReady() {
    screenRedirect();
  }

  Future<void> screenRedirect() async {
    User? user = authenticator.currentUser;
    if (user != null) {
      if (isAnonymousUser()) {
        Get.offAll(() => const HomeScreen());
      } else {
        bool isEmailVerified = await isUserEmailVerified();
        if (isEmailVerified) {
          Get.offAll(() => const HomeScreen());
        } else {
          Get.offAll(
            () => VerifyEmailScreen(email: user.email!),
          );
        }
      }
    } else {
      Get.offAll(() => const LoginScreen());
    }
  }

  User? get currentUser {
    return authenticator.currentUser;
  }

  String? get currentUserId {
    return authenticator.currentUser?.uid;
  }

  bool isAnonymousUser() {
    User? user = authenticator.currentUser;
    if (user != null && user.isAnonymous) {
      return true;
    }
    return false;
  }

  bool isGoogleUser() {
    User? user = authenticator.currentUser;

    if (user != null) {
      for (var providerProfile in user.providerData) {
        if (providerProfile.providerId == 'google.com') {
          return true;
        }
      }
    }
    return false;
  }

  Future<bool> isUserEmailVerified() async {
    User? user = authenticator.currentUser;
    if (user != null) {
      await user.reload();
      if (user.emailVerified) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await authenticator.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthException(e.code).message;
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

  Future<User?> signUpWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await authenticator.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthException(e.code).message;
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

  Future<void> sendEmailVerification() async {
    try {
      await authenticator.currentUser!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthException(e.code).message;
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

  Future<void> signOut() async {
    try {
      Get.delete<UserController>(force: true);
      Get.delete<ProfilePicController>(force: true);
      await authenticator.signOut();
      await googleSignIn.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthException(e.code).message;
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

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await authenticator.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthException(e.code).message;
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

  Future<bool> reauthenticateUser(String email, String password) async {
    try {
      final User? user = authenticator.currentUser;
      if (user != null) {
        final AuthCredential credential =
            EmailAuthProvider.credential(email: email, password: password);
        await user.reauthenticateWithCredential(credential);
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthException(e.code).message;
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

  Future<void> updatePassword(String newPassword) async {
    try {
      User? user = authenticator.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
      }
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthException(e.code).message;
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

  Future<void> updateEmail(String newEmail) async {
    User? user = authenticator.currentUser;
    if (user != null) {
      await user.updateEmail(newEmail);
    }
  }

  Future<User?> signInAnonymously() async {
    try {
      UserCredential userCredential = await authenticator.signInAnonymously();
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthException(e.code).message;
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

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await authenticator.signInWithCredential(credential);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AppFormatException();
    } on PlatformException catch (e) {
      throw AppPlatformException(e.code).message;
    } catch (e) {
      return null;
    }
  }
}
