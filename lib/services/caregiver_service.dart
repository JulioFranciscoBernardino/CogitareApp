import '../models/caregiver.dart';
import '../models/address.dart';
import 'api_service.dart';

class CaregiverService {
  // Criar endereço via API
  static Future<Map<String, dynamic>> createAddress(Address address) async {
    try {
      final response = await ApiService.post('/api/endereco', {
        'logradouro': address.street,
        'numero': address.number,
        'complemento': address.complement,
        'bairro': address.neighborhood,
        'cidade': address.city,
        'estado': 'SP', // Default state, can be made configurable
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
  static Future<Map<String, dynamic>> createCaregiver(
      Caregiver caregiver) async {
    try {
      final response = await ApiService.post('/api/cuidador', {
        'nome': caregiver.name,
        'email': caregiver.email,
        'senha': caregiver.password,
        'telefone': caregiver.phone,
        'cpf': caregiver.cpf,
        'data_nascimento': caregiver.birthDate?.toIso8601String().split('T')[0],
        'endereco_id': caregiver.addressId,
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
    required Address address,
    required Caregiver caregiver,
  }) async {
    try {
      // Primeiro criar o endereço
      final addressResult = await createAddress(address);

      if (!addressResult['success']) {
        return addressResult;
      }

      // Atualizar o cuidador com o ID do endereço
      caregiver = caregiver.copyWith(addressId: addressResult['addressId']);

      // Criar o cuidador
      final caregiverResult = await createCaregiver(caregiver);

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
  static Future<List<Caregiver>> listCaregivers() async {
    try {
      final response = await ApiService.get('/api/cuidador');

      if (response['success']) {
        final List<dynamic> data = response['data'];
        return data.map((json) => Caregiver.fromJson(json)).toList();
      } else {
        throw Exception(response['message'] ?? 'Erro ao listar cuidadores');
      }
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }

  // Buscar cuidador por ID via API
  static Future<Caregiver?> getCaregiverById(int id) async {
    try {
      final response = await ApiService.get('/api/cuidador/$id');

      if (response['success']) {
        return Caregiver.fromJson(response['data']);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Atualizar cuidador via API
  static Future<Map<String, dynamic>> updateCaregiver(
      int id, Caregiver caregiver) async {
    try {
      final response = await ApiService.put('/api/cuidador/$id', {
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
