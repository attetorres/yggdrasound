import React from "react";
import { showToast } from "../components/utils/toast";
import { Link, useNavigate } from "react-router-dom";
import { useState } from "react";
import { loginUser } from "../services/authService";
import { useAuthStore } from "../store/useAuthStore";

const Login = () => {
  const [form, setForm] = useState({ email: "", password: "" });

  const loginGlobal = useAuthStore((state) => state.login);
  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();
    const data = await loginUser(form);

    if (data.success) {
      loginGlobal(data.user, data.token);
      navigate("/");
      showToast.success(`"¡Hola, ${data.user.username}!"`);
    } else {
      console.error("Error en el login:", data.message);
      showToast.success("Error al iniciar sesión");
    }
  };

  return (
    <div className="flex justify-center items-center min-h-[70vh] p-4">
      <div className="border-2 border-primary-500 rounded-xl p-8 w-full max-w-md bg-linear-to-b from-primary-50/30 to-primary-100/10 shadow-lg">
        <h2 className="text-2xl font-bold text-center mb-6 text-primary-900">
          Iniciar Sesión
        </h2>

        <form onSubmit={handleSubmit} className="space-y-6">
          <div>
            <label className="block mb-2 text-primary-800 font-medium">
              Email:
            </label>
            <input
              type="email"
              className="w-full border-2 border-primary-300 rounded-lg px-4 py-3 
                       focus:outline-none focus:border-primary-500 focus:ring-2 
                       focus:ring-primary-200 transition-colors bg-white"
              placeholder="tu@email.com"
              value={form.email}
              onChange={(e) => setForm({ ...form, email: e.target.value })}
              required
            />
          </div>

          <div>
            <label className="block mb-2 text-primary-800 font-medium">
              Contraseña:
            </label>
            <input
              type="password"
              className="w-full border-2 border-primary-300 rounded-lg px-4 py-3 
                       focus:outline-none focus:border-primary-500 focus:ring-2 
                       focus:ring-primary-200 transition-colors bg-white"
              placeholder="••••••••"
              value={form.password}
              onChange={(e) => setForm({ ...form, password: e.target.value })}
              required
            />
          </div>

          <div className="flex items-center justify-between">
            <label className="flex items-center">
              <input type="checkbox" className="mr-2 text-primary-600" />
              <span className="text-primary-700">Recordarme</span>
            </label>
            <a
              href="#"
              className="text-primary-600 hover:text-primary-800 
                                 hover:underline transition-colors"
            >
              ¿Olvidaste tu contraseña?
            </a>
          </div>

          <button
            type="submit"
            className="w-full bg-linear-to-r from-primary-600 to-primary-700 
                     text-white py-3 rounded-lg font-semibold hover:from-primary-700 
                     hover:to-primary-800 transition-all duration-300 
                     shadow-md hover:shadow-lg"
          >
            Entrar
          </button>

          <div className="text-center pt-4 border-t border-primary-200">
            <p className="text-primary-700">
              ¿No tienes cuenta?{" "}
              <Link
                to="/register"
                className="text-primary-600 font-semibold 
                 hover:text-primary-800 hover:underline"
              >
                Regístrate aquí
              </Link>
            </p>
          </div>
        </form>
      </div>
    </div>
  );
};

export default Login;
