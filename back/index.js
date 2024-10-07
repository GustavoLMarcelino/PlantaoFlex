// index.js
const express = require('express');
const dotenv = require('dotenv');
const { Pool } = require('pg');

dotenv.config();  // Carrega variáveis do arquivo .env

const app = express();
const port = process.env.PORT || 3000;

// Middleware para entender JSON no corpo das requisições
app.use(express.json());

// Configuração do pool de conexões com o PostgreSQL
const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  port: process.env.DB_PORT,
});

// Exemplo de rota: Buscar todas as consultas
app.get('/consultas', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM consultas');
    res.status(200).json(result.rows);
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Erro ao buscar consultas');
  }
});

// Inicializar servidor
app.listen(port, () => {
  console.log(`Servidor rodando na porta ${port}`);
});
