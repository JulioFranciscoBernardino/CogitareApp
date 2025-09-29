import 'package:flutter/material.dart';
import '../widgets/common.dart';
import 'success.dart';

class CaregiverSignupFlow extends StatefulWidget {
  static const route = '/signup/caregiver';
  const CaregiverSignupFlow({super.key});

  @override
  State<CaregiverSignupFlow> createState() => _CaregiverSignupFlowState();
}

class _CaregiverSignupFlowState extends State<CaregiverSignupFlow> {
  final page = PageController();
  int index = 0;

  // step 1
  final nome = TextEditingController();
  final email = TextEditingController();
  final senha = TextEditingController();
  final conf = TextEditingController();
  final telefone = TextEditingController();
  final cep = TextEditingController();
  DateTime? nascimento;

  // step 2
  final licenca = TextEditingController();
  final especializacoes = <String>{"Enfermagem", "Fisioterapeuta"};
  final experiencias = <String>[];
  final cursos = <String>[];
  final disponibilidade = <String, bool>{
    "Seg Manhã": true,
    "Seg Tarde": false,
    "Seg Noite": false,
    "Ter Manhã": false,
    "Qua Noite": true,
  };

  // step 3
  final bio = TextEditingController();
  final valorHora = TextEditingController();

  void _next() => page.nextPage(duration: const Duration(milliseconds: 250), curve: Curves.ease);
  void _prev() => page.previousPage(duration: const Duration(milliseconds: 250), curve: Curves.ease);

  void _finish() {
    Navigator.pushReplacementNamed(context, SuccessScreen.route,
        arguments: "Cadastro realizado com sucesso!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {
          if (index == 0) Navigator.pop(context); else _prev();
        }),
        title: const Text("Criar conta"),
      ),
      body: PageView(
        controller: page,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (i) => setState(() => index = i),
        children: [
          _StepScaffold(
            index: 0, total: 3,
            child: Column(
              children: [
                LabeledField(label: "Nome Completo", hint: "Digite seu nome completo", controller: nome),
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
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _next, child: const Text("Continuar"))),
              ],
            ),
          ),
          _StepScaffold(
            index: 1, total: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabeledField(label: "Número da licença profissional", hint: "Digite aqui o número", controller: licenca),
                const SectionTitle("Especialização"),
                Wrap(
                  spacing: 8, runSpacing: 8,
                  children: ["Enfermagem","Fisioterapeuta","Técnico de Enfermagem","Cuidado Paliativo"]
                      .map((e) => FilterChip(
                    label: Text(e),
                    selected: especializacoes.contains(e),
                    onSelected: (v) {
                      setState(() {
                        if (v) especializacoes.add(e); else especializacoes.remove(e);
                      });
                    },
                  )).toList(),
                ),
                const SectionTitle("Disponibilidade (exemplo)"),
                Wrap(
                  spacing: 8,
                  children: disponibilidade.keys.map((k) =>
                    FilterChip(
                      label: Text(k),
                      selected: disponibilidade[k] ?? false,
                      onSelected: (v){ setState((){ disponibilidade[k]=v;}); },
                    )
                  ).toList(),
                ),
                const SizedBox(height: 16),
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _next, child: const Text("Continuar"))),
              ],
            ),
          ),
          _StepScaffold(
            index: 2, total: 3,
            child: Column(
              children: [
                Row(
                  children: const [
                    CircleAvatar(radius: 28, child: Icon(Icons.person)),
                    SizedBox(width: 12),
                    Text("Adicionar Foto"),
                  ],
                ),
                const SizedBox(height: 12),
                LabeledField(label: "Breve biografia", hint: "Escreva um pouco sobre você", controller: bio),
                const SizedBox(height: 10),
                LabeledField(label: "Valor por hora", hint: "Ex. R\$ 50,00", controller: valorHora, keyboard: TextInputType.number),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (_){}),
                    const Expanded(child: Text("Li e aceito os Termos de Uso")),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _finish, child: const Text("Cadastrar"))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StepScaffold extends StatelessWidget {
  final int index;
  final int total;
  final Widget child;
  const _StepScaffold({required this.index, required this.total, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            child,
            const SizedBox(height: 24),
            StepDots(total: total, index: index),
          ],
        ),
      ),
    );
  }
}
