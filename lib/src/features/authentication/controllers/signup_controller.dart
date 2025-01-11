import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yol_al/src/features/authentication/screens/WelcomeScreen/welcome_screen.dart';
import 'package:yol_al/src/repository/authentication%20repository/authentication_repository.dart';
import 'package:yol_al/src/repository/user_repository/user_repository.dart';
import '../models/user_model.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  final userRepo = Get.put(UserRepository());
  final authRepo = Get.put(AuthenticationRepository());

  void registerUser(String email, String password) async {
    try {
      await authRepo.createUserWithEmailAndPassword(email, password);
      Get.to(() => const WelcomeScreen());
    } catch (e) {
      Get.showSnackbar(GetSnackBar(message: e.toString()));
    }
  }

  Future<void> createUser(UserModel user) async {
    await userRepo.createUser(user);
    Get.to(() => const WelcomeScreen()); // Navigate to a success screen or home screen
  }
}