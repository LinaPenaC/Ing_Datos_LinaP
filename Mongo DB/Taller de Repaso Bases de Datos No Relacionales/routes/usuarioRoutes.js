const express = require('express');
const router = express.Router();
const Usuario = require('../models/Usuario');

// Crear un usuario
router.post('/', async (req, res) => {
  try {
    const item = new Usuario(req.body);   // Crea la instancia con los datos del cuerpo de la solicitud.
    await item.save();                     // Guarda la instancia en la base de datos.
    res.status(201).json(item);             // Devuelve la instancia guardada.
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Obtener todos los usuarios
router.get('/', async (req, res) => {
  try {
    const item = await Usuario.find();
    res.status(200).json(item);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

//consultar por idMongo
router.get('/:id',async(req,res)=>{
  try{
    const item=await Usuario.findById(req.params.id);
    if (!item)return res.status(404).json({error: "Usuario no encontrado"});
    res.json(item);
  }catch(error){
    res.status(500).json({error: error.message})
  }
});

//consultar por nombre
router.get('/consultar-nombre/:nombre', async (req, res) => {
  try {
    const item = await Usuario.findOne({ nombre: req.params.nombre });
    if (!item) {
      return res.status(404).json({ error: "Usuario no encontrado" });
    }
    res.status(200).json(item);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

//consultar usuarios de edad mayor o igual a n
router.get('/consultar-edad-mayor-igual/:edad', async (req, res) => {
  try {
    const item = await Usuario.find({ edad: {$gte:req.params.edad} });
    if (!item || item.length === 0) {
      return res.status(404).json({ error: "Usuarios no encontrados" });
    }
    res.status(200).json(item);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});



//Actualizar datos Usuario por nombre
router.put('/actualizar-por-nombre/:nombre', async (req, res) => {
  try {
    const item = await Usuario.findOneAndUpdate(
      { nombre: req.params.nombre }, 
      req.body,                       
      { new: true }                   
    );
    if (!item) {
      return res.status(404).json({ error: "Usuario no encontrado" });
    }
    res.json(item);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Actualizar estado por edad
router.put('/actualizar-por-edad/:edad', async (req, res) => {
  try {
    const item = await Usuario.updateMany(
      { edad: {$gte:req.params.edad} }, 
      req.body,                       
      { new: true }                   
    );
    if (!item) {
      return res.status(404).json({ error: "Usuarios no encontrados" });
    }
    res.json(item);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});


//Eliminar a un Usuario por nombre
router.delete('/eliminar-por-nombre/:nombre', async (req, res) => {
  try {
    const item = await Usuario.findOneAndDelete({ nombre: req.params.nombre });
    if (!item) return res.status(404).json({ message: 'Usuario no encontrado' });
    res.status(200).json({ message: 'Usuario eliminado' });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

//Eliminar usuarios menores a 
router.delete('/eliminar-por-edad/:edad', async (req, res) => {
  try {
    const item = await Usuario.deleteMany({ edad: {$lt:req.params.edad} });
    if (!item) return res.status(404).json({ message: 'Usuarios no encontrados' });
    res.status(200).json({ message: 'Usuarios eliminados' });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});


module.exports = router;  