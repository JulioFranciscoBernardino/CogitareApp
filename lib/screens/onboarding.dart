import 'package:flutter/material.dart';
import 'role_selection.dart'; // ou a tela final que você quer chamar

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static String? get route => null;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Conecte-se com cuidadores de confiança",
      "image": "assets/images/onboarding1.png"
    },
    {
      "title": "Organize a rotina e a saúde",
      "image": "assets/images/onboarding2.png"
    },
    {
      "title": "Converse, combine e pague com segurança",
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
                      MaterialPageRoute(builder: (_) => const RoleSelectionScreen()),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (data["image"] != null)
                  Image.asset(data["image"]!, height: 300),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    data["title"]!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
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
