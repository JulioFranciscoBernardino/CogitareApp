const express = require('express');
const bcrypt = require('bcryptjs');
const db = require('../config/database');
const { authenticateToken } = require('../middleware/auth');

const router = express.Router();

// Criar idoso
router.post('/', async (req, res) => {
  try {
    const {
      nome,
      email,
      senha,
      telefone,
      cpf,
      data_nascimento,
      endereco_id,
      mobilidade_id,
      nivel_autonomia_id
    } = req.body;

    // Verificar se email já existe
    const existingUser = await db.query(
      'SELECT id FROM idoso WHERE email = ?',
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

    // Inserir idoso
    const result = await db.query(
      `INSERT INTO idoso (nome, email, senha, telefone, cpf, data_nascimento, endereco_id, mobilidade_id, nivel_autonomia_id) 
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [nome, email, hashedPassword, telefone, cpf, data_nascimento, endereco_id, mobilidade_id, nivel_autonomia_id]
    );

    res.status(201).json({
      success: true,
      message: 'Idoso cadastrado com sucesso',
      data: {
        id: result.insertId
      }
    });

  } catch (error) {
    console.error('Erro ao criar idoso:', error);
    res.status(500).json({
      success: false,
      message: 'Erro interno do servidor'
    });
  }
});

// Buscar idoso por ID
router.get('/:id', authenticateToken, async (req, res) => {
  try {
    const { id } = req.params;

    const idosos = await db.query(
      `SELECT i.*, e.*, m.descricao as mobilidade_desc, na.descricao as autonomia_desc
       FROM idoso i 
       LEFT JOIN endereco e ON i.endereco_id = e.id 
       LEFT JOIN mobilidade m ON i.mobilidade_id = m.id
       LEFT JOIN nivelautonomia na ON i.nivel_autonomia_id = na.id
       WHERE i.id = ?`,
      [id]
    );

    if (idosos.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Idoso não encontrado'
      });
    }

    const idoso = idosos[0];
    delete idoso.senha; // Remover senha da resposta

    res.json({
      success: true,
      data: idoso
    });

  } catch (error) {
    console.error('Erro ao buscar idoso:', error);
    res.status(500).json({
      success: false,
      message: 'Erro interno do servidor'
    });
  }
});

// Atualizar idoso
router.put('/:id', authenticateToken, async (req, res) => {
  try {
    const { id } = req.params;
    const {
      nome,
      telefone,
      cpf,
      data_nascimento,
      endereco_id,
      mobilidade_id,
      nivel_autonomia_id
    } = req.body;

    // Verificar se idoso existe
    const existingIdoso = await db.query(
      'SELECT id FROM idoso WHERE id = ?',
      [id]
    );

    if (existingIdoso.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Idoso não encontrado'
      });
    }

    // Atualizar idoso
    await db.query(
      `UPDATE idoso SET 
       nome = ?, telefone = ?, cpf = ?, data_nascimento = ?, 
       endereco_id = ?, mobilidade_id = ?, nivel_autonomia_id = ?
       WHERE id = ?`,
      [nome, telefone, cpf, data_nascimento, endereco_id, mobilidade_id, nivel_autonomia_id, id]
    );

    res.json({
      success: true,
      message: 'Idoso atualizado com sucesso'
    });

  } catch (error) {
    console.error('Erro ao atualizar idoso:', error);
    res.status(500).json({
      success: false,
      message: 'Erro interno do servidor'
    });
  }
});

// Listar idosos
router.get('/', authenticateToken, async (req, res) => {
  try {
    const idosos = await db.query(
      `SELECT i.id, i.nome, i.email, i.telefone, i.cpf, i.data_nascimento,
              e.logradouro, e.numero, e.bairro, e.cidade, e.estado, e.cep,
              m.descricao as mobilidade_desc, na.descricao as autonomia_desc
       FROM idoso i 
       LEFT JOIN endereco e ON i.endereco_id = e.id 
       LEFT JOIN mobilidade m ON i.mobilidade_id = m.id
       LEFT JOIN nivelautonomia na ON i.nivel_autonomia_id = na.id`
    );

    res.json({
      success: true,
      data: idosos
    });

  } catch (error) {
    console.error('Erro ao listar idosos:', error);
    res.status(500).json({
      success: false,
      message: 'Erro interno do servidor'
    });
  }
});

module.exports = router;
