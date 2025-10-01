import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/common.dart';
import '../models/guardian.dart';
import '../models/address.dart';
import '../services/guardian_service.dart';
import '../utils/validators.dart';
import 'elder_signup_screen.dart';

class GuardianSignupScreen extends StatefulWidget {
  static const route = '/signup/guardian';
  const GuardianSignupScreen({super.key});

  @override
  State<GuardianSignupScreen> createState() => _GuardianSignupScreenState();
}

class _GuardianSignupScreenState extends State<GuardianSignupScreen> {
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
  bool isLoading = false;

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

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          birthDate ?? DateTime.now().subtract(const Duration(days: 365 * 30)),
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
        _validateEmail(emailController.text) == null &&
        _validatePassword(passwordController.text) == null &&
        _validateConfirmPassword(confirmPasswordController.text) == null &&
        _validateCPF(cpfController.text) == null &&
        _validatePhone(phoneController.text) == null &&
        _validateZipCode(zipCodeController.text) == null &&
        cityController.text.isNotEmpty &&
        neighborhoodController.text.isNotEmpty &&
        streetController.text.isNotEmpty &&
        numberController.text.isNotEmpty &&
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

  Future<void> _next() async {
    if (!_validateForm()) {
      _showErrorDialog(
          'Por favor, preencha todos os campos obrigatórios corretamente.');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Create address
      final address = Address(
        city: cityController.text,
        neighborhood: neighborhoodController.text,
        street: streetController.text,
        number: numberController.text,
        complement: complementController.text,
        zipCode: zipCodeController.text,
      );

      // Create guardian
      final guardian = Guardian(
        cpf: cpfController.text,
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        birthDate: birthDate,
        password: passwordController.text,
      );

      // Create guardian
      final response = await GuardianService.createComplete(
        address: address,
        guardian: guardian,
      );

      if (response['success'] == true) {
        // Store guardian ID for elder registration
        final guardianId = response['data']['idResponsavel'];
        print('DEBUG: Guardian ID capturado: $guardianId');
        print('DEBUG: Response completa: $response');
        Navigator.pushReplacementNamed(context, ElderSignupScreen.route,
            arguments: guardianId);
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
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Nome Completo do Responsável",
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
                      ? _validateConfirmPassword(confirmPasswordController.text)
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
                  errorText: _validateZipCode(zipCodeController.text) != null &&
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
              StepDots(total: 1, index: 0),
              const SizedBox(height: 16),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: isLoading ? null : _next,
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text("Continuar para cadastro do Idoso"))),
            ],
          ),
        ),
      ),
    );
  }
}
