import 'package:flutter/material.dart';
import 'screens/tela_carregamento.dart';
import 'screens/selecao_papel.dart';
import 'screens/tela_login_unificada.dart';
import 'screens/tela_cadastro_cuidador.dart';
import 'screens/tela_cadastro_responsavel.dart';
import 'screens/tela_cadastro_idoso.dart';
import 'screens/tela_sucesso.dart';
import 'screens/tela_dashboard_responsavel.dart';
import 'screens/tela_dashboard_cuidador.dart';
import 'screens/tela_cuidadores_proximos.dart';
import 'screens/onboarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        fillColor: const Color(0xFFD9E7B5).withValues(alpha: 0.35),
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
        color: WidgetStatePropertyAll(Color(0xFF7FAE3E)),
        labelStyle: TextStyle(color: Colors.white),
      ),
    );

    return MaterialApp(
      home: const TelaCarregamento(),
      debugShowCheckedModeBanner: false,
      title: 'COGITARE',
      theme: theme,
      initialRoute: TelaCarregamento.route,
      routes: {
        TelaCarregamento.route: (_) => const TelaCarregamento(),
        '/onboarding': (_) => const OnboardingScreen(),
        '/role-selection': (_) => const SelecaoPapel(),
        TelaLoginUnificada.route: (_) => const TelaLoginUnificada(),
        TelaCadastroCuidador.route: (_) => const TelaCadastroCuidador(),
        TelaCadastroResponsavel.route: (_) => const TelaCadastroResponsavel(),
        TelaCadastroIdoso.route: (_) => const TelaCadastroIdoso(),
        TelaSucesso.route: (_) => const TelaSucesso(),
        TelaDashboardResponsavel.route: (_) => const TelaDashboardResponsavel(),
        TelaDashboardCuidador.route: (_) => const TelaDashboardCuidador(),
        TelaCuidadoresProximos.route: (_) => const TelaCuidadoresProximos(),
      },
    );
  }
}
