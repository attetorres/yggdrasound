import { Link } from "react-router-dom";

const Header = () => {
  return (
    <header className="bg-gray-800 text-white p-4">
      <nav>
        <Link to="/" className="text-white mr-4 hover:text-gray-300">
          Home
        </Link>
        <Link to="/login" className="text-white hover:text-gray-300">
          Login
        </Link>
      </nav>
    </header>
  );
};

export default Header;
