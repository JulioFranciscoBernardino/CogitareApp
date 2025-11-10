import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TelaPropostasRecebidas extends StatelessWidget {
  static const route = '/propostas-recebidas';

  const TelaPropostasRecebidas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xFF424242),
                    ),
                  ),
                  const SizedBox(width: 4),

                  // LOGO
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/logo_cogitare_horizontal.png",
                          height: 40,
                        ),
                        ],
                    ),
                  ),
                  const SizedBox(width: 40), // balanceamento visual
                ],
              ),
            ),

            const SizedBox(height: 8),

            // TÍTULO
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Propostas\nRecebidas",
                style: TextStyle(
                  fontSize: 28,
                  height: 1.1,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF28323C),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // CARD DE PROPOSTA
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    // Avatar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        "assets/images/exemplo_idoso.png",
                        height: 48,
                        width: 48,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Texto
                    const Expanded(
                      child: Text(
                        "João Maria tem uma proposta",
                        style: TextStyle(
                          color: Color(0xFF28323C),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    // Botão VER
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF495866),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        // Navegar para detalhes da proposta
                        HapticFeedback.lightImpact();
                      },
                      child: const Text(
                        "Ver",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // LINHA SUTIL
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 1,
                color: const Color(0xFFD9D9D9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
