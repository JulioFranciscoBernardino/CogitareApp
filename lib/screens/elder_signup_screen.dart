import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/common.dart';
import '../models/elder.dart';
import '../services/elder_service.dart';
import 'success_screen.dart';

class ElderSignupScreen extends StatefulWidget {
  static const route = '/signup/elder';
  const ElderSignupScreen({super.key});

  @override
  State<ElderSignupScreen> createState() => _ElderSignupScreenState();
}

class _ElderSignupScreenState extends State<ElderSignupScreen> {
  final page = PageController();
  int index = 0;
  bool isLoading = false;
  int? guardianId;

  final nameController = TextEditingController();
  final medicalConditions = <String>{"Diabetes"};
  final restrictionsController = TextEditingController();
  final medicalCareController = TextEditingController();
  final extraDescriptionController = TextEditingController();
  bool specialCareNeeded = false;
  final careList = <String>{"Higiene", "Companhia", "Medicação"};
  final serviceType = <String>{"Enfermagem"};
  final availability = <String, bool>{"Seg Manhã": true, "Sex Noite": false};
  DateTime? birthDate;
  String? gender;
  int? mobilityId = 1; // Default: Independente
  int? autonomyLevelId = 1; // Default: Totalmente independente

  @override
  void initState() {
    super.initState();
    // Receive guardian ID passed as argument
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is int) {
        setState(() {
          guardianId = args;
        });
      }
    });
  }

  // Validations
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nome é obrigatório';
    }
    if (value.length < 2) {
      return 'Nome deve ter pelo menos 2 caracteres';
    }
    return null;
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          birthDate ?? DateTime.now().subtract(const Duration(days: 365 * 70)),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != birthDate) {
      setState(() {
        birthDate = picked;
      });
    }
  }

  bool _validateForm() {
    return _validateName(nameController.text) == null &&
        birthDate != null &&
        gender != null &&
        guardianId != null;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Erro'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _finish() async {
    if (!_validateForm()) {
      _showErrorDialog(
          'Por favor, preencha todos os campos obrigatórios corretamente.');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Create elder
      final elder = Elder(
        guardianId: guardianId,
        mobilityId: mobilityId,
        autonomyLevelId: autonomyLevelId,
        name: nameController.text,
        birthDate: birthDate,
        gender: gender,
        medicalCare: medicalCareController.text.isNotEmpty
            ? medicalCareController.text
            : null,
        extraDescription: extraDescriptionController.text.isNotEmpty
            ? extraDescriptionController.text
            : null,
      );

      // Create elder
      final response = await ElderService.createElder(elder);

      if (response['success'] == true) {
        Navigator.pushReplacementNamed(context, SuccessScreen.route,
            arguments: "Cadastro do idoso realizado com sucesso!");
      } else {
        _showErrorDialog(
            'Erro no cadastro: ${response['message'] ?? 'Erro desconhecido'}');
      }
    } catch (e) {
      _showErrorDialog('Erro no cadastro: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _next() => page.nextPage(
      duration: const Duration(milliseconds: 250), curve: Curves.ease);
  void _prev() => page.previousPage(
      duration: const Duration(milliseconds: 250), curve: Curves.ease);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (index == 0)
                Navigator.pop(context);
              else
                _prev();
            }),
        title: const Text("Dados do Idoso"),
      ),
      body: PageView(
        controller: page,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (i) => setState(() => index = i),
        children: [
          _Step(
              index: 0,
              total: 2,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Nome Completo do Idoso",
                      hintText: "Digite o nome completo",
                      errorText: _validateName(nameController.text) != null &&
                              nameController.text.isNotEmpty
                          ? _validateName(nameController.text)
                          : null,
                    ),
                    validator: _validateName,
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: _selectDate,
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: "Data de Nascimento *",
                        suffixIcon: const Icon(Icons.calendar_today),
                      ),
                      child: Text(
                        birthDate != null
                            ? DateFormat('dd/MM/yyyy').format(birthDate!)
                            : "Selecione a data de nascimento",
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: gender,
                    decoration: const InputDecoration(
                      labelText: "Sexo *",
                    ),
                    items: const [
                      DropdownMenuItem(
                          value: "Masculino", child: Text("Masculino")),
                      DropdownMenuItem(
                          value: "Feminino", child: Text("Feminino")),
                    ],
                    onChanged: (value) {
                      setState(() {
                        gender = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<int>(
                    value: mobilityId,
                    decoration: const InputDecoration(
                      labelText: "Nível de Mobilidade",
                    ),
                    items: const [
                      DropdownMenuItem(value: 1, child: Text("Independente")),
                      DropdownMenuItem(
                          value: 2, child: Text("Cadeira de rodas")),
                      DropdownMenuItem(value: 3, child: Text("Andador")),
                      DropdownMenuItem(value: 4, child: Text("Bengala")),
                      DropdownMenuItem(value: 5, child: Text("Auxílio total")),
                    ],
                    onChanged: (value) {
                      setState(() {
                        mobilityId = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<int>(
                    value: autonomyLevelId,
                    decoration: const InputDecoration(
                      labelText: "Nível de Autonomia",
                    ),
                    items: const [
                      DropdownMenuItem(
                          value: 1, child: Text("Totalmente independente")),
                      DropdownMenuItem(
                          value: 2, child: Text("Parcialmente independente")),
                      DropdownMenuItem(
                          value: 3,
                          child: Text("Dependente de auxílio moderado")),
                      DropdownMenuItem(
                          value: 4,
                          child: Text("Dependente de auxílio intensivo")),
                      DropdownMenuItem(
                          value: 5, child: Text("Totalmente dependente")),
                    ],
                    onChanged: (value) {
                      setState(() {
                        autonomyLevelId = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: medicalCareController,
                    decoration: const InputDecoration(
                      labelText: "Cuidados Médicos",
                      hintText: "Descreva os cuidados médicos necessários",
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: extraDescriptionController,
                    decoration: const InputDecoration(
                      labelText: "Descrição Extra",
                      hintText: "Informações adicionais sobre o idoso",
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: _validateForm() ? _next : null,
                          child: const Text("Continuar"))),
                ],
              )),
          _Step(
              index: 1,
              total: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle("Tipo de serviço desejado"),
                  Wrap(
                    spacing: 8,
                    children: ["Enfermagem", "Acompanhante"]
                        .map((e) => FilterChip(
                              label: Text(e),
                              selected: serviceType.contains(e),
                              onSelected: (v) {
                                setState(() {
                                  v
                                      ? serviceType.add(e)
                                      : serviceType.remove(e);
                                });
                              },
                            ))
                        .toList(),
                  ),
                  const SectionTitle(
                      "Dias e horários de necessidade (exemplo)"),
                  Wrap(
                    spacing: 8,
                    children: availability.keys
                        .map((k) => FilterChip(
                              label: Text(k),
                              selected: availability[k] ?? false,
                              onSelected: (v) {
                                setState(() {
                                  availability[k] = v;
                                });
                              },
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const CircleAvatar(radius: 28, child: Icon(Icons.person)),
                      const SizedBox(width: 12),
                      TextButton(
                          onPressed: () {},
                          child: const Text("Adicionar Foto do idoso")),
                    ],
                  ),
                  Row(children: [
                    Checkbox(value: true, onChanged: (_) {}),
                    const Expanded(child: Text("Li e aceito os Termos de Uso")),
                  ]),
                  const SizedBox(height: 8),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: isLoading ? null : _finish,
                          child: isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child:
                                      CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Text("Cadastrar"))),
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
