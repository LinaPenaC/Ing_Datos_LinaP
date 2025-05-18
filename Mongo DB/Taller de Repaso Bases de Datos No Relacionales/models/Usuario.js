const mongoose = require('mongoose');

const usuarioSchema = new mongoose.Schema({
  nombre: {
    type: String,
    required: true
  },
  edad: {
    type: Number,
    required: true
  },
  correo: {
    type: String,
    required: true,
    unique: true
  },
  activo: {
    type: Boolean,
    default: false
  }
});

const Usuarios = mongoose.model('Usuario', usuarioSchema);

module.exports = Usuarios;
