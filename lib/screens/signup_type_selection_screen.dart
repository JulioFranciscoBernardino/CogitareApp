import 'package:flutter/material.dart';
import 'caregiver_signup_screen.dart';
import 'guardian_signup_screen.dart';

class SignupTypeSelectionScreen extends StatelessWidget {
  static const route = '/signup-type-selection';
  const SignupTypeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar"),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green,
              Colors.white,
            ],
            stops: [0.0, 0.2],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const SizedBox(height: 40),

                // Ícone principal
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.person_add,
                    size: 50,
                    color: Colors.green,
                  ),
                ),

                const SizedBox(height: 32),

                const Text(
                  "Como você quer se cadastrar?",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),

                const Text(
                  "Selecione o tipo de conta que melhor descreve você",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),

                const Spacer(),

                // Opções de cadastro
                Column(
                  children: [
                    // Botão - Sou Cuidador
                    _buildTypeCard(
                      context: context,
                      title: "Sou Cuidador",
                      subtitle:
                          "Presto serviços de cuidados e quero me cadastrar",
                      icon: Icons.health_and_safety,
                      color: Colors.blue,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          CaregiverSignupScreen.route,
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    // Botão - Sou Responsável
                    _buildTypeCard(
                      context: context,
                      title: "Sou Responsável",
                      subtitle:
                          "Busco cuidados para meu familiar e quero me cadastrar",
                      icon: Icons.family_restroom,
                      color: Colors.orange,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          GuardianSignupScreen.route,
                        );
                      },
                    ),
                  ],
                ),

                const Spacer(),

                // Botão voltar
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Voltar",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypeCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(
                    icon,
                    size: 30,
                    color: color,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
