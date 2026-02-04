import React, { useEffect, useState } from "react";
import { getAllVinyls } from "../services/vinylService";
import VinylCard from "../components/common/VinylCard";

const Catalog = () => {
  const [vinylsData, setVinylsData] = useState(null);
  const [currentPage, setCurrentPage] = useState(1);
  const [loading, setLoading] = useState(true);

  const fetchVinyls = async () => {
    try {
      setLoading(true);
      const res = await getAllVinyls(currentPage, 30);
      if (res.success) {
        setVinylsData(res);
      }
    } catch (error) {
      console.error("Error:", error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchVinyls();
  }, [currentPage]);

  if (loading && !vinylsData)
    return <div className="p-10 text-white">Cargando vinilos...</div>;

  return (
    <div className="p-8 rounded-2xl border bg-neutral-950 min-h-screen text-white">
      <h1 className="text-2xl font-bold mb-6">Vinilos</h1>

      <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-5 xl:grid-cols-6 gap-8">
        {vinylsData?.data.map((vinyl) => (
          <VinylCard key={vinyl.id} vinyl={vinyl} />
        ))}
      </div>

      <div className="mt-8 flex gap-6 items-center justify-center border-t border-neutral-800/50 pt-8">
        <button
          onClick={() => setCurrentPage(currentPage - 1)}
          disabled={currentPage === 1}
          className="bg-neutral-800 hover:bg-neutral-400 px-5 py-2 rounded-xl disabled:opacity-20 disabled:cursor-not-allowed transition-colors cursor-pointer text-sm font-medium"
        >
          Anterior
        </button>

        <div className="flex flex-col items-center">
          <span className="text-neutral-400 text-xs uppercase tracking-widest mb-1">
            Página
          </span>
          <span className="text-white font-bold">
            {currentPage}{" "}
            <span className="text-neutral-500 font-normal mx-1">de</span>{" "}
            {vinylsData?.pagination.totalPages || "?"}
          </span>
        </div>

        <button
          onClick={() => setCurrentPage(currentPage + 1)}
          disabled={currentPage === vinylsData?.pagination.totalPages}
          className="bg-neutral-800 hover:bg-neutral-400 px-5 py-2 rounded-xl disabled:opacity-20 disabled:cursor-not-allowed transition-colors cursor-pointer text-sm font-medium"
        >
          Siguiente
        </button>
      </div>
    </div>
  );
};

export default Catalog;
