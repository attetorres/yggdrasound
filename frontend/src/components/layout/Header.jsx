import { useState } from "react";
import { Link, useLocation, NavLink } from "react-router-dom";
import { useAuthStore } from "../../store/useAuthStore";
import { User, ArrowRight, Home, Disc3, ShoppingCart } from "lucide-react";

const Header = () => {
  const location = useLocation();

  const { isLoggedIn, user, logout } = useAuthStore();
  const [menuOpen, setMenuOpen] = useState(false);
  const [menuCartOpen, setMenuCartOpen] = useState(false);

  const isLoginPage = location.pathname === "/login";
  const isRegisterPage = location.pathname === "/register";

  const navLinkStyles = ({ isActive }) =>
    `mr-4 transition-all duration-300 ${
      isActive
        ? "text-primary-400 border-b-2 border-primary-400 pb-1 font-bold"
        : "text-white hover:text-primary-300"
    }`;

  return (
    <header className="flex bg-neutral-950 text-white p-4 justify-between items-center">
      <nav className="flex items-center gap-3">
        <NavLink to="/" className={navLinkStyles}>
          <span className="flex items-center gap-2">
            <Home size={20} strokeWidth={3} />
            Home
          </span>
        </NavLink>
        <NavLink to="/catalog" className={navLinkStyles}>
          <span className="flex items-center gap-2">
            <Disc3 size={20} strokeWidth={3} /> Catálogo
          </span>
        </NavLink>
      </nav>
      {isLoggedIn ? (
        <div className="flex items-center space-x-3 relative">
          <div className="relative pr-5">
            <div
              onClick={() => {
                setMenuCartOpen(!menuOpen);
                setMenuOpen(false);
              }}
              className="flex items-center gap-2 relative"
            >
              <span className="rounded-full w-3 h-3 absolute -top-1 -right-1 bg-primary-500 text-primary-100 text-[8px] font-bold flex justify-center items-center">
                40
              </span>
              <ShoppingCart size={20} strokeWidth={3} />
            </div>

            {menuCartOpen && (
              <div className="absolute right-0 mt-2 w-48 bg-neutral-900 border border-neutral-700 rounded-lg shadow-xl z-50">
                <div className="p-3 border-b border-neutral-800">
                  <p className="text-sm font-bold text-white">foto articulo</p>
                  <p className="text-xs text-neutral-400">nombre articulo</p>
                  <span>precio</span>
                </div>
                <button
                  onClick={() => {
                    setMenuCartOpen(false);
                  }}
                  className="w-full text-left px-4 py-3 text-sm text-primary-100 hover:bg-primary-400 hover:text-neutral-950 transition-all font-medium"
                >
                  <span className="flex items-center justify-center gap-2">
                    Tramitar pedido
                    <ArrowRight size={20} strokeWidth={3} />
                  </span>
                </button>
              </div>
            )}
          </div>

          <div className="relative">
            <div
              onClick={() => {
                setMenuOpen(!menuOpen);
                setMenuCartOpen(false);
              }}
              className="w-12 h-12 rounded-full bg-neutral-800 flex items-center justify-center text-white font-bold border-2 border-primary-500 cursor-pointer hover:border-white transition-all overflow-hidden group"
            >
              <img
                src={`https://api.dicebear.com/9.x/initials/svg?seed=${user.username}&backgroundColor=9a7b84,7d4c5a,583742`}
                alt={`${user.username} Avatar`}
                className="w-full h-full object-cover grayscale group-hover:grayscale-0 group-hover:scale-110 transition-all duration-500"
              />
            </div>

            {menuOpen && (
              <div className="absolute right-0 mt-2 w-48 bg-neutral-900 border border-neutral-700 rounded-lg shadow-xl z-50">
                <Link
                  to="/profile"
                  onClick={() => setMenuOpen(false)}
                  className="block w-full px-4 py-3 text-sm transition-all border-b border-primary-900/20 text-primary-100 hover:bg-primary-400 hover:text-neutral-950 font-medium"
                >
                  <span className="flex items-center justify-center gap-2">
                    <User size={20} strokeWidth={3} /> Mi Perfil
                  </span>
                </Link>
                <button
                  onClick={() => {
                    setMenuOpen(false);
                    logout();
                  }}
                  className="w-full text-left px-4 py-3 text-sm text-neutral-400 hover:bg-red-950/30 hover:text-red-400 transition-all font-medium flex justify-center"
                >
                  Cerrar Sesión
                </button>
              </div>
            )}
          </div>
        </div>
      ) : (
        <div className="space-x-4">
          {isLoginPage ? (
            <Link to="/register" className="text-white hover:text-primary-300">
              Registro
            </Link>
          ) : isRegisterPage ? (
            <Link to="/login" className="text-white hover:text-primary-300">
              Login
            </Link>
          ) : (
            <>
              <Link to="/login" className="text-white hover:text-primary-300">
                Login
              </Link>
              <span className="text-neutral-400">|</span>
              <Link
                to="/register"
                className="text-white hover:text-primary-300"
              >
                Registro
              </Link>
            </>
          )}
        </div>
      )}
    </header>
  );
};

export default Header;
