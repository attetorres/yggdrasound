import User from "../models/User.js";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";

// MÉTODOS GET

export const getUsers = async (req, res) => {
  try {
    const { page = 1, limit = 50 } = req.query;
    const offset = (page - 1) * limit;

    const { count, rows } = await User.findAndCountAll({
      limit: parseInt(limit),
      offset: parseInt(offset),
      order: [["created_at", "DESC"]],
    });

    res.json({
      success: true,
      data: rows,
      pagination: {
        total: count,
        page: parseInt(page),
        limit: parseInt(limit),
        totalPages: Math.ceil(count / limit),
        showingFrom: offset + 1,
        showingTo: Math.min(offset + parseInt(limit), count),
      },
    });
  } catch (error) {
    console.error("Error en getUsers:", error);
    res.status(500).json({
      success: false,
      message: "Error al obtener usuarios",
    });
  }
};

export const getUserById = async (req, res) => {
  try {
    const { id } = req.params;

    const user = await User.findByPk(id);

    if (!user) {
      return res.status(404).json({
        success: false,
        message: `Usuario con ID ${id} no encontrado`,
      });
    }

    res.json({
      success: true,
      data: user,
    });
  } catch (error) {
    console.error("Error en getUserById:", error);

    res.status(500).json({
      success: false,
      message: "Error al obtener usuario",
      error: error.message,
    });
  }
};

export const getUserByUsername = async (req, res) => {
  try {
    const { username } = req.params;

    const user = await User.findOne({
      where: { username: username },
      attributes: { exclude: ["password"] },
    });

    if (!user) {
      return res.status(404).json({
        success: false,
        message: `Usuario con nombre de usuario "${username}" no encontrado`,
      });
    }

    res.json({
      success: true,
      data: user,
    });
  } catch (error) {
    console.error("Error en getUserByUsername:", error);

    res.status(500).json({
      success: false,
      message: "Error al obtener usuario",
      error: error.message,
    });
  }
};

// MÉTODOS POST

export const createUser = async (req, res) => {
  try {
    const {
      name,
      surname,
      username,
      email,
      password,
      avatar_img,
      country,
      city,
      street,
      postcode,
      number,
    } = req.body;

    if (!name || !username || !email || !password) {
      return res.status(400).json({
        success: false,
        message: "Nombre, username, email y password son obligatorios",
      });
    }

    const existingUsername = await User.findOne({
      where: { username },
    });

    if (existingUsername) {
      return res.status(409).json({
        success: false,
        message: `El username "${username}" ya está en uso`,
      });
    }

    const existingEmail = await User.findOne({
      where: { email },
    });

    if (existingEmail) {
      return res.status(409).json({
        success: false,
        message: `El email "${email}" ya está registrado`,
      });
    }

    const saltRounds = 10;
    const hashedPassword = await bcrypt.hash(password, saltRounds);

    const newUser = await User.create({
      is_admin: false,
      name,
      surname: surname || null,
      username,
      email,
      password: hashedPassword,
      avatar_img: avatar_img || null,
      country: country || null,
      city: city || null,
      street: street || null,
      postcode: postcode || null,
      number: number || null,
      last_login_at: null,
    });

    const userResponse = {
      id: newUser.id,
      is_admin: newUser.is_admin,
      name: newUser.name,
      surname: newUser.surname,
      username: newUser.username,
      email: newUser.email,
      avatar_img: newUser.avatar_img,
      country: newUser.country,
      city: newUser.city,
      street: newUser.street,
      postcode: newUser.postcode,
      number: newUser.number,
      created_at: newUser.created_at,
      last_login_at: newUser.last_login_at,
    };

    res.status(201).json({
      success: true,
      message: "Usuario creado exitosamente",
      data: userResponse,
    });
  } catch (error) {
    console.error("Error en createUser:", error);

    if (error.name === "SequelizeValidationError") {
      return res.status(400).json({
        success: false,
        message: "Error de validación",
        errors: error.errors.map((err) => ({
          field: err.path,
          message: err.message,
        })),
      });
    }

    res.status(500).json({
      success: false,
      message: "Error al crear usuario",
      error: error.message,
    });
  }
};

