const express = require('express');
const db = require('../config/database');
const { authenticateToken } = require('../middleware/auth');

const router = express.Router();

// Criar endereço
router.post('/', async (req, res) => {
  try {
    const {
      logradouro,
      numero,
      complemento,
      bairro,
      cidade,
      estado,
      cep
    } = req.body;

    const result = await db.query(
      `INSERT INTO endereco (logradouro, numero, complemento, bairro, cidade, estado, cep) 
       VALUES (?, ?, ?, ?, ?, ?, ?)`,
      [logradouro, numero, complemento, bairro, cidade, estado, cep]
    );

    res.status(201).json({
      success: true,
      message: 'Endereço cadastrado com sucesso',
      data: {
        id: result.insertId
      }
    });

  } catch (error) {
    console.error('Erro ao criar endereço:', error);
    res.status(500).json({
      success: false,
      message: 'Erro interno do servidor'
    });
  }
});

// Buscar endereço por ID
router.get('/:id', authenticateToken, async (req, res) => {
  try {
    const { id } = req.params;

    const enderecos = await db.query(
      'SELECT * FROM endereco WHERE id = ?',
      [id]
    );

    if (enderecos.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Endereço não encontrado'
      });
    }

    res.json({
      success: true,
      data: enderecos[0]
    });

  } catch (error) {
    console.error('Erro ao buscar endereço:', error);
    res.status(500).json({
      success: false,
      message: 'Erro interno do servidor'
    });
  }
});

// Atualizar endereço
router.put('/:id', authenticateToken, async (req, res) => {
  try {
    const { id } = req.params;
    const {
      logradouro,
      numero,
      complemento,
      bairro,
      cidade,
      estado,
      cep
    } = req.body;

    // Verificar se endereço existe
    const existingEndereco = await db.query(
      'SELECT id FROM endereco WHERE id = ?',
      [id]
    );

    if (existingEndereco.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Endereço não encontrado'
      });
    }

    // Atualizar endereço
    await db.query(
      `UPDATE endereco SET 
       logradouro = ?, numero = ?, complemento = ?, bairro = ?, 
       cidade = ?, estado = ?, cep = ?
       WHERE id = ?`,
      [logradouro, numero, complemento, bairro, cidade, estado, cep, id]
    );

    res.json({
      success: true,
      message: 'Endereço atualizado com sucesso'
    });

  } catch (error) {
    console.error('Erro ao atualizar endereço:', error);
    res.status(500).json({
      success: false,
      message: 'Erro interno do servidor'
    });
  }
});

module.exports = router;
