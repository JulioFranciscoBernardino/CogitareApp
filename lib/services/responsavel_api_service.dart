import '../models/guardian.dart';
import '../models/address.dart';
import 'api_service.dart';

class ResponsavelApiService {
  // Cadastrar endereço via API
  static Future<Map<String, dynamic>> createAddress(Address address) async {
    try {
      final response = await ApiService.post('/api/responsavel/endereco', {
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
  static Future<Map<String, dynamic>> createGuardian(Guardian guardian) async {
    try {
      final response = await ApiService.post('/api/responsavel', {
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
    required Address address,
    required Guardian guardian,
  }) async {
    try {
      final response = await ApiService.post('/api/responsavel/completo', {
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
  static Future<List<Guardian>> listGuardians() async {
    try {
      final response = await ApiService.get('/api/responsavel');

      if (response['success'] == true) {
        final List<dynamic> data = response['data'];
        return data.map((json) => Guardian.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Erro ao listar responsáveis: $e');
      return [];
    }
  }

  // Buscar responsável por ID via API
  static Future<Guardian?> getGuardianById(int id) async {
    try {
      final response = await ApiService.get('/api/responsavel/$id');

      if (response['success'] == true) {
        return Guardian.fromJson(response['data']);
      } else {
        return null;
      }
    } catch (e) {
      print('Erro ao buscar responsável: $e');
      return null;
    }
  }
}
