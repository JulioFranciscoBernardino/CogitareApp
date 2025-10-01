import '../models/elder.dart';
import 'api_service.dart';

class ElderService {
  // Criar idoso via API
  static Future<Map<String, dynamic>> createElder(Elder elder) async {
    try {
      final response = await ApiService.post('/api/idoso', elder.toJson());

      if (response['success']) {
        return {
          'success': true,
          'message': response['message'],
          'elderId': response['data']['IdIdoso'],
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
      final elderData = elder.toJson();
      elderData.remove('IdIdoso'); // Remove ID do objeto antes de enviar

      final response = await ApiService.put('/api/idoso/$id', elderData);

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
