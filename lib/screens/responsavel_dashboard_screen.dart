import 'package:flutter/material.dart';

class ResponsavelDashboardScreen extends StatelessWidget {
  static const route = '/responsavel-dashboard';
  const ResponsavelDashboardScreen({super.key});

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
                    onPressed: () {
                      // Implementar logout
                      Navigator.pushReplacementNamed(context, '/unified-login');
                    },
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
                      'Bem-vindo(a), Responsável!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Gerencie os cuidados da sua família com carinho.',
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
                            icon: Icons.person_add,
                            title: 'Cadastrar Idoso',
                            subtitle: 'Adicione um familiar',
                            onTap: () {
                              // Navegar para cadastro de idoso
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Funcionalidade em desenvolvimento'),
                                ),
                              );
                            },
                          ),
                          _buildFeatureCard(
                            icon: Icons.search,
                            title: 'Buscar Cuidador',
                            subtitle: 'Encontre profissionais',
                            onTap: () {
                              // Navegar para busca de cuidadores
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Funcionalidade em desenvolvimento'),
                                ),
                              );
                            },
                          ),
                          _buildFeatureCard(
                            icon: Icons.calendar_today,
                            title: 'Agendamentos',
                            subtitle: 'Gerencie horários',
                            onTap: () {
                              // Navegar para agendamentos
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
                            subtitle: 'Chat com cuidadores',
                            onTap: () {
                              // Navegar para conversas
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
}
