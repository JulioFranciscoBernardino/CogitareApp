# Configuração do Banco de Dados

## Como configurar a conexão com o banco de dados

### 1. Configuração das Variáveis de Ambiente

Edite o arquivo `lib/config/database_config.dart` e substitua as seguintes informações:

```dart
class DatabaseConfig {
  // Substitua pelas suas credenciais reais
  static const String dbHost = 'mysql-cogitare.alwaysdata.net';
  static const int dbPort = 3306;
  static const String dbName = 'cogitare_bd';
  static const String dbUser = 'SEU_USUARIO_AQUI'; // Substitua pelo seu usuário
  static const String dbPassword = 'SUA_SENHA_AQUI'; // Substitua pela sua senha
  
  // URL da API (se você tiver um backend)
  static const String apiBaseUrl = 'https://api-cogitare.alwaysdata.net';
  
  // String de conexão
  static String get connectionString => 
      'mysql://$dbUser:$dbPassword@$dbHost:$dbPort/$dbName';
  
  // URL da API
  static String get apiUrl => apiBaseUrl;
}
```

### 2. Informações do Banco de Dados

Com base no seu arquivo `cogitare_bd.sql`, você precisa:

- **Host**: `mysql-cogitare.alwaysdata.net`
- **Porta**: `3306`
- **Nome do Banco**: `cogitare_bd`
- **Usuário**: Seu usuário do AlwaysData
- **Senha**: Sua senha do AlwaysData

### 3. Testando a Conexão

Para testar se a conexão está funcionando, você pode executar o app e tentar fazer um cadastro. Se houver erro de conexão, verifique:

1. Se as credenciais estão corretas
2. Se o banco de dados está acessível
3. Se as tabelas existem no banco

### 4. Estrutura das Tabelas

O sistema espera que as seguintes tabelas existam no banco:

- `endereco`
- `cuidador`
- `responsavel`
- `idoso`
- `mobilidade`
- `nivelautonomia`

### 5. Comandos Úteis

```bash
# Instalar dependências
flutter pub get

# Limpar cache
flutter clean

# Executar o app
flutter run
```

### 6. Logs de Depuração

O sistema irá mostrar logs no console quando:
- Conectar com sucesso ao banco
- Executar queries
- Encontrar erros de conexão

Fique atento aos logs para identificar problemas de conexão.
