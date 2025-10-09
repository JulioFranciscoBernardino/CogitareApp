import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/main_selection_screen.dart';
import 'screens/signup_type_selection_screen.dart';
import 'screens/role_selection.dart';
import 'screens/unified_login_screen.dart';
import 'screens/caregiver_signup_screen.dart';
import 'screens/guardian_signup_screen.dart';
import 'screens/elder_signup_screen.dart';
import 'screens/success_screen.dart';

void main() {
  runApp(const CogitareApp());
}

class CogitareApp extends StatelessWidget {
  const CogitareApp({super.key});

  static const Color brandGreen = Color(0xFFA5C04E);
  static const Color brandNavy = Color(0xFF28323C);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: brandGreen),
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFF6F7F8),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFD9E7B5).withOpacity(.35),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintStyle: const TextStyle(color: Colors.black54),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: brandNavy,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      chipTheme: const ChipThemeData(
        color: MaterialStatePropertyAll(Color(0xFF7FAE3E)),
        labelStyle: TextStyle(color: Colors.white),
      ),
    );

    return MaterialApp(
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      title: 'COGITARE',
      theme: theme,
      initialRoute: SplashScreen.route,
      routes: {
        SplashScreen.route: (_) => const SplashScreen(),
        MainSelectionScreen.route: (_) => const MainSelectionScreen(),
        SignupTypeSelectionScreen.route: (_) =>
            const SignupTypeSelectionScreen(),
        RoleSelectionScreen.route: (_) => const RoleSelectionScreen(),
        UnifiedLoginScreen.route: (_) => const UnifiedLoginScreen(),
        CaregiverSignupScreen.route: (_) => const CaregiverSignupScreen(),
        GuardianSignupScreen.route: (_) => const GuardianSignupScreen(),
        ElderSignupScreen.route: (_) => const ElderSignupScreen(),
        SuccessScreen.route: (_) => const SuccessScreen(),
      },
    );
  }
}
