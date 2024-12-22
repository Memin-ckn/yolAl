import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yol_al/src/features/authentication/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:yol_al/src/features/authentication/controllers/signup_controller.dart';
import 'package:yol_al/src/features/authentication/models/user_model.dart';
import 'package:yol_al/src/features/authentication/screens/signup/otp_screen.dart';

/* 
============ 
Get User and Pass It to Controller 
============ 
*/

class SignUpFormWidget extends StatelessWidget {
  //const SignUpFormWidget(key: _formKey('dfvbheridfhy'));
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());

    return Container(
      child: Form(
        key: _formKey, // FormKey burada kullanılıyor
        child: Column(
          children: [
            // Buraya form elemanlarını ekleyebilirsiniz
            // Örnek TextField
            TextFormField(
              controller: controller.email,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email alanı boş olamaz';
                }
                return null;
              },
            ),
            TextFormField(
              controller: controller.password,
              decoration: const InputDecoration(labelText: 'Şifre'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Şifre alanı boş olamaz';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Email & Şifre Doğrulama
                  final user = UserModel(
                    email: controller.email.text.trim(),
                    password: controller.password.text.trim(),
                    fullName: controller.fullName.text.trim(),
                    phoneNo: controller.phoneNo.text.trim(),
                  );
                  SignUpController.instance.createUser(user);
                  Get.to(() => const OTPScreen());
                }
              },
              child: const Text('Kayıt Ol'),
            ),
          ],
        ),
      ),
    );
  }
}
