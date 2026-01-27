import { Outlet } from "react-router-dom";
import Header from "./Header";
import Footer from "./Footer";

const MainLayout = () => {
  return (
    <div className="min-h-screen flex flex-col">
      <Header />
      <main className="flex-1 p-4 bg-gray-400">
        <Outlet />
      </main>
      <Footer />
    </div>
  );
};

export default MainLayout;
