import React from "react";
import { showToast } from "../components/utils/toast";
import { Link, useNavigate } from "react-router-dom";
import { useState } from "react";
import { registerUser } from "../services/authService";
import { loginUser } from "../services/authService";
import { useAuthStore } from "../store/useAuthStore";

const Register = () => {
  const [form, setForm] = useState({
    name: "",
    surname: "",
    username: "",
    email: "",
    password: "",
    confirmPassword: "",
    country: "",
    city: "",
    street: "",
    postcode: "",
    number: "",
    acceptTerms: false,
  });
  const [loading, setLoading] = useState(false);
  const [showTermsModal, setShowTermsModal] = useState(false);

  const loginStore = useAuthStore((state) => state.login);
  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (form.password !== form.confirmPassword) {
      showToast.info("Las contraseñas no coinciden");
      return;
    }

    setLoading(true);
    try {
      const response = await registerUser(form);

      if (response.success) {
        showToast.success("Registrado con éxito");
        const loginRes = await loginUser({
          email: form.email,
          password: form.password,
        });

        if (loginRes.success) {
          loginStore(loginRes.user, loginRes.token);
          navigate("/");
          showToast.success(`"¡Hola, ${loginRes.user.username}!"`);
        }
      } else {
        alert(response.message || "Error al registrar");
      }
    } catch (error) {
      console.log("Error de conexión", error);
      showToast.error("Error al registrarse");
    } finally {
      setLoading(false);
    }
  };

  const handleChange = (e) => {
    const { name, value, type, checked } = e.target;
    setForm({
      ...form,
      [name]: type === "checkbox" ? checked : value,
    });
  };

  return (
    <div className="flex justify-center items-center min-h-[84vh] p-4">
      <div className="border-2 border-primary-500 rounded-xl p-8 w-full max-w-2xl bg-linear-to-b from-primary-50/30 to-primary-100/10 shadow-lg">
        <h2 className="text-2xl font-bold text-center mb-6 text-primary-900">
          Crear Cuenta
        </h2>

        <form onSubmit={handleSubmit} className="space-y-6">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label className="block mb-2 text-primary-800 font-medium">
                Nombre *
              </label>
              <input
                type="text"
                name="name"
                className="w-full border-2 border-primary-300 rounded-lg px-4 py-3 
                         focus:outline-none focus:border-primary-500 focus:ring-2 
                         focus:ring-primary-200 transition-colors bg-white"
                placeholder="Juan"
                value={form.name}
                onChange={handleChange}
                required
              />
            </div>

            <div>
              <label className="block mb-2 text-primary-800 font-medium">
                Apellidos
              </label>
              <input
                type="text"
                name="surname"
                className="w-full border-2 border-primary-300 rounded-lg px-4 py-3 
                         focus:outline-none focus:border-primary-500 focus:ring-2 
                         focus:ring-primary-200 transition-colors bg-white"
                placeholder="Pérez García"
                value={form.surname}
                onChange={handleChange}
              />
            </div>

            <div>
              <label className="block mb-2 text-primary-800 font-medium">
                Usuario *
              </label>
              <input
                type="text"
                name="username"
                className="w-full border-2 border-primary-300 rounded-lg px-4 py-3 
                         focus:outline-none focus:border-primary-500 focus:ring-2 
                         focus:ring-primary-200 transition-colors bg-white"
                placeholder="juanperez"
                value={form.username}
                onChange={handleChange}
                required
              />
            </div>

            <div>
              <label className="block mb-2 text-primary-800 font-medium">
                Email *
              </label>
              <input
                type="email"
                name="email"
                className="w-full border-2 border-primary-300 rounded-lg px-4 py-3 
                         focus:outline-none focus:border-primary-500 focus:ring-2 
                         focus:ring-primary-200 transition-colors bg-white"
                placeholder="juan@email.com"
                value={form.email}
                onChange={handleChange}
                required
              />
            </div>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label className="block mb-2 text-primary-800 font-medium">
                Contraseña *
              </label>
              <input
                type="password"
                name="password"
                className="w-full border-2 border-primary-300 rounded-lg px-4 py-3 
                         focus:outline-none focus:border-primary-500 focus:ring-2 
                         focus:ring-primary-200 transition-colors bg-white"
                placeholder="Mínimo 8 caracteres"
                value={form.password}
                onChange={handleChange}
                required
                minLength="8"
              />
            </div>

            <div>
              <label className="block mb-2 text-primary-800 font-medium">
                Confirmar Contraseña *
              </label>
              <input
                type="password"
                name="confirmPassword"
                className="w-full border-2 border-primary-300 rounded-lg px-4 py-3 
                         focus:outline-none focus:border-primary-500 focus:ring-2 
                         focus:ring-primary-200 transition-colors bg-white"
                placeholder="Repite tu contraseña"
                value={form.confirmPassword}
                onChange={handleChange}
                required
              />
            </div>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label className="block mb-2 text-primary-800 font-medium">
                País
              </label>
              <input
                type="text"
                name="country"
                className="w-full border-2 border-primary-300 rounded-lg px-4 py-3 
                         focus:outline-none focus:border-primary-500 focus:ring-2 
                         focus:ring-primary-200 transition-colors bg-white"
                placeholder="España"
                value={form.country}
                onChange={handleChange}
              />
            </div>

            <div>
              <label className="block mb-2 text-primary-800 font-medium">
                Ciudad
              </label>
              <input
                type="text"
                name="city"
                className="w-full border-2 border-primary-300 rounded-lg px-4 py-3 
                         focus:outline-none focus:border-primary-500 focus:ring-2 
                         focus:ring-primary-200 transition-colors bg-white"
                placeholder="Madrid"
                value={form.city}
                onChange={handleChange}
              />
            </div>

            <div>
              <label className="block mb-2 text-primary-800 font-medium">
                Calle
              </label>
              <input
                type="text"
                name="street"
                className="w-full border-2 border-primary-300 rounded-lg px-4 py-3 
                         focus:outline-none focus:border-primary-500 focus:ring-2 
                         focus:ring-primary-200 transition-colors bg-white"
                placeholder="Calle Principal"
                value={form.street}
                onChange={handleChange}
              />
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div>
                <label className="block mb-2 text-primary-800 font-medium">
                  Código Postal
                </label>
                <input
                  type="text"
                  name="postcode"
                  className="w-full border-2 border-primary-300 rounded-lg px-4 py-3 
                           focus:outline-none focus:border-primary-500 focus:ring-2 
                           focus:ring-primary-200 transition-colors bg-white"
                  placeholder="28001"
                  value={form.postcode}
                  onChange={handleChange}
                />
              </div>

              <div>
                <label className="block mb-2 text-primary-800 font-medium">
                  Número
                </label>
                <input
                  type="text"
                  name="number"
                  className="w-full border-2 border-primary-300 rounded-lg px-4 py-3 
                           focus:outline-none focus:border-primary-500 focus:ring-2 
                           focus:ring-primary-200 transition-colors bg-white"
                  placeholder="123"
                  value={form.number}
                  onChange={handleChange}
                />
              </div>
            </div>
          </div>

          <div className="flex items-start">
            <input
              type="checkbox"
              name="acceptTerms"
              id="acceptTerms"
              className="mt-1 mr-2 text-primary-600"
              checked={form.acceptTerms}
              onChange={handleChange}
              required
            />
            <label htmlFor="acceptTerms" className="text-primary-700 text-sm">
              Acepto los{" "}
              <button
                type="button"
                onClick={() => setShowTermsModal(true)}
                className="text-primary-600 font-bold hover:underline focus:outline-none"
              >
                términos y condiciones
              </button>{" "}
              y la política de privacidad *
            </label>
          </div>

          <div className="flex flex-col sm:flex-row gap-4 pt-4">
            <button
              type="submit"
              disabled={loading}
              className={`flex-1 py-3 rounded-lg font-semibold transition-all duration-300 shadow-md 
              ${
                loading
                  ? "bg-gray-400 cursor-not-allowed"
                  : "bg-linear-to-r from-primary-600 to-primary-700 text-white hover:from-primary-700 hover:to-primary-800 hover:shadow-lg"
              }`}
            >
              {loading ? "Creando cuenta..." : "Crear Cuenta"}
            </button>
            <button
              type="button"
              disabled={loading}
              className="flex-1 border-2 border-primary-500 text-primary-700 
                       py-3 rounded-lg font-semibold hover:bg-primary-50 
                       transition-all duration-300"
              onClick={() => window.history.back()}
            >
              Cancelar
            </button>
          </div>

          <div className="text-center pt-4 border-t border-primary-200">
            <p className="text-primary-700">
              ¿Ya tienes cuenta?{" "}
              <Link
                to="/login"
                className="text-primary-600 font-semibold 
                           hover:text-primary-800 hover:underline"
              >
                Inicia Sesión
              </Link>
            </p>
          </div>
        </form>
      </div>
      {showTermsModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-sm">
          <div className="bg-white rounded-2xl max-w-md w-full p-6 shadow-2xl border border-primary-100 animate-in fade-in zoom-in duration-200">
            <h3 className="text-xl font-bold text-primary-900 mb-4 flex items-center gap-2">
              Aviso Educativo
            </h3>

            <div className="text-primary-700 leading-relaxed space-y-4 text-sm">
              <p>
                Este sitio web es un <strong>proyecto final académico</strong>{" "}
                para el Ciclo Superior de Desarrollo de Aplicaciones Web (DAW).
              </p>
              <p className="bg-amber-50 border-l-4 border-amber-400 p-3 text-amber-900 font-medium">
                ⚠️ <strong>IMPORTANTE:</strong> No introduzcas datos reales. No
                se realizarán transacciones reales y todo el proceso de compra
                es una simulación.
              </p>
              <p>
                Los datos de los productos son obtenidos de{" "}
                <strong>Bandcamp</strong> con fines exclusivamente
                demostrativos.
              </p>
            </div>

            <button
              onClick={() => setShowTermsModal(false)}
              className="w-full mt-6 bg-primary-600 hover:bg-primary-700 text-white font-semibold py-2 rounded-lg transition-colors"
            >
              Entendido
            </button>
          </div>
        </div>
      )}
    </div>
  );
};

export default Register;
