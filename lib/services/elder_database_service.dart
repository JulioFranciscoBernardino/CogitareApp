import '../models/elder.dart';
import 'database_service.dart';

class ElderDatabaseService {
  static Future<Map<String, dynamic>> createElder(Elder elder) async {
    try {
      const query = '''
        INSERT INTO idoso (IdResponsavel, IdMobilidade, IdNivelAutonomia, Nome, 
                          DataNascimento, Sexo, CuidadosMedicos, DescricaoExtra, FotoUrl)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
      ''';

      final values = [
        elder.guardianId,
        elder.mobilityId,
        elder.autonomyLevelId,
        elder.name,
        elder.birthDate?.toIso8601String().split('T')[0],
        elder.gender,
        elder.medicalCare,
        elder.extraDescription,
        elder.photoUrl,
      ];

      final result = await DatabaseService.executeInsert(query, values);

      return {
        'success': true,
        'data': {'IdIdoso': result.insertId},
        'message': 'Idoso cadastrado com sucesso'
      };
    } catch (e) {
      return {'success': false, 'message': 'Erro ao cadastrar idoso: $e'};
    }
  }

  static Future<List<Elder>> listElders() async {
    try {
      const query = '''
        SELECT i.*, r.Nome as ResponsavelNome
        FROM idoso i
        LEFT JOIN responsavel r ON i.IdResponsavel = r.IdResponsavel
      ''';

      final results = await DatabaseService.executeQuery(query);

      return results.map((row) {
        return Elder.fromJson({
          'IdIdoso': row['IdIdoso'],
          'IdResponsavel': row['IdResponsavel'],
          'IdMobilidade': row['IdMobilidade'],
          'IdNivelAutonomia': row['IdNivelAutonomia'],
          'Nome': row['Nome'],
          'DataNascimento': row['DataNascimento']?.toString(),
          'Sexo': row['Sexo'],
          'CuidadosMedicos': row['CuidadosMedicos'],
          'DescricaoExtra': row['DescricaoExtra'],
          'FotoUrl': row['FotoUrl'],
        });
      }).toList();
    } catch (e) {
      print('Erro ao listar idosos: $e');
      return [];
    }
  }

  static Future<List<Elder>> listEldersByGuardian(int guardianId) async {
    try {
      const query = '''
        SELECT i.*, r.Nome as ResponsavelNome
        FROM idoso i
        LEFT JOIN responsavel r ON i.IdResponsavel = r.IdResponsavel
        WHERE i.IdResponsavel = ?
      ''';

      final results = await DatabaseService.executeQuery(query, [guardianId]);

      return results.map((row) {
        return Elder.fromJson({
          'IdIdoso': row['IdIdoso'],
          'IdResponsavel': row['IdResponsavel'],
          'IdMobilidade': row['IdMobilidade'],
          'IdNivelAutonomia': row['IdNivelAutonomia'],
          'Nome': row['Nome'],
          'DataNascimento': row['DataNascimento']?.toString(),
          'Sexo': row['Sexo'],
          'CuidadosMedicos': row['CuidadosMedicos'],
          'DescricaoExtra': row['DescricaoExtra'],
          'FotoUrl': row['FotoUrl'],
        });
      }).toList();
    } catch (e) {
      print('Erro ao listar idosos por responsável: $e');
      return [];
    }
  }
}
