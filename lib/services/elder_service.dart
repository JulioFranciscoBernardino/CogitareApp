import '../models/elder.dart';
import 'api_service.dart';

class ElderService {
  // Criar idoso via API
  static Future<Map<String, dynamic>> createElder(Elder elder) async {
    try {
      final response = await ApiService.post('/api/idoso', {
        'nome': elder.name,
        'email':
            'elder@example.com', // Elder model doesn't have email, using default
        'senha':
            'default123', // Elder model doesn't have password, using default
        'telefone':
            '11999999999', // Elder model doesn't have phone, using default
        'cpf': '00000000000', // Elder model doesn't have CPF, using default
        'data_nascimento': elder.birthDate?.toIso8601String().split('T')[0],
        'endereco_id': 1, // Default address ID
        'mobilidade_id': elder.mobilityId,
        'nivel_autonomia_id': elder.autonomyLevelId,
      });

      if (response['success']) {
        return {
          'success': true,
          'message': response['message'],
          'elderId': response['data']['id'],
        };
      } else {
        return {
          'success': false,
          'message': response['message'] ?? 'Erro ao criar idoso',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Erro de conexão: $e',
      };
    }
  }

  // Listar idosos via API
  static Future<List<Elder>> listElders() async {
    try {
      final response = await ApiService.get('/api/idoso');

      if (response['success']) {
        final List<dynamic> data = response['data'];
        return data.map((json) => Elder.fromJson(json)).toList();
      } else {
        throw Exception(response['message'] ?? 'Erro ao listar idosos');
      }
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }

  // Listar idosos por responsável via API (implementação futura)
  static Future<List<Elder>> listEldersByGuardian(int guardianId) async {
    try {
      // Por enquanto, retorna todos os idosos
      // Futuramente pode ser implementado um endpoint específico
      return await listElders();
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }

  // Buscar idoso por ID via API
  static Future<Elder?> getElderById(int id) async {
    try {
      final response = await ApiService.get('/api/idoso/$id');

      if (response['success']) {
        return Elder.fromJson(response['data']);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Atualizar idoso via API
  static Future<Map<String, dynamic>> updateElder(int id, Elder elder) async {
    try {
      final response = await ApiService.put('/api/idoso/$id', {
        'nome': elder.name,
        'telefone':
            '11999999999', // Elder model doesn't have phone, using default
        'cpf': '00000000000', // Elder model doesn't have CPF, using default
        'data_nascimento': elder.birthDate?.toIso8601String().split('T')[0],
        'endereco_id': 1, // Default address ID
        'mobilidade_id': elder.mobilityId,
        'nivel_autonomia_id': elder.autonomyLevelId,
      });

      if (response['success']) {
        return {
          'success': true,
          'message': response['message'],
        };
      } else {
        return {
          'success': false,
          'message': response['message'] ?? 'Erro ao atualizar idoso',
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
