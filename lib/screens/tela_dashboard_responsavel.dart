import 'package:flutter/material.dart';
import '../widgets/widget_cuidadores_proximos.dart';
import '../widgets/widget_contrato_ativo.dart';
import '../widgets/widget_sugestao_contrato.dart';
import '../models/responsavel.dart';
import '../models/contrato.dart';
import '../models/cuidador_proximo.dart';
import '../services/servico_contrato.dart';
import '../services/servico_cuidadores_proximos.dart';
import '../services/servico_autenticacao.dart';

class TelaDashboardResponsavel extends StatefulWidget {
  static const route = '/dashboard-responsavel';
  const TelaDashboardResponsavel({super.key});

  @override
  State<TelaDashboardResponsavel> createState() =>
      _TelaDashboardResponsavelState();
}

class _TelaDashboardResponsavelState extends State<TelaDashboardResponsavel> {
  Contrato? _activeContract;
  List<CuidadorProximo> _suggestedCaregivers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Carregar contrato ativo
      final contract = await ServicoContrato.getActiveContrato(
          _getMockResponsavel().id ?? 1);

      // Se não tem contrato ativo, carregar sugestões de cuidadores
      List<CuidadorProximo> suggestions = [];
      if (contract == null) {
        suggestions = await ServicoCuidadoresProximos.getCuidadorProximos(
          _getMockResponsavel(),
          maxDistanceKm: 50.0,
          limit: 3,
        );
      }

      setState(() {
        _activeContract = contract;
        _suggestedCaregivers = suggestions;
        _isLoading = false;
      });
    } catch (e) {
      print('Erro ao carregar dados do dashboard: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header com logo e notificação
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  // Logo COGITARE horizontal
                  SizedBox(
                    height: 40,
                    child: Image.asset(
                      'assets/images/logo_cogitare_horizontal.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Spacer(),
                  // Ícone de notificação
                  IconButton(
                    onPressed: () {
                      // Implementar notificações
                    },
                    icon: const Icon(
                      Icons.notifications_outlined,
                      color: Color(0xFF28323C),
                      size: 24,
                    ),
                  ),
                  // Botão de logout
                  IconButton(
                    onPressed: _handleLogout,
                    icon: const Icon(
                      Icons.logout,
                      color: Color(0xFF28323C),
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),

            // Conteúdo principal
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Seção de boas-vindas
                    Row(
                      children: [
                        // Foto do usuário
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFE0E0E0),
                          ),
                          child: const Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Bem-vindo (a), João Maria',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Seção de Contratação ou Sugestão
                    if (_isLoading)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else if (_activeContract != null)
                      WidgetContratoAtivo(
                        contract: _activeContract!,
                        onChatTap: () {
                          // Implementar navegação para chat
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Abrindo chat com o cuidador...'),
                            ),
                          );
                        },
                        onViewDetailsTap: () {
                          // Implementar navegação para detalhes
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Visualizando detalhes do contrato...'),
                            ),
                          );
                        },
                      )
                    else if (_suggestedCaregivers.isNotEmpty)
                      WidgetSugestaoContrato(
                        suggestedCaregivers: _suggestedCaregivers,
                        onViewAllTap: () {
                          // Navegar para tela de cuidadores próximos
                          Navigator.pushNamed(context, '/nearby-caregivers');
                        },
                        onCaregiverTap: (caregiver) {
                          // Navegar para detalhes do cuidador
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Visualizando ${caregiver.caregiver.name}'),
                            ),
                          );
                        },
                      )
                    else
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Colors.grey.shade600,
                              size: 32,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Nenhum cuidador disponível no momento',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Tente novamente mais tarde ou entre em contato conosco.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 24),

                    // Seção Acesso rápido
                    Row(
                      children: [
                        const Icon(
                          Icons.flash_on,
                          color: Color(0xFF28323C),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Acesso rápido',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF28323C),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Grid de botões de acesso rápido
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 2.5,
                      children: [
                        _buildQuickAccessButton(
                          icon: Icons.search,
                          text: 'Buscar Cuidadores',
                          onTap: () {},
                        ),
                        _buildQuickAccessButton(
                          icon: Icons.account_balance_wallet,
                          text: 'Financeiro',
                          onTap: () {},
                        ),
                        _buildQuickAccessButton(
                          icon: Icons.chat,
                          text: 'Chat',
                          onTap: () {},
                        ),
                        _buildQuickAccessButton(
                          icon: Icons.history,
                          text: 'Histórico',
                          onTap: () {},
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Widget de cuidadores próximos
                    WidgetCuidadoresProximos(
                      guardian: _getMockResponsavel(),
                      maxDistanceKm:
                          999999.0, // Busca em qualquer lugar do mundo
                      limit: 2,
                      onCaregiverTap: (caregiver) {
                        // Implementar navegação para detalhes do cuidador
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Cuidador: ${caregiver.caregiver.name}'),
                          ),
                        );
                      },
                      onSeeMoreTap: () {
                        // Implementar navegação para lista completa
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Ver mais cuidadores'),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Barra de navegação inferior
      bottomNavigationBar: Container(
        height: 60,
        decoration: const BoxDecoration(
          color: Color(0xFF28323C),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, true),
            _buildNavItem(Icons.mail_outline, false),
            _buildNavItem(Icons.calendar_today, false),
            _buildNavItem(Icons.chat_bubble_outline, false),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAccessButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF28323C),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para criar um responsável mock (em um app real, isso viria do estado global)
  Responsavel _getMockResponsavel() {
    return Responsavel(
      id: 1,
      addressId: 1,
      cpf: '123.456.789-00',
      name: 'João Maria',
      email: 'joao@email.com',
      phone: '(11) 99999-9999',
      birthDate: DateTime(1980, 1, 1),
      photoUrl: null,
    );
  }

  Widget _buildNavItem(IconData icon, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Icon(
        icon,
        color: isSelected ? Colors.white : Colors.white70,
        size: 24,
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
        '/role-selection',
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
