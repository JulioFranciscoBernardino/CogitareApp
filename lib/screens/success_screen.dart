import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  static const route = '/success';
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String message =
        ModalRoute.of(context)?.settings.arguments as String? ??
            "Operação realizada com sucesso!";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sucesso"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle,
                size: 100,
                color: Colors.green,
              ),
              const SizedBox(height: 24),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/',
                    (route) => false,
                  );
                },
                child: const Text("Voltar ao início"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
