# 🧪 Guia de Teste - Integração Flutter + API

## ✅ **Status da Integração**

### **Correções Realizadas:**
- ✅ Erros de sintaxe corrigidos
- ✅ Serviços conectados à API
- ✅ Login integrado com autenticação
- ✅ Cadastros usando API
- ✅ Tratamento de erros implementado

### **Arquivos Atualizados:**
- `lib/services/api_service.dart` - Serviço principal da API
- `lib/services/caregiver_service.dart` - Serviços de cuidador
- `lib/services/elder_service.dart` - Serviços de idoso
- `lib/screens/login.dart` - Tela de login com API
- `lib/screens/caregiver_signup_screen.dart` - Cadastro de cuidador
- `lib/screens/elder_signup_screen.dart` - Cadastro de idoso

## 🚀 **Como Testar**

### **1. Iniciar a API**
```bash
# Windows
start-api.bat

# Linux/Mac
./start-api.sh

# Manual
cd backend
node server.js
```

### **2. Executar o App Flutter**
```bash
flutter run
```

### **3. Testar Funcionalidades**

#### **A. Teste de Login**
1. Abra o app
2. Vá para a tela de login
3. Digite um email válido
4. Digite uma senha (mínimo 6 caracteres)
5. Clique em "Entrar"
6. **Resultado esperado:** Login via API ou erro de conexão

#### **B. Teste de Cadastro de Cuidador**
1. Vá para "Sou Cuidador"
2. Preencha todos os campos obrigatórios
3. Complete o cadastro
4. **Resultado esperado:** Cadastro via API ou erro de conexão

#### **C. Teste de Cadastro de Idoso**
1. Vá para "Sou Idoso"
2. Preencha todos os campos obrigatórios
3. Complete o cadastro
4. **Resultado esperado:** Cadastro via API ou erro de conexão

## 🔍 **Verificar Logs**

### **API (Terminal)**
```
🚀 Servidor rodando na porta 3000
📱 API disponível em: http://localhost:3000
2024-01-01T12:00:00.000Z - POST /api/auth/login
2024-01-01T12:00:01.000Z - POST /api/cuidador
```

### **Flutter (Debug Console)**
```
I/flutter: Login realizado com sucesso
I/flutter: Cadastro realizado com sucesso
```

## 🐛 **Possíveis Problemas**

### **1. Erro de Conexão**
```
Erro de conexão: Connection refused
```
**Solução:** Verificar se a API está rodando

### **2. Erro de Autenticação**
```
Erro na requisição: 401
```
**Solução:** Verificar credenciais do banco

### **3. Erro de Validação**
```
Email já cadastrado
```
**Solução:** Usar email diferente ou limpar banco

## 📊 **Endpoints Testados**

- ✅ `POST /api/auth/login` - Login
- ✅ `POST /api/cuidador` - Cadastro cuidador
- ✅ `POST /api/idoso` - Cadastro idoso
- ✅ `POST /api/endereco` - Cadastro endereço
- ✅ `GET /api/health` - Health check

## 🎯 **Próximos Passos**

1. **Testar todas as funcionalidades** ✅
2. **Corrigir problemas encontrados**
3. **Implementar funcionalidades adicionais**
4. **Preparar para deploy em produção**

## 📞 **Suporte**

Se encontrar problemas:
1. Verificar se a API está rodando
2. Verificar logs da API
3. Verificar logs do Flutter
4. Testar endpoints manualmente com Postman/curl
