import 'package:mysql1/mysql1.dart';
import '../config/database_config.dart';

class DatabaseService {
  static MySqlConnection? _connection;

  static Future<MySqlConnection> getConnection() async {
    if (_connection != null) {
      try {
        // Testa se a conexão ainda está ativa
        await _connection!.query('SELECT 1');
        return _connection!;
      } catch (e) {
        // Se falhar, fecha a conexão e cria uma nova
        _connection = null;
      }
    }

    try {
      final settings = ConnectionSettings(
        host: DatabaseConfig.dbHost,
        port: DatabaseConfig.dbPort,
        user: DatabaseConfig.dbUser,
        password: DatabaseConfig.dbPassword,
        db: DatabaseConfig.dbName,
      );

      _connection = await MySqlConnection.connect(settings);
      print('Conexão com o banco de dados estabelecida com sucesso!');
      return _connection!;
    } catch (e) {
      print('Erro ao conectar com o banco de dados: $e');
      throw Exception('Erro ao conectar com o banco de dados: $e');
    }
  }

  static Future<void> closeConnection() async {
    if (_connection != null) {
      await _connection!.close();
      _connection = null;
      print('Conexão com o banco de dados fechada.');
    }
  }

  static Future<Results> executeQuery(String query,
      [List<dynamic>? values]) async {
    try {
      final connection = await getConnection();
      final results = await connection.query(query, values);
      return results;
    } catch (e) {
      print('Erro ao executar query: $e');
      throw Exception('Erro ao executar query: $e');
    }
  }

  static Future<Results> executeInsert(
      String query, List<dynamic> values) async {
    try {
      final connection = await getConnection();
      final results = await connection.query(query, values);
      return results;
    } catch (e) {
      print('Erro ao executar insert: $e');
      throw Exception('Erro ao executar insert: $e');
    }
  }

  static Future<Results> executeUpdate(
      String query, List<dynamic> values) async {
    try {
      final connection = await getConnection();
      final results = await connection.query(query, values);
      return results;
    } catch (e) {
      print('Erro ao executar update: $e');
      throw Exception('Erro ao executar update: $e');
    }
  }

  static Future<Results> executeDelete(
      String query, List<dynamic> values) async {
    try {
      final connection = await getConnection();
      final results = await connection.query(query, values);
      return results;
    } catch (e) {
      print('Erro ao executar delete: $e');
      throw Exception('Erro ao executar delete: $e');
    }
  }
}
