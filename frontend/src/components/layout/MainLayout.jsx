import React from "react";
import { Outlet } from "react-router-dom";

const MainLayout = () => {
  return (
    <div>
      <h1>Mi Header</h1>
      <Outlet />
      <footer>Mi Footer</footer>
    </div>
  );
};

export default MainLayout;
