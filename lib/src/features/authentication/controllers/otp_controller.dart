import 'package:get/get.dart';
import 'package:yol_al/src/features/ui/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String _verificationId;

  void verifyPhoneNumber(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        Get.offAll(const AnaSayfa());
      },
      verificationFailed: (FirebaseAuthException e) {
        Get.snackbar('Error', e.message ?? 'Verification failed');
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        Get.snackbar('OTP Sent', 'Please check your phone for the OTP');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  void verifyOTP(String otp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otp,
      );
      await _auth.signInWithCredential(credential);
      Get.offAll(const AnaSayfa());
    } catch (e) {
      Get.snackbar('Error', 'Invalid OTP');
    }
  }
}

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
}