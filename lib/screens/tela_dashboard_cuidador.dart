import 'package:flutter/material.dart';
import '../services/servico_autenticacao.dart';

class TelaDashboardCuidador extends StatefulWidget {
  static const route = '/dashboard-cuidador';
  const TelaDashboardCuidador({super.key});

  @override
  State<TelaDashboardCuidador> createState() => _TelaDashboardCuidadorState();
}

class _TelaDashboardCuidadorState extends State<TelaDashboardCuidador> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header com logo
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  SizedBox(
                    height: 40,
                    child: Image.asset(
                      'assets/images/logo_cogitare_horizontal.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Spacer(),
                  // Botão de perfil/logout
                  IconButton(
                    onPressed: _handleLogout,
                    icon: const Icon(Icons.logout, color: Colors.black87),
                  ),
                ],
              ),
            ),

            // Conteúdo principal
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Mensagem de boas-vindas
                    const Text(
                      'Bem-vindo(a), Cuidador!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Conecte-se com famílias que precisam do seu cuidado.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Cards de funcionalidades
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        children: [
                          _buildFeatureCard(
                            icon: Icons.work,
                            title: 'Meus Serviços',
                            subtitle: 'Gerencie ofertas',
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Funcionalidade em desenvolvimento'),
                                ),
                              );
                            },
                          ),
                          _buildFeatureCard(
                            icon: Icons.calendar_month,
                            title: 'Agenda',
                            subtitle: 'Seus agendamentos',
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Funcionalidade em desenvolvimento'),
                                ),
                              );
                            },
                          ),
                          _buildFeatureCard(
                            icon: Icons.message,
                            title: 'Conversas',
                            subtitle: 'Chat com responsáveis',
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Funcionalidade em desenvolvimento'),
                                ),
                              );
                            },
                          ),
                          _buildFeatureCard(
                            icon: Icons.analytics,
                            title: 'Relatórios',
                            subtitle: 'Suas estatísticas',
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Funcionalidade em desenvolvimento'),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: const Color(0xFF28323C),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleLogout() async {
    // Mostrar diálogo de confirmação
    final bool? shouldLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sair'),
          content: const Text('Tem certeza que deseja sair da sua conta?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Sair'),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true) {
      // Limpar dados de login
      await ServicoAutenticacao.clearLoginData();

      // Navegar para tela de seleção de papel
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/selecao-papel',
        (route) => false,
      );

      // Mostrar mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logout realizado com sucesso'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}
