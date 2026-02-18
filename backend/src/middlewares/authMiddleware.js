import jwt from "jsonwebtoken";

export const verifyToken = (req, res, next) => {
  const authHeader = req.headers["authorization"];

  let token;
  if (authHeader) {
    token = authHeader.split(" ")[1];
  } else {
    token = undefined;
  }

  if (!token) {
    return res
      .status(403)
      .json({ success: false, message: "No se proporcionó un token" });
  }

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);

    req.user = decoded;

    next();
  } catch (error) {
    return res
      .status(401)
      .json({ success: false, message: "Token inválido o expirado" });
  }
};

export const isAdmin = (req, res, next) => {
  if (req.user && req.user.is_admin) {
    next();
  } else {
    return res.status(403).json({
      success: false,
      message: "Acceso denegado: Se requieren permisos de administrador",
    });
  }
};
