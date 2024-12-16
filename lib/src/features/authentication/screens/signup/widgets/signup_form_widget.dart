import 'package:flutter/widgets.dart';
import 'package:yol_al/src/features/authentication/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:yol_al/src/features/authentication/controllers/signup_controller.dart';
import 'package:yol_al/src/features/authentication/models/user_model.dart';
/* 
============
Get User and Pass It to Controller
============
*/

class SignUpFormWidget extends StatelessWidget{
  const SignUpFormWidget ({
    super.key,
  });
}

@override
Widget build(BuildContext context){
  final controller = Get.put(SignUpController());
  final formKey = GlobalKey<FormState>();

  return Container(
    /* ... */
    // Aşağıdaki onPressed kayıt ol formunun kayıt ol tuşuna atanacak
    /* onPressed: (){
      if (formKey.currentState!.validate()){
        // Email & Password Auth
        // Phone Auth
      
      final user = UserModel(
        email: controller.email.text.trim(),
        password: controller.password.text.trim(),
        fullName: controller.fullName.text.trim(),
        phoneNo: controller.phoneNo.text.trim(),
      );
      SignUpController.instance.createUser(user);

      Get.to(() => const OTPScreen());
      }
    } */
  );
}
