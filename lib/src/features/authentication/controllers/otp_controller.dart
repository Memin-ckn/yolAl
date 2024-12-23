import 'package:get/get.dart';
import 'package:yol_al/src/features/authentication/screens/WelcomeScreen/welcome_screen.dart';
import 'package:yol_al/src/repository/authentication%20repository/authentication_repository.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  void verifyOTP(String otp) async{
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAll(const WelcomeScreen()) : Get.back(); // welcome yerine home yaizlacak
  }
  
}


/*
import 'package:firebase_auth/firebase_auth.dart';

class PhoneAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhoneNumber(
      String phoneNumber,
      Function(String verificationId) onCodeSent,
      Function(FirebaseAuthException e) onVerificationFailed) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto sign-in if possible
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: onVerificationFailed,
      codeSent: (String verificationId, int? resendToken) {
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Handle timeout if needed
      },
    );
  }
} */
