import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  static const route = '/success';
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final msg = ModalRoute.of(context)?.settings.arguments as String? ?? "Cadastro realizado com sucesso!";
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, size: 100, color: Colors.green),
            const SizedBox(height: 16),
            Text(msg, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
              child: const Text("Voltar ao início"),
            ),
          ],
        ),
      ),
    );
  }
}
