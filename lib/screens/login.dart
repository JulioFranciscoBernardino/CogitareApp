import 'package:flutter/material.dart';
import '../widgets/common.dart';
import '../main.dart';
import 'success.dart';

class LoginScreen extends StatefulWidget {
  static const route = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final pass = TextEditingController();
  String? emailErr;
  String? passErr;

  void _submit() {
    setState(() {
      emailErr = (email.text.contains('@')) ? null : "E-mail incorreto ou inválido";
      passErr = (pass.text.length >= 6) ? null : "Senha incorreta ou inválida";
    });
    if (emailErr == null && passErr == null) {
      Navigator.pushReplacementNamed(context, SuccessScreen.route,
          arguments: "Login simulado com sucesso!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("COGITARE")),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Cuidado com carinho.", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              const Text("LOGIN", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              LabeledField(label: "E-mail", hint: "Digite seu e-mail", controller: email,
                keyboard: TextInputType.emailAddress),
              if (emailErr != null) Padding(
                padding: const EdgeInsets.only(top: 6, left: 4),
                child: Text(emailErr!, style: const TextStyle(color: Colors.red)),
              ),
              const SizedBox(height: 12),
              LabeledField(label: "Senha", hint: "Digite sua senha", controller: pass, obscure: true),
              if (passErr != null) Padding(
                padding: const EdgeInsets.only(top: 6, left: 4),
                child: Text(passErr!, style: const TextStyle(color: Colors.red)),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: _submit, child: const Text("Entrar")),
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  _SocialButton(icon: Icons.g_mobiledata, text: "Google"),
                  _SocialButton(icon: Icons.facebook, text: "Facebook"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String text;
  const _SocialButton({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon),
      label: Text(text),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
