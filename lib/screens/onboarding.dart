import 'package:flutter/material.dart';
import 'main_selection_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static String? get route => null;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> onboardingData = [
    {
      "title": "Conecte-se a cuidadores de confiança",
      "subtitle":
          "Encontre profissionais verificados perto de você, com experiência e avaliações reais.",
      "benefits": [
        "Perfis verificados e com certificados.",
        "Avaliações e comentários de famílias.",
        "Mensagem direta com os cuidadores pelo app."
      ],
      "image": "assets/images/onboarding1.png"
    },
    {
      "title": "Organize a rotina e a saúde",
      "subtitle": "",
      "benefits": [],
      "image": "assets/images/onboarding2.png"
    },
    {
      "title": "Converse, combine e pague com segurança",
      "subtitle": "",
      "benefits": [],
      "image": "assets/images/onboarding3.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) => setState(() => _currentPage = index),
        itemCount: onboardingData.length + 1, // +1 para tela final
        itemBuilder: (context, index) {
          if (index == onboardingData.length) {
            // Tela final
            return Container(
              color: Colors.white,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const MainSelectionScreen()),
                    );
                  },
                  child: const Text("Vamos começar?"),
                ),
              ),
            );
          }

          final data = onboardingData[index];
          return Container(
            color: Colors.white,
            child: Column(
              children: [
                // Cabeçalho com logo e botão Pular
                _buildHeader(),

                // Conteúdo principal
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),

                        // Título principal
                        Text(
                          data["title"] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF28323C),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Subtítulo (apenas para primeira tela)
                        if (data["subtitle"] != null &&
                            (data["subtitle"] as String).isNotEmpty)
                          Text(
                            data["subtitle"] as String,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              height: 1.4,
                            ),
                          ),

                        // Lista de benefícios (apenas para primeira tela)
                        if (data["benefits"] != null &&
                            (data["benefits"] as List).isNotEmpty) ...[
                          const SizedBox(height: 24),
                          ...((data["benefits"] as List)
                              .map((benefit) => Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "• ",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            benefit as String,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey,
                                              height: 1.4,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))),
                        ],

                        const SizedBox(height: 30),

                        // Imagem
                        if (data["image"] != null)
                          SizedBox(
                            width: double.infinity,
                            child: Image.asset(
                              data["image"] as String,
                              fit: BoxFit.fitWidth,
                            ),
                          ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: _buildDots(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 50, 24, 20),
      child: Row(
        children: [
          // Logo horizontal
          SizedBox(
            height: 40,
            child: Image.asset(
              'assets/images/logo_cogitare_horizontal.png',
              fit: BoxFit.contain,
            ),
          ),

          const Spacer(),

          // Botão Pular
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const MainSelectionScreen()),
              );
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.black87,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Pular',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        onboardingData.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 20),
          height: 8,
          width: _currentPage == index ? 24 : 8,
          decoration: BoxDecoration(
            color: _currentPage == index ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
