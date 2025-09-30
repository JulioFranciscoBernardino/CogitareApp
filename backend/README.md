# API Cogitare - Sistema de Cuidados

API REST para o aplicativo Cogitare, desenvolvida em Node.js com Express.

## 🚀 Instalação e Configuração

### 1. Instalar dependências
```bash
npm install
```

### 2. Configurar variáveis de ambiente
Copie o arquivo `.env.example` para `.env` e configure as variáveis:

```bash
cp .env.example .env
```

Edite o arquivo `.env` com suas credenciais:
```env
DB_HOST=mysql-cogitare.alwaysdata.net
DB_PORT=3306
DB_NAME=cogitare_bd
DB_USER=seu_usuario
DB_PASSWORD=sua_senha
JWT_SECRET=seu_jwt_secret_muito_seguro
```

### 3. Executar em desenvolvimento
```bash
npm run dev
```

### 4. Executar em produção
```bash
npm start
```

## 📡 Endpoints da API

### Autenticação
- `POST /api/auth/login` - Login de usuário
- `GET /api/auth/verify` - Verificar token

### Cuidadores
- `POST /api/cuidador` - Criar cuidador
- `GET /api/cuidador` - Listar cuidadores
- `GET /api/cuidador/:id` - Buscar cuidador por ID
- `PUT /api/cuidador/:id` - Atualizar cuidador

### Idosos
- `POST /api/idoso` - Criar idoso
- `GET /api/idoso` - Listar idosos
- `GET /api/idoso/:id` - Buscar idoso por ID
- `PUT /api/idoso/:id` - Atualizar idoso

### Endereços
- `POST /api/endereco` - Criar endereço
- `GET /api/endereco/:id` - Buscar endereço por ID
- `PUT /api/endereco/:id` - Atualizar endereço

### Health Check
- `GET /api/health` - Status da API

## 🔐 Autenticação

A API usa JWT (JSON Web Tokens) para autenticação. Inclua o token no header:

```
Authorization: Bearer SEU_TOKEN_AQUI
```

## 🛡️ Segurança

- Rate limiting (100 requests por 15 minutos)
- CORS configurado
- Helmet para headers de segurança
- Senhas criptografadas com bcrypt
- Validação de dados

## 📱 Integração com Flutter

A API está configurada para trabalhar com o app Flutter. Atualize a URL base no arquivo `lib/config/database_config.dart`:

```dart
static const String apiBaseUrl = 'https://sua-api.alwaysdata.net';
```
