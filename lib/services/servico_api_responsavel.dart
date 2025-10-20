import '../models/responsavel.dart';
import '../models/endereco.dart';
import 'servico_api.dart';

class ServicoApiResponsavel {
  // Cadastrar endereço via API
  static Future<Map<String, dynamic>> createEndereco(Endereco address) async {
    try {
      final response = await ServicoApi.post('/api/responsavel/endereco', {
        'cidade': address.city,
        'bairro': address.neighborhood,
        'rua': address.street,
        'numero': address.number,
        'complemento': address.complement,
        'cep': address.zipCode,
      });

      return response;
    } catch (e) {
      return {'success': false, 'message': 'Erro ao cadastrar endereço: $e'};
    }
  }

  // Cadastrar responsável via API
  static Future<Map<String, dynamic>> createResponsavel(
      Responsavel guardian) async {
    try {
      final response = await ServicoApi.post('/api/responsavel', {
        'idEndereco': guardian.addressId,
        'cpf': guardian.cpf,
        'nome': guardian.name,
        'email': guardian.email,
        'telefone': guardian.phone,
        'dataNascimento': guardian.birthDate?.toIso8601String().split('T')[0],
        'senha': guardian.password, // Assumindo que o modelo tem senha
        'fotoUrl': guardian.photoUrl,
      });

      return response;
    } catch (e) {
      return {'success': false, 'message': 'Erro ao cadastrar responsável: $e'};
    }
  }

  // Cadastro completo via API (endereço + responsável em uma requisição)
  static Future<Map<String, dynamic>> createComplete({
    required Endereco address,
    required Responsavel guardian,
  }) async {
    try {
      final response = await ServicoApi.post('/api/responsavel/completo', {
        // Dados do endereço
        'cidade': address.city,
        'bairro': address.neighborhood,
        'rua': address.street,
        'numero': address.number,
        'complemento': address.complement,
        'cep': address.zipCode,
        // Dados do responsável
        'cpf': guardian.cpf,
        'nome': guardian.name,
        'email': guardian.email,
        'telefone': guardian.phone,
        'dataNascimento': guardian.birthDate?.toIso8601String().split('T')[0],
        'senha': guardian.password, // Assumindo que o modelo tem senha
        'fotoUrl': guardian.photoUrl,
      });

      return response;
    } catch (e) {
      return {'success': false, 'message': 'Erro no cadastro completo: $e'};
    }
  }

  // Listar responsáveis via API
  static Future<List<Responsavel>> listResponsavels() async {
    try {
      final response = await ServicoApi.get('/api/responsavel');

      if (response['success'] == true) {
        final List<dynamic> data = response['data'];
        return data.map((json) => Responsavel.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Erro ao listar responsáveis: $e');
      return [];
    }
  }

  // Buscar responsável por ID via API
  static Future<Responsavel?> getResponsavelById(int id) async {
    try {
      final response = await ServicoApi.get('/api/responsavel/$id');

      if (response['success'] == true) {
        return Responsavel.fromJson(response['data']);
      } else {
        return null;
      }
    } catch (e) {
      print('Erro ao buscar responsável: $e');
      return null;
    }
  }
}
