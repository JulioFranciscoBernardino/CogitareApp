import 'package:flutter/material.dart';
import '../widgets/common.dart';
import 'caregiver_signup_screen.dart';
import 'guardian_signup_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  static const route = '/role';
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("COGITARE")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Spacer(),
            const Icon(Icons.person_2, size: 160),
            const SizedBox(height: 12),
            const Text("Eu sou...",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, CaregiverSignupScreen.route),
                child: const Text("CUIDADOR"),
              ),
            ),
            const SizedBox(height: 8),
            const Text("ou"),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, GuardianSignupScreen.route),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("RESPONSÁVEL"),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
