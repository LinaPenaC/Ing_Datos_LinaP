const express = require('express');
const router = express.Router();
const Producto = require('../models/Producto');

// Crear un Producto
router.post('/', async (req, res) => {
  try {
    const item = new Producto(req.body);   
    await item.save();                     
    res.status(201).json(item);             
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Obtener todos los productos
router.get('/', async (req, res) => {
  try {
    const item = await Producto.find();
    res.status(200).json(item);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

//consultar por idMongo
router.get('/:id',async(req,res)=>{
  try{
    const item=await Producto.findById(req.params.id);
    if (!item)return res.status(404).json({error: "Producto no encontrado"});
    res.json(item);
  }catch(error){
    res.status(500).json({error: error.message})
  }
});


//consultar productos de precio mayor  a n
router.get('/consultar-precio-mayor/:precio', async (req, res) => {
  try {
    const item = await Producto.find({ precio: {$gt:req.params.precio} });
    if (!item || item.length === 0) {
      return res.status(404).json({ error: "Productos no encontrados" });
    }
    res.status(200).json(item);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Consultar productos con precio ordenado de manera descendente
router.get('/consultar-precio-ordenado', async (req, res) => {
  try {
    // Buscar productos con precio mayor a 100 y ordenar por precio de forma descendente
    const item = await Producto.find().sort({ precio: -1 });

    // Si no se encuentran productos, devolver un error
    if (item.length === 0) {
      return res.status(404).json({ error: "No se encontraron productos con precio mayor" });
    }

    res.status(200).json(item);  // Responder con los productos encontrados
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});



//Actualizar datos producto por precio mayor a 
router.put('/actualizar-por-precio-mayor/:precio', async (req, res) => {
  try {
    const item = await Producto.updateMany(
      { precio: {$gte:req.params.precio} }, 
      req.body,                       
      { new: true }                   
    );
    if (!item) {
      return res.status(404).json({ error: "Producto no encontrado" });
    }
    res.json(item);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});


//Eliminar a un producto por precio
router.delete('/eliminar-por-precio/:precio', async (req, res) => {
  try {
    const item = await Producto.deleteMany({ precio: {$gt:req.params.precio} });
    if (!item) return res.status(404).json({ message: 'Productos no encontrado' });
    res.status(200).json({ message: 'Productos eliminado' });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

router.get('/precio-promedio-por-categoria', async (req, res) => {
  try {
    const item = await Producto.aggregate([
      {
        $group: {
          _id: "$categoria",
          precioPromedio: { $avg: "$precio" }  
        }
      }
    ]);
    res.status(200).json(item);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

router.get('/categoria-mayor-precio-promedio', async (req, res) => {
  try {
    const result = await Producto.aggregate([
      {
        $group: {
          _id: "$categoria",  
          precioPromedio: { $avg: "$precio" } 
        }
      },
      {
        $sort: { precioPromedio: -1 }
      },
      {
        $limit: 1
      }
    ]);
    res.status(200).json(result[0]);  
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;  