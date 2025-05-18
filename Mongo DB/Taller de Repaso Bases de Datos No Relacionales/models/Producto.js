const mongoose = require('mongoose');

const productoSchema = new mongoose.Schema({
  nombre: {
    type: String,
    required: true
  },
  precio: {
    type: Number,
    required: true
  },
  categoria: {
    type: String,
    required: true,
  },
  stock: {
    type: Boolean,
    default: false
  }
});

const Productos = mongoose.model('Producto', productoSchema);

module.exports = Productos;

/*,
  activo: {
    type: Boolean,
    default: false
  }
*/
