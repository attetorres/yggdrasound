import { useState } from "react";
import { Link, useLocation, NavLink } from "react-router-dom";
import { useAuthStore } from "../../store/useAuthStore";

const Header = () => {
  const location = useLocation();

  const { isLoggedIn, user, logout } = useAuthStore();
  const [menuOpen, setMenuOpen] = useState(false);

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
      <nav>
        <NavLink to="/" className={navLinkStyles}>
          Home
        </NavLink>
        <NavLink to="/catalog" className={navLinkStyles}>
          Catálogo
        </NavLink>
      </nav>
      {isLoggedIn ? (
        <div className="flex items-center space-x-3 relative">
          <span className="text-sm text-neutral-400 hidden md:block">
            Hola, {user?.username}
          </span>

          <div className="relative">
            <div
              onClick={() => setMenuOpen(!menuOpen)}
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
                <div className="p-3 border-b border-neutral-800 md:hidden">
                  <p className="text-sm font-bold text-white">
                    {user?.username}
                  </p>
                  <p className="text-xs text-neutral-400">{user?.email}</p>
                </div>
                <Link
                  to="/profile"
                  onClick={() => setMenuOpen(false)}
                  className="block w-full px-4 py-3 text-sm text-primary-100 hover:bg-primary-800/40 hover:text-primary-300 transition-all border-b border-primary-900/20"
                >
                  Mi Perfil
                </Link>
                <button
                  onClick={() => {
                    setMenuOpen(false);
                    logout();
                  }}
                  className="w-full text-left px-4 py-3 text-sm text-neutral-400 hover:bg-red-950/30 hover:text-red-400 transition-all font-medium"
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
