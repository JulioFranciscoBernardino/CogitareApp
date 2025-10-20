import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/contrato.dart';

class ServicoContrato {
  static const String baseUrl = 'http://localhost:3000/api';

  // Buscar contrato ativo do responsável
  static Future<Contrato?> getActiveContrato(int responsavelId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/contracts/active?responsavel_id=$responsavelId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['data'] != null) {
          return Contrato.fromJson(data['data']);
        }
      }

      return null; // Nenhum contrato ativo
    } catch (e) {
      print('Erro ao buscar contrato ativo: $e');
      return null;
    }
  }

  // Buscar histórico de contratos
  static Future<List<Contrato>> getContratoHistory(int responsavelId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/contracts/history?responsavel_id=$responsavelId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          final List<dynamic> contractsData = data['data'];
          return contractsData.map((json) => Contrato.fromJson(json)).toList();
        }
      }

      return [];
    } catch (e) {
      print('Erro ao buscar histórico de contratos: $e');
      return [];
    }
  }

  // Criar novo contrato
  static Future<Contrato?> createContrato({
    required int responsavelId,
    required int cuidadorId,
    required int idosoId,
    required DateTime dataInicio,
    required DateTime dataFim,
    required double valor,
    required String local,
    String? observacoes,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/contracts'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'responsavel_id': responsavelId,
          'cuidador_id': cuidadorId,
          'idoso_id': idosoId,
          'data_inicio': dataInicio.toIso8601String(),
          'data_fim': dataFim.toIso8601String(),
          'valor': valor,
          'local': local,
          'observacoes': observacoes,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          return Contrato.fromJson(data['data']);
        }
      }

      return null;
    } catch (e) {
      print('Erro ao criar contrato: $e');
      return null;
    }
  }

  // Cancelar contrato
  static Future<bool> cancelContrato(int contractId) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/contracts/$contractId/cancel'),
        headers: {'Content-Type': 'application/json'},
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Erro ao cancelar contrato: $e');
      return false;
    }
  }
}
