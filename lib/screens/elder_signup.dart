import 'package:flutter/material.dart';
import '../widgets/common.dart';
import 'success.dart';

class ElderSignupFlow extends StatefulWidget {
  static const route = '/signup/elder';
  const ElderSignupFlow({super.key});

  @override
  State<ElderSignupFlow> createState() => _ElderSignupFlowState();
}

class _ElderSignupFlowState extends State<ElderSignupFlow> {
  final page = PageController();
  int index = 0;

  final nome = TextEditingController();
  final condicoes = <String>{"Diabetes"};
  final restricoes = TextEditingController();
  bool cuidadosEspeciais = false;
  final cuidadosList = <String>{"Higiene","Companhia","Medicação"};
  final tipoServico = <String>{"Enfermagem"};
  final disponibilidade = <String, bool>{"Seg Manhã": true, "Sex Noite": false};

  void _finish() {
    Navigator.pushReplacementNamed(context, SuccessScreen.route,
        arguments: "Cadastro realizado com sucesso!");
  }

  void _next() => page.nextPage(duration: const Duration(milliseconds: 250), curve: Curves.ease);
  void _prev() => page.previousPage(duration: const Duration(milliseconds: 250), curve: Curves.ease);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {
          if (index == 0) Navigator.pop(context); else _prev();
        }),
        title: const Text("Dados do Idoso"),
      ),
      body: PageView(
        controller: page,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (i) => setState(() => index = i),
        children: [
          _Step(index: 0, total: 2, child: Column(
            children: [
              LabeledField(label: "Nome Completo do Idoso", hint: "Digite o nome completo", controller: nome),
              const SizedBox(height: 10),
              const SectionTitle("Condições Médicas"),
              Wrap(
                spacing: 8, runSpacing: 8,
                children: ["Diabetes","Hipertensão","Dificuldade de locomoção","Alzheimer"].map((e) =>
                  FilterChip(label: Text(e),
                    selected: condicoes.contains(e),
                    onSelected: (v){ setState((){ v?condicoes.add(e):condicoes.remove(e); }); },
                  )
                ).toList(),
              ),
              const SizedBox(height: 12),
              LabeledField(label: "Restrições alimentares", hint: "Ex.: Sem lactose", controller: restricoes),
              const SizedBox(height: 16),
              Row(children: [
                const Text("Necessidades de cuidados especiais:  "),
                Switch(value: cuidadosEspeciais, onChanged: (v)=>setState(()=>cuidadosEspeciais=v)),
              ]),
              const SectionTitle("Quais?"),
              Wrap(
                spacing: 8,
                children: ["Higiene","Companhia","Medicação"].map((e) =>
                  FilterChip(label: Text(e),
                    selected: cuidadosList.contains(e),
                    onSelected: (v){ setState((){ v?cuidadosList.add(e):cuidadosList.remove(e); }); },
                  )
                ).toList(),
              ),
              const SizedBox(height: 16),
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _next, child: const Text("Continuar"))),
            ],
          )),
          _Step(index: 1, total: 2, child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle("Tipo de serviço desejado"),
              Wrap(
                spacing: 8,
                children: ["Enfermagem","Acompanhante"].map((e) =>
                  FilterChip(label: Text(e),
                    selected: tipoServico.contains(e),
                    onSelected: (v){ setState((){ v?tipoServico.add(e):tipoServico.remove(e); }); },
                  )
                ).toList(),
              ),
              const SectionTitle("Dias e horários de necessidade (exemplo)"),
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
              Row(
                children: [
                  const CircleAvatar(radius: 28, child: Icon(Icons.person)),
                  const SizedBox(width: 12),
                  TextButton(onPressed: (){}, child: const Text("Adicionar Foto do idoso")),
                ],
              ),
              Row(children: [
                Checkbox(value: true, onChanged: (_){ }),
                const Expanded(child: Text("Li e aceito os Termos de Uso")),
              ]),
              const SizedBox(height: 8),
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _finish, child: const Text("Cadastrar"))),
            ],
          )),
        ],
      ),
    );
  }
}

class _Step extends StatelessWidget {
  final int index;
  final int total;
  final Widget child;
  const _Step({required this.index, required this.total, required this.child});

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
