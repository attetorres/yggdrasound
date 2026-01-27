import { Link, useLocation } from "react-router-dom";

const Header = () => {
  const location = useLocation();

  const isLoginPage = location.pathname === "/login";
  const isRegisterPage = location.pathname === "/register";

  return (
    <header className="flex bg-neutral-950 text-white p-4 justify-between">
      <nav>
        <Link to="/" className="text-white mr-4 hover:text-primary-300">
          Home
        </Link>
      </nav>
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
            <Link to="/register" className="text-white hover:text-primary-300">
              Registro
            </Link>
          </>
        )}
      </div>
    </header>
  );
};

export default Header;
