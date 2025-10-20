import 'package:flutter/material.dart';
import 'onboarding.dart';
import 'selecao_papel.dart';
import 'tela_dashboard_cuidador.dart';
import 'tela_dashboard_responsavel.dart';
import '../services/servico_autenticacao.dart';

class TelaCarregamento extends StatefulWidget {
  static const route = '/carregamento';
  const TelaCarregamento({super.key});

  @override
  State<TelaCarregamento> createState() => _TelaCarregamentoState();
}

class _TelaCarregamentoState extends State<TelaCarregamento>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Configurar animações
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
    ));

    // Iniciar animação
    _animationController.forward();

    // Aguardar animação e analisar login
    _checkLoginAndNavigate();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _checkLoginAndNavigate() async {
    // Aguardar a animação terminar (2 segundos)
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    try {
      // Verificar se está logado
      final isLoggedIn = await ServicoAutenticacao.isLoggedIn();
      print('🔍 Logado: $isLoggedIn');

      // Verificar se está no processo de cadastro
      final isInSignupProcess = await ServicoAutenticacao.isInSignupProcess();
      print('🔍 Em processo de cadastro: $isInSignupProcess');

      // Verificar se é primeira vez
      final isFirstTime = await ServicoAutenticacao.isFirstTime();
      print('🔍 Primeira vez: $isFirstTime');

      Widget destination;

      if (isLoggedIn) {
        // Se está logado, vai para dashboard baseado no tipo
        print('🎯 Usuário logado - indo para dashboard');
        final userType = await ServicoAutenticacao.getUserType();
        if (userType == 'cuidador') {
          destination = const TelaDashboardCuidador();
        } else if (userType == 'responsavel') {
          destination = const TelaDashboardResponsavel();
        } else {
          destination = const SelecaoPapel();
        }
      } else if (isInSignupProcess) {
        // Se está no processo de cadastro, volta para seleção de papel
        print('🎯 Em processo de cadastro - indo para role selection');
        destination = const SelecaoPapel();
      } else if (isFirstTime) {
        // Se é primeira vez e não está logado, vai para onboarding
        print('🎯 Primeira vez - indo para onboarding');
        destination = const OnboardingScreen();
      } else {
        // Se já viu onboarding mas não está logado, vai para seleção de papel
        print(
            '🎯 Não é primeira vez e não está logado - indo para role selection');
        destination = const SelecaoPapel();
      }

      // Navegar para o destino
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                destination,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      }
    } catch (e) {
      print('Erro ao verificar login: $e');
      // Em caso de erro, vai para seleção de papel
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const SelecaoPapel(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo do Cogitare
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/images/logo_cogitare.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Texto COGITARE
                    const Text(
                      'COGITARE',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        letterSpacing: 2,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Subtítulo
                    const Text(
                      'Cuidando com carinho',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),

                    const SizedBox(height: 60),

                    // Indicador de carregamento
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.green.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
