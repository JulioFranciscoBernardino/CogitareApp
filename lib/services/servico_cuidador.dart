import '../models/cuidador.dart';
import '../models/endereco.dart';
import 'servico_api.dart';

class ServicoCuidador {
  // Criar endereço via API
  static Future<Map<String, dynamic>> createEndereco(Endereco address) async {
    try {
      final response = await ServicoApi.post('/api/endereco', {
        'rua': address.street,
        'numero': address.number,
        'complemento': address.complement,
        'bairro': address.neighborhood,
        'cidade': address.city,
        'cep': address.zipCode,
      });

      if (response['success']) {
        return {
          'success': true,
          'message': response['message'],
          'addressId': response['data']['id'],
        };
      } else {
        return {
          'success': false,
          'message': response['message'] ?? 'Erro ao criar endereço',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Erro de conexão: $e',
      };
    }
  }

  // Criar cuidador via API
  static Future<Map<String, dynamic>> createCuidador(Cuidador caregiver) async {
    try {
      final response = await ServicoApi.post('/api/cuidador', {
        'nome': caregiver.name,
        'email': caregiver.email,
        'senha': caregiver.password,
        'telefone': caregiver.phone,
        'cpf': caregiver.cpf,
        'data_nascimento': caregiver.birthDate?.toIso8601String().split('T')[0],
        'endereco_id': caregiver.addressId,
        'fumante': caregiver.smokingStatus,
        'tem_filhos': caregiver.hasChildren,
        'possui_cnh': caregiver.hasLicense,
        'tem_carro': caregiver.hasCar,
        'biografia': caregiver.biography,
        'valor_hora': caregiver.hourlyRate,
      });

      if (response['success']) {
        return {
          'success': true,
          'message': response['message'],
          'caregiverId': response['data']['id'],
        };
      } else {
        return {
          'success': false,
          'message': response['message'] ?? 'Erro ao criar cuidador',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Erro de conexão: $e',
      };
    }
  }

  // Criar cuidador completo (endereço + cuidador) via API
  static Future<Map<String, dynamic>> createComplete({
    required Endereco address,
    required Cuidador caregiver,
  }) async {
    try {
      // Primeiro criar o endereço
      final addressResult = await createEndereco(address);

      if (!addressResult['success']) {
        return addressResult;
      }

      // Atualizar o cuidador com o ID do endereço
      caregiver = caregiver.copyWith(addressId: addressResult['addressId']);

      // Criar o cuidador
      final caregiverResult = await createCuidador(caregiver);

      if (!caregiverResult['success']) {
        return caregiverResult;
      }

      return {
        'success': true,
        'message': 'Cuidador cadastrado com sucesso',
        'addressId': addressResult['addressId'],
        'caregiverId': caregiverResult['caregiverId'],
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Erro ao criar cuidador completo: $e',
      };
    }
  }

  // Listar cuidadores via API
  static Future<List<Cuidador>> listCuidadors() async {
    try {
      final response = await ServicoApi.get('/api/cuidador');

      if (response['success']) {
        final List<dynamic> data = response['data'];
        return data.map((json) => Cuidador.fromJson(json)).toList();
      } else {
        throw Exception(response['message'] ?? 'Erro ao listar cuidadores');
      }
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }

  // Buscar cuidador por ID via API
  static Future<Cuidador?> getCuidadorById(int id) async {
    try {
      final response = await ServicoApi.get('/api/cuidador/$id');

      if (response['success']) {
        return Cuidador.fromJson(response['data']);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Atualizar cuidador via API
  static Future<Map<String, dynamic>> updateCuidador(
      int id, Cuidador caregiver) async {
    try {
      final response = await ServicoApi.put('/api/cuidador/$id', {
        'nome': caregiver.name,
        'telefone': caregiver.phone,
        'cpf': caregiver.cpf,
        'data_nascimento': caregiver.birthDate?.toIso8601String().split('T')[0],
        'endereco_id': caregiver.addressId,
      });

      if (response['success']) {
        return {
          'success': true,
          'message': response['message'],
        };
      } else {
        return {
          'success': false,
          'message': response['message'] ?? 'Erro ao atualizar cuidador',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Erro de conexão: $e',
      };
    }
  }
}
