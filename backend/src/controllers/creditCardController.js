import CreditCard from "../models/CreditCard.js";
import User from "../models/User.js";

// MÉTODOS GET
export const getCreditCards = async (req, res) => {
  try {
    const creditCards = await CreditCard.findAll({
      order: [["created_at", "DESC"]],
    });

    res.json({
      success: true,
      data: creditCards,
      count: creditCards.length,
    });
  } catch (error) {
    console.error("Error:", error);
    res.status(500).json({
      success: false,
      message: "Error",
    });
  }
};

export const getCreditCardById = async (req, res) => {
  try {
    const creditCard = await CreditCard.findByPk(req.params.id);

    if (!creditCard) {
      return res.status(404).json({
        success: false,
        message: "Tarjeta no encontrada",
      });
    }

    const user = await User.findByPk(creditCard.user_id, {
      attributes: ["id", "username", "name"],
    });

    res.json({
      success: true,
      data: {
        ...creditCard.toJSON(),
        user: user,
      },
    });
  } catch (error) {
    console.error("Error:", error);
    res.status(500).json({
      success: false,
      message: "Error",
    });
  }
};

export const getCreditCardsByUserId = async (req, res) => {
  try {
    const { user_id } = req.params;

    const user = await User.findByPk(user_id);
    if (!user) {
      return res.status(404).json({
        success: false,
        message: "Usuario no encontrado",
      });
    }

    const creditCards = await CreditCard.findAll({
      where: { user_id },
      order: [
        ["is_default", "DESC"],
        ["created_at", "DESC"],
      ],
    });

    res.json({
      success: true,
      data: {
        user: {
          id: user.id,
          username: user.username,
          name: user.name,
        },
        credit_cards: creditCards,
        count: creditCards.length,
      },
    });
  } catch (error) {
    console.error("Error:", error);
    res.status(500).json({
      success: false,
      message: "Error",
    });
  }
};

// MÉTODOS POST
export const createCreditCard = async (req, res) => {
  try {
    const {
      user_id,
      card_number,
      expiration_date,
      cvv,
      brand,
      is_default = false,
    } = req.body;

    if (!user_id || !card_number || !expiration_date || !cvv || !brand) {
      return res.status(400).json({
        success: false,
        message: "Todos los campos son obligatorios",
      });
    }

    const user = await User.findByPk(user_id);
    if (!user) {
      return res.status(404).json({
        success: false,
        message: "Usuario no encontrado",
      });
    }

    // Limpiar tarjeta (quitar espacios)
    const cleanCardNumber = card_number.replace(/\s/g, "");

    // Verificar si ya existe esta tarjeta para este usuario
    const existingCard = await CreditCard.findOne({
      where: {
        user_id,
        card_number: cleanCardNumber,
      },
    });

    if (existingCard) {
      return res.status(409).json({
        success: false,
        message: "Esta tarjeta ya está registrada para este usuario",
        data: {
          existing_card_id: existingCard.id,
          brand: existingCard.brand,
          last_four: cleanCardNumber.slice(-4),
        },
      });
    }

    // Si se marca como default, quitar default de otras tarjetas
    if (is_default) {
      await CreditCard.update({ is_default: false }, { where: { user_id } });
    }

    const creditCard = await CreditCard.create({
      user_id,
      card_number: cleanCardNumber,
      expiration_date,
      cvv,
      brand,
      is_default,
    });

    // No devolver datos sensibles en respuesta
    const safeResponse = {
      id: creditCard.id,
      user_id: creditCard.user_id,
      brand: creditCard.brand,
      last_four: cleanCardNumber.slice(-4),
      expiration_date: creditCard.expiration_date,
      is_default: creditCard.is_default,
      created_at: creditCard.created_at,
    };

    res.status(201).json({
      success: true,
      message: "Tarjeta creada",
      data: safeResponse,
    });
  } catch (error) {
    console.error("Error:", error);
    res.status(500).json({
      success: false,
      message: "Error",
      error: error.message,
    });
  }
};

// MÉTODOS PUT
export const setDefaultCard = async (req, res) => {
  try {
    const creditCard = await CreditCard.findByPk(req.params.id);

    if (!creditCard) {
      return res.status(404).json({
        success: false,
        message: "Tarjeta no encontrada",
      });
    }

    // Verificar si ya era la tarjeta predeterminada
    const wasDefault = creditCard.is_default;

    // Si ya era la predeterminada, desactivarla
    if (wasDefault) {
      creditCard.is_default = false;
      await creditCard.save();

      return res.json({
        success: true,
        message: "Tarjeta desactivada como predeterminada",
        data: creditCard,
      });
    }

    // Si no era predeterminada, quitar default de todas las tarjetas del usuario
    await CreditCard.update(
      { is_default: false },
      { where: { user_id: creditCard.user_id } },
    );

    // Poner esta como default
    creditCard.is_default = true;
    await creditCard.save();

    res.json({
      success: true,
      message: "Tarjeta establecida como predeterminada",
      data: creditCard,
    });
  } catch (error) {
    console.error("Error:", error);
    res.status(500).json({
      success: false,
      message: "Error interno del servidor",
    });
  }
};

export const deleteCreditCard = async (req, res) => {
  try {
    const creditCard = await CreditCard.findByPk(req.params.id);

    if (!creditCard) {
      return res.status(404).json({
        success: false,
        message: "Tarjeta no encontrada",
      });
    }

    const wasDefault = creditCard.is_default;
    const userId = creditCard.user_id;

    await creditCard.destroy();

    // Si era la tarjeta por defecto, buscar otra para poner como default
    let newDefaultCard = null;
    if (wasDefault) {
      // Buscar la tarjeta más reciente del mismo usuario
      const latestCard = await CreditCard.findOne({
        where: { user_id: userId },
        order: [["created_at", "DESC"]],
      });

      if (latestCard) {
        latestCard.is_default = true;
        await latestCard.save();
        newDefaultCard = {
          id: latestCard.id,
          brand: latestCard.brand,
          last_four: latestCard.card_number.slice(-4),
        };
      }
    }

    const response = {
      success: true,
      message: "Tarjeta eliminada",
    };

    if (wasDefault && newDefaultCard) {
      response.message =
        "Tarjeta por defecto eliminada. Nueva tarjeta por defecto asignada";
      response.new_default_card = newDefaultCard;
    } else if (wasDefault && !newDefaultCard) {
      response.message =
        "Tarjeta por defecto eliminada. No hay más tarjetas disponibles";
    }

    res.json(response);
  } catch (error) {
    console.error("Error:", error);
    res.status(500).json({
      success: false,
      message: "Error",
    });
  }
};
