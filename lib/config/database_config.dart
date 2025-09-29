class DatabaseConfig {
  // Configurações do banco de dados
  static const String dbHost = 'mysql-cogitare.alwaysdata.net';
  static const int dbPort = 3306;
  static const String dbName = 'cogitare_bd';
  static const String dbUser = 'cogitare';
  static const String dbPassword = "fT4qJ7n7M\$n7t12T#v}T;";

  // URL da API (se você tiver um backend)
  static const String apiBaseUrl = 'https://api-cogitare.alwaysdata.net';

  // String de conexão
  static String get connectionString =>
      'mysql://$dbUser:$dbPassword@$dbHost:$dbPort/$dbName';

  // URL da API
  static String get apiUrl => apiBaseUrl;
}
