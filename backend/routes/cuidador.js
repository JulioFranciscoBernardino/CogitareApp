const express = require('express');
const bcrypt = require('bcryptjs');
const db = require('../config/database');
const { authenticateToken } = require('../middleware/auth');

const router = express.Router();

// Criar cuidador
router.post('/', async (req, res) => {
  try {
    const {
      nome,
      email,
      senha,
      telefone,
      cpf,
      data_nascimento,
      endereco_id
    } = req.body;

    // Verificar se email já existe
    const existingUser = await db.query(
      'SELECT id FROM cuidador WHERE email = ?',
      [email]
    );

    if (existingUser.length > 0) {
      return res.status(400).json({
        success: false,
        message: 'Email já cadastrado'
      });
    }

    // Criptografar senha
    const hashedPassword = await bcrypt.hash(senha, 10);

    // Inserir cuidador
    const result = await db.query(
      `INSERT INTO cuidador (nome, email, senha, telefone, cpf, data_nascimento, endereco_id) 
       VALUES (?, ?, ?, ?, ?, ?, ?)`,
      [nome, email, hashedPassword, telefone, cpf, data_nascimento, endereco_id]
    );

    res.status(201).json({
      success: true,
      message: 'Cuidador cadastrado com sucesso',
      data: {
        id: result.insertId
      }
    });

  } catch (error) {
    console.error('Erro ao criar cuidador:', error);
    res.status(500).json({
      success: false,
      message: 'Erro interno do servidor'
    });
  }
});

// Buscar cuidador por ID
router.get('/:id', authenticateToken, async (req, res) => {
  try {
    const { id } = req.params;

    const cuidadores = await db.query(
      `SELECT c.*, e.* FROM cuidador c 
       LEFT JOIN endereco e ON c.endereco_id = e.id 
       WHERE c.id = ?`,
      [id]
    );

    if (cuidadores.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Cuidador não encontrado'
      });
    }

    const cuidador = cuidadores[0];
    delete cuidador.senha; // Remover senha da resposta

    res.json({
      success: true,
      data: cuidador
    });

  } catch (error) {
    console.error('Erro ao buscar cuidador:', error);
    res.status(500).json({
      success: false,
      message: 'Erro interno do servidor'
    });
  }
});

// Atualizar cuidador
router.put('/:id', authenticateToken, async (req, res) => {
  try {
    const { id } = req.params;
    const {
      nome,
      telefone,
      cpf,
      data_nascimento,
      endereco_id
    } = req.body;

    // Verificar se cuidador existe
    const existingCuidador = await db.query(
      'SELECT id FROM cuidador WHERE id = ?',
      [id]
    );

    if (existingCuidador.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Cuidador não encontrado'
      });
    }

    // Atualizar cuidador
    await db.query(
      `UPDATE cuidador SET 
       nome = ?, telefone = ?, cpf = ?, data_nascimento = ?, endereco_id = ?
       WHERE id = ?`,
      [nome, telefone, cpf, data_nascimento, endereco_id, id]
    );

    res.json({
      success: true,
      message: 'Cuidador atualizado com sucesso'
    });

  } catch (error) {
    console.error('Erro ao atualizar cuidador:', error);
    res.status(500).json({
      success: false,
      message: 'Erro interno do servidor'
    });
  }
});

// Listar cuidadores
router.get('/', authenticateToken, async (req, res) => {
  try {
    const cuidadores = await db.query(
      `SELECT c.id, c.nome, c.email, c.telefone, c.cpf, c.data_nascimento,
              e.logradouro, e.numero, e.bairro, e.cidade, e.estado, e.cep
       FROM cuidador c 
       LEFT JOIN endereco e ON c.endereco_id = e.id`
    );

    res.json({
      success: true,
      data: cuidadores
    });

  } catch (error) {
    console.error('Erro ao listar cuidadores:', error);
    res.status(500).json({
      success: false,
      message: 'Erro interno do servidor'
    });
  }
});

module.exports = router;
