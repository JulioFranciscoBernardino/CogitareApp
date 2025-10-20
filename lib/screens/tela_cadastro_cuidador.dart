import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/widgets_comuns.dart';
import '../models/cuidador.dart';
import '../models/endereco.dart';
import '../services/servico_cuidador.dart';
import '../utils/validadores.dart';
import 'tela_sucesso.dart';

class TelaCadastroCuidador extends StatefulWidget {
  static const route = '/cadastro-cuidador';
  const TelaCadastroCuidador({super.key});

  @override
  State<TelaCadastroCuidador> createState() => _TelaCadastroCuidadorState();
}

class _TelaCadastroCuidadorState extends State<TelaCadastroCuidador> {
  final page = PageController();
  int index = 0;
  bool isLoading = false;

  // step 1
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final cpfController = TextEditingController();
  final zipCodeController = TextEditingController();
  final cityController = TextEditingController();
  final neighborhoodController = TextEditingController();
  final streetController = TextEditingController();
  final numberController = TextEditingController();
  final complementController = TextEditingController();
  DateTime? birthDate;

  // step 2
  final licenseController = TextEditingController();
  final specializations = <String>{"Enfermagem", "Fisioterapeuta"};
  final experiences = <String>[];
  final courses = <String>[];
  final availability = <String, bool>{
    "Seg Manhã": true,
    "Seg Tarde": false,
    "Seg Noite": false,
    "Ter Manhã": false,
    "Qua Noite": true,
  };

