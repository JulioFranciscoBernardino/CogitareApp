const express = require('express');
const bcrypt = require('bcryptjs');
const db = require('../config/database');
const { generateToken, authenticateToken } = require('../middleware/auth');

const router = express.Router();

// Login unificado - busca em todas as tabelas
router.post('/unified-login', async (req, res) => {
  try {
    const { email, senha } = req.body;

    if (!email || !senha) {
      return res.status(400).json({
        success: false,
        message: 'Email e senha são obrigatórios'
      });
    }

    // Buscar usuário em todas as tabelas possíveis
    const tables = ['cuidador', 'responsavel'];
    let user = null;
    let userType = null;

    for (const table of tables) {
      const users = await db.query(
        `SELECT * FROM ${table} WHERE email = ?`,
        [email]
      );

      if (users.length > 0) {
        user = users[0];
        userType = table;
        break;
      }
    }

    if (!user) {
      return res.status(401).json({
        success: false,
        message: 'Credenciais inválidas'
      });
    }

    // Verificar senha
    const validPassword = await bcrypt.compare(senha, user.senha);
    if (!validPassword) {
      return res.status(401).json({
        success: false,
        message: 'Credenciais inválidas'
      });
    }

    // Gerar token
    const token = generateToken({
      id: user.id,
      email: user.email,
      tipo: userType
    });

    res.json({
      success: true,
      message: 'Login realizado com sucesso',
      data: {
        token,
        user: {
          id: user.id,
          nome: user.nome,
          email: user.email,
          tipo: userType
        }
      }
    });

  } catch (error) {
    console.error('Erro no login unificado:', error);
    res.status(500).json({
      success: false,
      message: 'Erro interno do servidor'
    });
  }
});

// Login (mantido para compatibilidade)
router.post('/login', async (req, res) => {
  try {
    const { email, senha, tipo } = req.body;

    if (!email || !senha || !tipo) {
      return res.status(400).json({
        success: false,
        message: 'Email, senha e tipo são obrigatórios'
      });
    }

    // Determinar a tabela baseada no tipo
    let tableName;
    switch (tipo) {
      case 'cuidador':
        tableName = 'cuidador';
        break;
      case 'idoso':
        tableName = 'idoso';
        break;
      case 'responsavel':
        tableName = 'responsavel';
        break;
      default:
        return res.status(400).json({
          success: false,
          message: 'Tipo de usuário inválido'
        });
    }

    // Buscar usuário no banco
    const users = await db.query(
      `SELECT * FROM ${tableName} WHERE email = ?`,
      [email]
    );

    if (users.length === 0) {
      return res.status(401).json({
        success: false,
        message: 'Credenciais inválidas'
      });
    }

    const user = users[0];

    // Verificar senha
    const validPassword = await bcrypt.compare(senha, user.senha);
    if (!validPassword) {
      return res.status(401).json({
        success: false,
        message: 'Credenciais inválidas'
      });
    }

    // Gerar token
    const token = generateToken({
      id: user.id,
      email: user.email,
      tipo: tipo
    });

    res.json({
      success: true,
      message: 'Login realizado com sucesso',
      data: {
        token,
        user: {
          id: user.id,
          nome: user.nome,
          email: user.email,
          tipo: tipo
        }
      }
    });

  } catch (error) {
    console.error('Erro no login:', error);
    res.status(500).json({
      success: false,
      message: 'Erro interno do servidor'
    });
  }
});

// Verificar token
router.get('/verify', authenticateToken, (req, res) => {
  res.json({
    success: true,
    message: 'Token válido',
    data: {
      user: req.user
    }
  });
});

module.exports = router;
