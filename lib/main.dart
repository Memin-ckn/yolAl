import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:yol_al/src/features/authentication/screens/WelcomeScreen/welcome_screen.dart';
import 'package:yol_al/src/features/ui/screens/home/home_screen.dart';
import 'package:yol_al/src/features/ui/screens/settings/settings_menu.dart';
import 'package:yol_al/src/repository/authentication%20repository/authentication_repository.dart';
import 'firebase_options.dart';
import 'package:yol_al/src/features/authentication/screens/forgetPassword/forgot_password_screen.dart';
import 'package:yol_al/src/features/authentication/screens/signup/register_screen.dart';
import 'package:yol_al/src/features/authentication/screens/login/login_page.dart';
import 'package:yol_al/src/features/map/heatmap_page.dart';

// Mainde su flutterbinding firebase falan kalması lazım ona dikkat edelim
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomeScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/welcome': (context) => WelcomeScreen(),
        '/forgot_password': (context) => ForgotPasswordScreen(),
        '/register': (context) => RegisterScreen(),
        '/login': (context) => LoginScreen(),
        '/heatmap': (context) => HeatMapPage(),
        '/home': (context) => AnaSayfa(),
        '/settings': (context) => AyarlarPage(),
      },
    );
  }
}
