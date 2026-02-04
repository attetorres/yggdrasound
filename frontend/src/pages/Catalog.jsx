import React, { useEffect, useState } from "react";
import { getAllVinyls } from "../services/vinylService";

const Catalog = () => {
  const [vinylsData, setVinylsData] = useState(null);
  const [currentPage, setCurrentPage] = useState(1);
  const [loading, setLoading] = useState(true);

  const fetchVinyls = async () => {
    try {
      setLoading(true);
      const res = await getAllVinyls(currentPage, 25);
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
    <div className="p-8 bg-neutral-950 min-h-screen text-white">
      <h1 className="text-2xl font-bold mb-6">Vinilos</h1>

      <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
        {vinylsData?.data.map((vinyl) => (
          <div
            key={vinyl.id}
            className="bg-neutral-900 p-4 rounded border border-neutral-800"
          >
            <h3 className="font-semibold">{vinyl.title}</h3>
            <img src={vinyl.album_cover} alt="" />
            <p className="text-sm text-neutral-400">{vinyl.artist}</p>
          </div>
        ))}
      </div>

      <div className="mt-8 flex gap-4 items-center">
        <button
          onClick={() => setCurrentPage(currentPage - 1)}
          disabled={currentPage === 1}
          className="bg-neutral-800 px-4 py-2 rounded disabled:opacity-20"
        >
          Anterior
        </button>

        <span>Página {currentPage}</span>

        <button
          onClick={() => setCurrentPage(currentPage + 1)}
          disabled={currentPage === vinylsData?.pagination.totalPages}
          className="bg-neutral-800 px-4 py-2 rounded disabled:opacity-20"
        >
          Siguiente
        </button>
      </div>
    </div>
  );
};

export default Catalog;
