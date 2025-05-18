const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors')
const bodyParser = require('body-parser')
require('dotenv').config();

const usuarioRoutes = require('./routes/usuarioRoutes');
const productoRoutes = require('./routes/productoRoutes');

const app = express();
app.use(express.json()); // Middleware para parsear JSON
app.use(cors()); // Enable CORS for all routes
app.use(bodyParser.json()); // Parse JSON request bodies

// Conexión a MongoDB usando Mongoose
mongoose.connect('mongodb://localhost:27017/tallerMongoDB1', {        //Envío propiedad de conexión a la base de datos
  useNewUrlParser: true,                                             // Usar la nueva URL de análisis de MongoDB
  useUnifiedTopology: true                                          // Usar el nuevo motor de topología unificada de MongoDB
}).then(() => {
  console.log('Conectado a MongoDB')
}).catch(err => {
  console.error('Error al conectar a MongoDB', err)
})

app.use('/api/usuarios', usuarioRoutes);
app.use('/api/productos', productoRoutes);

// Ruta de prueba
app.get('/', (req, res) => {
  res.send('¡Bienvenido al Taller MongoDB1!');
});

// Configura el puerto de la aplicación
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor corriendo en el puerto http://localhost:${PORT}`);
});



