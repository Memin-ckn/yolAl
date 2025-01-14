import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yol_al/src/features/authentication/screens/WelcomeScreen/welcome_screen.dart';
import 'package:yol_al/src/repository/user_repository/user_repository.dart';
import '../models/user_model.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  final userRepo = Get.put(UserRepository());

  void registerUser() async {
    final user = UserModel(
      email: email.text.trim(),
      password: password.text.trim(),
      fullName: fullName.text.trim(),
      phoneNo: phoneNo.text.trim(),
    );

    try {
      await userRepo.createUserWithEmailAndPassword(user);
      Get.to(() => const WelcomeScreen());
    } catch (e) {
      Get.showSnackbar(GetSnackBar(message: e.toString()));
    }
  }
}