  // step 3
  final bioController = TextEditingController();
  final hourlyRateController = TextEditingController();

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

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'E-mail é obrigatório';
    }
    if (!Validators.isValidEmail(value)) {
      return 'E-mail inválido';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Senha é obrigatória';
    }
    if (value.length < 6) {
      return 'Senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirmação de senha é obrigatória';
    }
    if (value != passwordController.text) {
      return 'Senhas não coincidem';
    }
    return null;
  }

  String? _validateCPF(String? value) {
    if (value == null || value.isEmpty) {
      return 'CPF é obrigatório';
    }
    if (!Validators.isValidCPF(value)) {
      return 'CPF inválido';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Telefone é obrigatório';
    }
    return null;
  }

  String? _validateZipCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'CEP é obrigatório';
    }
    if (value.length != 8) {
      return 'CEP deve ter 8 dígitos';
    }
    return null;
  }

  void _next() => page.nextPage(
      duration: const Duration(milliseconds: 250), curve: Curves.ease);
  void _prev() => page.previousPage(
      duration: const Duration(milliseconds: 250), curve: Curves.ease);

  Future<void> _finish() async {
    if (!_validateForm()) return;

    setState(() {
      isLoading = true;
    });

    try {
      // Create address
      final address = Endereco(
        city: cityController.text,
        neighborhood: neighborhoodController.text,
        street: streetController.text,
        number: numberController.text,
        complement: complementController.text,
        zipCode: zipCodeController.text,
      );

      // Create caregiver
      final caregiver = Cuidador(
        cpf: cpfController.text,
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        password: passwordController.text,
        birthDate: birthDate,
        biography: bioController.text,
        smokes: 'Não', // Default
        hasChildren: 'Não', // Default
        hasDrivingLicense: 'Não', // Default
        hasCar: 'Não', // Default
      );

      // Create caregiver
      final response = await ServicoCuidador.createComplete(
        address: address,
        caregiver: caregiver,
      );

      if (response['success'] == true) {
        Navigator.pushReplacementNamed(context, TelaSucesso.route,
            arguments: "Cadastro do cuidador realizado com sucesso!");
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

  bool _validateForm() {
    return _validateName(nameController.text) == null &&
        _validateEmail(emailController.text) == null &&
        _validatePassword(passwordController.text) == null &&
        _validateConfirmPassword(confirmPasswordController.text) == null &&
        _validateCPF(cpfController.text) == null &&
        _validatePhone(phoneController.text) == null &&
        _validateZipCode(zipCodeController.text) == null &&
        birthDate != null;
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

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          birthDate ?? DateTime.now().subtract(const Duration(days: 365 * 25)),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != birthDate) {
      setState(() {
        birthDate = picked;
      });
    }
  }

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
        title: const Text("Criar conta"),
      ),
      body: PageView(
        controller: page,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (i) => setState(() => index = i),
        children: [
          _StepScaffold(
            index: 0,
            total: 3,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Nome Completo",
                    hintText: "Digite seu nome completo",
                    errorText: _validateName(nameController.text) != null &&
                            nameController.text.isNotEmpty
                        ? _validateName(nameController.text)
                        : null,
                  ),
                  validator: _validateName,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "E-mail",
                    hintText: "Digite seu e-mail",
                    errorText: _validateEmail(emailController.text) != null &&
                            emailController.text.isNotEmpty
                        ? _validateEmail(emailController.text)
                        : null,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: "Senha",
                    hintText: "Digite sua senha",
                    errorText:
                        _validatePassword(passwordController.text) != null &&
                                passwordController.text.isNotEmpty
                            ? _validatePassword(passwordController.text)
                            : null,
                  ),
                  obscureText: true,
                  validator: _validatePassword,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: "Confirmar senha",
                    hintText: "Confirme sua senha",
                    errorText: _validateConfirmPassword(
                                    confirmPasswordController.text) !=
                                null &&
                            confirmPasswordController.text.isNotEmpty
                        ? _validateConfirmPassword(
                            confirmPasswordController.text)
                        : null,
                  ),
                  obscureText: true,
                  validator: _validateConfirmPassword,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: cpfController,
                  decoration: InputDecoration(
                    labelText: "CPF",
                    hintText: "Digite seu CPF",
                    errorText: _validateCPF(cpfController.text) != null &&
                            cpfController.text.isNotEmpty
                        ? _validateCPF(cpfController.text)
                        : null,
                  ),
                  keyboardType: TextInputType.number,
                  validator: _validateCPF,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: "Telefone",
                    hintText: "Digite seu telefone",
                    errorText: _validatePhone(phoneController.text) != null &&
                            phoneController.text.isNotEmpty
                        ? _validatePhone(phoneController.text)
                        : null,
                  ),
                  keyboardType: TextInputType.phone,
                  validator: _validatePhone,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: zipCodeController,
                  decoration: InputDecoration(
                    labelText: "CEP",
                    hintText: "Digite seu CEP",
                    errorText:
                        _validateZipCode(zipCodeController.text) != null &&
                                zipCodeController.text.isNotEmpty
                            ? _validateZipCode(zipCodeController.text)
                            : null,
                  ),
                  keyboardType: TextInputType.number,
                  validator: _validateZipCode,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: cityController,
                  decoration: const InputDecoration(
                    labelText: "Cidade",
                    hintText: "Digite sua cidade",
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: neighborhoodController,
                  decoration: const InputDecoration(
                    labelText: "Bairro",
                    hintText: "Digite seu bairro",
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: streetController,
                        decoration: const InputDecoration(
                          labelText: "Rua",
                          hintText: "Nome da rua",
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: numberController,
                        decoration: const InputDecoration(
                          labelText: "Nº",
                          hintText: "123",
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: complementController,
                  decoration: const InputDecoration(
                    labelText: "Complemento",
                    hintText: "Apto, casa, etc.",
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: _selectDate,
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: "Data de Nascimento",
                      suffixIcon: const Icon(Icons.calendar_today),
                    ),
                    child: Text(
                      birthDate != null
                          ? DateFormat('dd/MM/yyyy').format(birthDate!)
                          : "Selecione sua data de nascimento",
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: _validateForm() ? _next : null,
                        child: const Text("Continuar"))),
              ],
            ),
          ),
          _StepScaffold(
            index: 1,
            total: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabeledField(
                    label: "Número da licença profissional",
                    hint: "Digite aqui o número",
                    controller: licenseController),
                const SectionTitle("Especialização"),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    "Enfermagem",
                    "Fisioterapeuta",
                    "Técnico de Enfermagem",
                    "Cuidado Paliativo"
                  ]
                      .map((e) => FilterChip(
                            label: Text(e),
                            selected: specializations.contains(e),
                            onSelected: (v) {
                              setState(() {
                                if (v)
                                  specializations.add(e);
                                else
                                  specializations.remove(e);
                              });
                            },
                          ))
                      .toList(),
                ),
                const SectionTitle("Disponibilidade (exemplo)"),
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
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: _next, child: const Text("Continuar"))),
              ],
            ),
          ),
          _StepScaffold(
            index: 2,
            total: 3,
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
                LabeledField(
                    label: "Breve biografia",
                    hint: "Escreva um pouco sobre você",
                    controller: bioController),
                const SizedBox(height: 10),
                LabeledField(
                    label: "Valor por hora",
                    hint: "Ex. R\$ 50,00",
                    controller: hourlyRateController,
                    keyboard: TextInputType.number),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (_) {}),
                    const Expanded(child: Text("Li e aceito os Termos de Uso")),
                  ],
                ),
                const SizedBox(height: 12),
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
  const _StepScaffold(
      {required this.index, required this.total, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
            24, 24, 24, MediaQuery.of(context).padding.bottom + 60),
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
