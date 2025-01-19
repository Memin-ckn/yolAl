import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:yol_al/src/features/authentication/screens/WelcomeScreen/welcome_screen.dart';
import 'package:yol_al/src/features/ui/screens/profile/profile_screen.dart';
import 'package:yol_al/src/features/ui/screens/settings/settings_menu.dart';
import 'package:yol_al/src/repository/authentication%20repository/authentication_repository.dart';
import 'package:yol_al/src/features/authentication/screens/forgetPassword/forgot_password_screen.dart';
import 'package:yol_al/src/features/authentication/screens/signup/register_screen.dart';
import 'package:yol_al/src/features/authentication/screens/login/login_page.dart';
import 'package:yol_al/src/features/map/screens/heatmap_page.dart';
import 'package:yol_al/src/features/ui/screens/job_post/category_selection_page.dart';
import 'package:yol_al/src/features/ui/screens/job_post/form_carrier_page.dart';
import 'package:yol_al/src/features/ui/screens/job_post/form_employer_page.dart';
import 'package:yol_al/src/features/ui/screens/job_post/marketplace_page.dart';
import 'package:yol_al/src/features/ui/screens/profile/favorites_page.dart';
import 'firebase_options.dart';

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
    return GetMaterialApp( // MaterialApp yerine GetMaterialApp kullanıyoruz
      debugShowCheckedModeBanner: false,
      initialRoute: '/welcome', // İlk açılışta yönlendirme
      getPages: [
        // Navigasyon rotaları
        GetPage(name: '/welcome', page: () => WelcomeScreen()),
        GetPage(name: '/forgot_password', page: () => ForgotPasswordScreen()),
        GetPage(name: '/register', page: () => RegisterScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/heatmap', page: () => HeatMapPage()), // Harita sayfası
        GetPage(name: '/category_selection', page: () => CategorySelectionPage()),
        GetPage(name: '/carrier_form', page: () => FormCarrierPage()), // Taşıyıcı formu
        GetPage(name: '/employer_form', page: () => FormEmployerPage()), // İş veren formu
        GetPage(name: '/profile', page: () => HesabimPage()),
        GetPage(name: '/settings', page: () => AyarlarPage()),
        GetPage(name: '/marketplace', page:() => MarketplacePage()),
        GetPage(name: '/favorites', page: () => const FavoritesPage()),

      ],
    );
  }
}
