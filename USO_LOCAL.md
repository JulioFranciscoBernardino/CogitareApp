# 🏠 Guia de Uso Local - API Cogitare

## 🚀 Como Iniciar a API

### **Opção 1: Script Automático (Windows)**
```bash
# Clique duplo no arquivo:
start-api.bat
```

### **Opção 2: Script Automático (Linux/Mac)**
```bash
chmod +x start-api.sh
./start-api.sh
```

### **Opção 3: Manual**
```bash
cd backend
npm install
node server.js
```

## 📱 Como Testar

### **1. Health Check**
Abra no navegador: http://localhost:3000/api/health

Deve retornar:
```json
{
  "success": true,
  "message": "API funcionando corretamente",
  "timestamp": "2024-01-01T12:00:00.000Z",
  "version": "1.0.0"
}
```

### **2. Testar Login**
Use Postman ou curl:
```bash
curl -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "teste@email.com",
    "senha": "123456",
    "tipo": "cuidador"
  }'
```

### **3. Testar com Flutter**
Execute seu app Flutter normalmente. Ele se conectará automaticamente à API local.

## 🔧 Configurações

### **URL da API:** `http://localhost:3000`
- Configurada em: `lib/config/database_config.dart`
- Endpoints disponíveis:
  - `http://localhost:3000/api/auth/login`
  - `http://localhost:3000/api/cuidador`
  - `http://localhost:3000/api/idoso`
  - `http://localhost:3000/api/endereco`

### **Banco de Dados:** MySQL na nuvem
- Host: `mysql-cogitare.alwaysdata.net`
- Banco: `cogitare_bd`
- Usuário: `cogitare`

## 🛠️ Solução de Problemas

### **Erro: "Cannot find module"**
```bash
cd backend
npm install
```

### **Erro: "Port 3000 already in use"**
```bash
# Pare outros processos na porta 3000
netstat -ano | findstr :3000
taskkill /PID <PID_NUMBER> /F
```

### **Erro de conexão com banco**
- Verifique se as credenciais estão corretas
- Confirme se o banco está acessível
- Verifique se as tabelas existem

## 📊 Logs da API

A API mostra logs no console:
```
🚀 Servidor rodando na porta 3000
📱 API disponível em: http://localhost:3000
🔗 Health check: http://localhost:3000/api/health
2024-01-01T12:00:00.000Z - GET /api/health
2024-01-01T12:00:01.000Z - POST /api/auth/login
```

## 🔄 Próximos Passos

1. **Testar localmente** ✅
2. **Desenvolver funcionalidades** 
3. **Decidir hospedagem** (AlwaysData, Heroku, Vercel, etc.)
4. **Fazer deploy em produção**

## 📞 Suporte

Se encontrar problemas:
1. Verifique se o Node.js está instalado
2. Confirme se as dependências foram instaladas
3. Verifique se a porta 3000 está livre
4. Confirme se o banco de dados está acessível
