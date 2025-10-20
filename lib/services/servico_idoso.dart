import '../models/idoso.dart';
import 'servico_api.dart';

class ServicoIdoso {
  // Criar idoso via API
  static Future<Map<String, dynamic>> createIdoso(Idoso idoso) async {
    try {
      final response = await ServicoApi.post('/api/idoso', idoso.toJson());

      if (response['success']) {
        return {
          'success': true,
          'message': response['message'],
          'idosoId': response['data']['IdIdoso'],
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
  static Future<List<Idoso>> listIdosos() async {
    try {
      final response = await ServicoApi.get('/api/idoso');

      if (response['success']) {
        final List<dynamic> data = response['data'];
        return data.map((json) => Idoso.fromJson(json)).toList();
      } else {
        throw Exception(response['message'] ?? 'Erro ao listar idosos');
      }
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }

  // Listar idosos por responsável via API (implementação futura)
  static Future<List<Idoso>> listIdososByGuardian(int guardianId) async {
    try {
      // Por enquanto, retorna todos os idosos
      // Futuramente pode ser implementado um endpoint específico
      return await listIdosos();
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }

  // Buscar idoso por ID via API
  static Future<Idoso?> getIdosoById(int id) async {
    try {
      final response = await ServicoApi.get('/api/idoso/$id');

      if (response['success']) {
        return Idoso.fromJson(response['data']);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Atualizar idoso via API
  static Future<Map<String, dynamic>> updateIdoso(int id, Idoso idoso) async {
    try {
      final idosoData = idoso.toJson();
      idosoData.remove('IdIdoso'); // Remove ID do objeto antes de enviar

      final response = await ServicoApi.put('/api/idoso/$id', idosoData);

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
