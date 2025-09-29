import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'screens/onboarding.dart';
import 'screens/role_selection.dart';
import 'screens/login.dart';
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
      home: OnboardingScreen(),
      debugShowCheckedModeBanner: false,
      title: 'COGITARE',
      theme: theme,
      initialRoute: OnboardingScreen.route,
      routes: {
        RoleSelectionScreen.route: (_) => const RoleSelectionScreen(),
        LoginScreen.route: (_) => const LoginScreen(),
        CaregiverSignupScreen.route: (_) => const CaregiverSignupScreen(),
        GuardianSignupScreen.route: (_) => const GuardianSignupScreen(),
        ElderSignupScreen.route: (_) => const ElderSignupScreen(),
        SuccessScreen.route: (_) => const SuccessScreen(),
      },
    );
  }
}
