// controllers/cartController.js
import ShoppingCart from "../models/ShoppingCart.js";
import CartItem from "../models/CartItem.js";
import User from "../models/User.js";
import Vinyl from "../models/Vinyl.js";

export const getCartByUserId = async (req, res) => {
  try {
    const { user_id } = req.params;

    const cart = await ShoppingCart.findOne({ where: { user_id } });
    if (!cart) {
      return res.json({ success: true, data: { items: [] } });
    }

    const cartItems = await CartItem.findAll({ where: { cart_id: cart.id } });
    if (cartItems.length === 0) {
      return res.json({ success: true, data: { items: [] } });
    }

    const vinylIds = cartItems.map(item => item.vinyl_id);
    const vinyls = await Vinyl.findAll({
      where: { id: vinylIds },
      attributes: ['id', 'artist', 'album', 'price', 'album_cover']
    });

    const vinylMap = {};
    vinyls.forEach(v => { vinylMap[v.id] = v; });

    const items = [];
    let total = 0;

    cartItems.forEach(item => {
      const vinyl = vinylMap[item.vinyl_id];
      if (vinyl) {
        const subtotal = vinyl.price * item.quantity;
        total += subtotal;
        
        items.push({
          id: item.id,
          quantity: item.quantity,
          vinyl: vinyl,
          subtotal: subtotal.toFixed(2)
        });
      }
    });

    res.json({
      success: true,
      data: {
        cart_id: cart.id,
        user_id: user_id,
        items: items,
        total: total.toFixed(2)
      }
    });
  } catch (error) {
    console.error("Error:", error);
    res.status(500).json({
      success: false,
      message: "Error",
      error: error.message
    });
  }
};

// POST
export const addToCart = async (req, res) => {
  try {
    const { user_id, vinyl_id, quantity = 1 } = req.body;

    if (!user_id || !vinyl_id) {
      return res.status(400).json({
        success: false,
        message: "Faltan datos",
      });
    }

    // Verificar usuario rápido
    const userExists = await User.findByPk(user_id);
    if (!userExists) {
      return res.status(404).json({
        success: false,
        message: "Usuario no existe",
      });
    }

    // Obtener o crear carrito
    let cart = await ShoppingCart.findOne({ where: { user_id } });
    if (!cart) {
      cart = await ShoppingCart.create({ user_id });
    }

    // Añadir/actualizar item
    const [cartItem, created] = await CartItem.findOrCreate({
      where: { cart_id: cart.id, vinyl_id },
      defaults: { quantity: parseInt(quantity) }
    });

    if (!created) {
      cartItem.quantity += parseInt(quantity);
      await cartItem.save();
    }

    // Respuesta ultra simple
    res.status(201).json({
      success: true,
      message: created ? "Añadido al carrito" : "Cantidad actualizada",
      data: {
        id: cartItem.id,
        cart_id: cartItem.cart_id,
        vinyl_id: cartItem.vinyl_id,
        quantity: cartItem.quantity,
      },
    });
  } catch (error) {
    console.error("Error en addToCart:", error);
    res.status(500).json({
      success: false,
      message: "Error",
      error: error.message,
    });
  }
};

// MÉTODOS PUT
export const updateCartItem = async (req, res) => {
  try {
    const { cart_item_id } = req.params;
    const { quantity } = req.body;

    // Validar
    if (!quantity || quantity < 1) {
      return res.status(400).json({
        success: false,
        message: "La cantidad debe ser al menos 1",
      });
    }

    // Buscar el item del carrito
    const cartItem = await CartItem.findByPk(cart_item_id);
    
    if (!cartItem) {
      return res.status(404).json({
        success: false,
        message: "Item del carrito no encontrado",
      });
    }

    // Actualizar cantidad
    cartItem.quantity = parseInt(quantity);
    await cartItem.save();

    // Obtener info del vinilo para respuesta
    const vinyl = await Vinyl.findByPk(cartItem.vinyl_id, {
      attributes: ['id', 'artist', 'album', 'price', 'album_cover']
    });

    res.json({
      success: true,
      message: "Cantidad actualizada",
      data: {
        id: cartItem.id,
        quantity: cartItem.quantity,
        vinyl: vinyl,
        subtotal: vinyl ? (vinyl.price * cartItem.quantity).toFixed(2) : "0.00"
      },
    });
  } catch (error) {
    console.error("Error en updateCartItem:", error);
    res.status(500).json({
      success: false,
      message: "Error al actualizar item",
      error: error.message,
    });
  }
};

// MÉTODOS DELETE
// DELETE /api/cart/remove-item/:cart_item_id
export const deleteFromCart = async (req, res) => {
  try {
    const cartItem = await CartItem.findByPk(req.params.cart_item_id);
    
    if (!cartItem) {
      return res.status(404).json({
        success: false,
        message: "Item no encontrado",
      });
    }

    await cartItem.destroy();

    res.json({
      success: true,
      message: "Item eliminado",
    });
  } catch (error) {
    console.error("Error:", error);
    res.status(500).json({
      success: false,
      message: "Error",
    });
  }
};

export const clearCart = async (req, res) => {
  try {
    const cart = await ShoppingCart.findOne({ 
      where: { user_id: req.params.user_id } 
    });
    
    if (!cart) {
      return res.json({
        success: true,
        message: "No hay carrito",
      });
    }

    await CartItem.destroy({ where: { cart_id: cart.id } });

    res.json({
      success: true,
      message: "Carrito vaciado",
    });
  } catch (error) {
    console.error("Error:", error);
    res.status(500).json({
      success: false,
      message: "Error",
    });
  }
};