export const loginUser = async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await User.findOne({ where: { email } });
    if (!user) {
      return res
        .status(404)
        .json({ success: false, message: "Usuario no encontrado" });
    }

    const isPasswordValid = await bcrypt.compare(password, user.password);
    if (!isPasswordValid) {
      return res
        .status(401)
        .json({ success: false, message: "Contraseña incorrecta" });
    }

    const token = jwt.sign(
      { id: user.id, is_admin: user.is_admin },
      process.env.JWT_SECRET,
      { expiresIn: "24h" },
    );

    res.json({
      success: true,
      message: "Logueado con éxito",
      token,
      user: {
        id: user.id,
        username: user.username,
        email: user.email,
        is_admin: user.is_admin,
      },
    });
  } catch (error) {
    console.error("ERROR EN EL LOGIN:", error);
    res.status(500).json({
      success: false,
      message: "Error interno del servidor",
      error: error.message,
    });
  }
};

// MÉTODOS PUT

export const updateUser = async (req, res) => {
  try {
    const { id } = req.params;
    const {
      name,
      surname,
      username,
      email,
      avatar_img,
      country,
      city,
      street,
      postcode,
      number,
      is_admin,
    } = req.body;

    const user = await User.findByPk(id);

    if (!user) {
      return res.status(404).json({
        success: false,
        message: `Usuario con ID ${id} no encontrado`,
      });
    }

    if (username && username !== user.username) {
      const existingUsername = await User.findOne({
        where: { username },
      });

      if (existingUsername) {
        return res.status(409).json({
          success: false,
          message: `El username "${username}" ya está en uso`,
        });
      }
    }

    if (email && email !== user.email) {
      const existingEmail = await User.findOne({
        where: { email },
      });

      if (existingEmail) {
        return res.status(409).json({
          success: false,
          message: `El email "${email}" ya está registrado`,
        });
      }
    }

    const updateData = {};
    if (name !== undefined) updateData.name = name;
    if (surname !== undefined) updateData.surname = surname;
    if (username !== undefined) updateData.username = username;
    if (email !== undefined) updateData.email = email;
    if (avatar_img !== undefined) updateData.avatar_img = avatar_img;
    if (country !== undefined) updateData.country = country;
    if (city !== undefined) updateData.city = city;
    if (street !== undefined) updateData.street = street;
    if (postcode !== undefined) updateData.postcode = postcode;
    if (number !== undefined) updateData.number = number;
    if (is_admin !== undefined) updateData.is_admin = is_admin;

    await user.update(updateData);

    const userResponse = {
      id: user.id,
      is_admin: user.is_admin,
      name: user.name,
      surname: user.surname,
      username: user.username,
      email: user.email,
      avatar_img: user.avatar_img,
      country: user.country,
      city: user.city,
      street: user.street,
      postcode: user.postcode,
      number: user.number,
      created_at: user.created_at,
      updated_at: user.updated_at,
      last_login_at: user.last_login_at,
    };

    res.json({
      success: true,
      message: "Usuario actualizado exitosamente",
      data: userResponse,
    });
  } catch (error) {
    console.error("Error en updateUser:", error);
    res.status(500).json({
      success: false,
      message: "Error al actualizar usuario",
      error: error.message,
    });
  }
};

// MÉTODOS DELETE

export const deleteUser = async (req, res) => {
  try {
    const { id } = req.params;

    const user = await User.findByPk(id);

    if (!user) {
      return res.status(404).json({
        success: false,
        message: `Usuario con ID ${id} no encontrado`,
      });
    }

    await user.destroy();

    res.json({
      success: true,
      message: "Usuario eliminado exitosamente",
    });
  } catch (error) {
    console.error("Error en deleteUser:", error);
    res.status(500).json({
      success: false,
      message: "Error al eliminar usuario",
      error: error.message,
    });
  }
};
