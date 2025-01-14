import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yol_al/src/features/authentication/controllers/signup_controller.dart';

class RegisterFormWidget extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  RegisterFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());

    return Form(
      key: _formKey,
      child: Column(
        children: [
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
                controller.registerUser();
              }
            },
            child: const Text('Kayıt Ol'),
          ),
        ],
      ),
    );
  }
}
