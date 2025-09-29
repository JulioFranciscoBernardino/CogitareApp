import 'package:flutter/material.dart';
import '../widgets/common.dart';
import 'elder_signup.dart';

class GuardianSignupFlow extends StatefulWidget {
  static const route = '/signup/guardian';
  const GuardianSignupFlow({super.key});

  @override
  State<GuardianSignupFlow> createState() => _GuardianSignupFlowState();
}

class _GuardianSignupFlowState extends State<GuardianSignupFlow> {
  final nome = TextEditingController();
  final email = TextEditingController();
  final senha = TextEditingController();
  final conf = TextEditingController();
  final telefone = TextEditingController();
  final cep = TextEditingController();

  void _next() {
    Navigator.pushReplacementNamed(context, ElderSignupFlow.route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.pop(context)),
        title: const Text("Criar conta"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              LabeledField(label: "Nome Completo do Responsável", hint: "Digite seu nome completo", controller: nome),
              const SizedBox(height: 10),
              LabeledField(label: "E-mail", hint: "Digite seu e-mail", controller: email, keyboard: TextInputType.emailAddress),
              const SizedBox(height: 10),
              LabeledField(label: "Senha", hint: "Digite sua senha", controller: senha, obscure: true),
              const SizedBox(height: 10),
              LabeledField(label: "Confirmar senha", hint: "Confirme sua senha", controller: conf, obscure: true),
              const SizedBox(height: 10),
              LabeledField(label: "Telefone", hint: "Digite seu telefone", controller: telefone, keyboard: TextInputType.phone),
              const SizedBox(height: 10),
              LabeledField(label: "CEP", hint: "Digite seu CEP", controller: cep, keyboard: TextInputType.number),
              const SizedBox(height: 16),
              StepDots(total: 1, index: 0),
              const SizedBox(height: 16),
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _next, child: const Text("Continuar para cadastro do Idoso"))),
            ],
          ),
        ),
      ),
    );
  }
}
