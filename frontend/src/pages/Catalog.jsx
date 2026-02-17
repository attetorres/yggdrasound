import React, { useEffect, useState } from "react";
import { getAllVinyls } from "../services/vinylService";
import VinylCard from "../components/common/VinylCard";
import {
  Link,
  useParams,
  useNavigate,
  useSearchParams,
} from "react-router-dom";

const Catalog = () => {
  const { param_genre } = useParams();
  const navigate = useNavigate();

  const [searchParams, setSearchParams] = useSearchParams();
  const currentPage = parseInt(searchParams.get("page") || "1");

  const [vinylsData, setVinylsData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [genre, setGenre] = useState(param_genre || "");
  const [search, setSearch] = useState(searchParams.get("search") || "");
  const [sort, setSort] = useState(searchParams.get("sort") || "newest");

  useEffect(() => {
    setGenre(param_genre || "");
  }, [param_genre]);

  const changePage = (newPage) => {
    const newParams = new URLSearchParams(searchParams);
    newParams.set("page", newPage);
    setSearchParams(newParams);
  };

  const handleGenreChange = (e) => {
    const selectedValue = e.target.value;
    setGenre(selectedValue);

    const baseRoute = selectedValue ? `/catalog/${selectedValue}` : "/catalog";

    const queryString = `?page=1${search ? `&search=${search}` : ""}${sort ? `&sort=${sort}` : ""}`;

    navigate(baseRoute + queryString);
  };

  const fetchVinyls = async () => {
    try {
      setLoading(true);
      const res = await getAllVinyls(currentPage, 30, search, genre, sort);
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
  }, [currentPage, search, genre, sort]);

  if (loading && !vinylsData)
    return <div className="p-10 text-white">Cargando vinilos...</div>;

  return (
    <div className="min-h-screen flex flex-col gap-6">
      <div className="p-8 rounded-2xl border border-neutral-800 bg-neutral-950 text-white flex flex-col md:flex-row justify-between items-center gap-4">
        <div className="w-full lg:w-auto text-center lg:text-left">
          <h1 className="text-3xl font-black italic tracking-tighter uppercase leading-none">
            Catálogo
          </h1>
        </div>

        <div className="flex flex-col md:flex-row items-center gap-3 w-full lg:w-auto">
          <div className="relative w-full md:w-64 group">
            <input
              type="text"
              placeholder="Artista, álbum..."
              value={search}
              className="w-full bg-neutral-900/50 border border-neutral-800 rounded-xl px-4 py-2 pl-10 text-neutral-100 text-sm focus:outline-none focus:border-white/30 transition-all placeholder:text-neutral-600"
              onChange={(e) => {
                setSearch(e.target.value);
                changePage(1);
              }}
            />
            <svg
              className="absolute left-3 top-2.5 w-4 h-4 text-neutral-600 group-focus-within:text-white transition-colors"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth="2"
                d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
              />
            </svg>
          </div>

          <select
            value={genre}
            onChange={handleGenreChange}
            className="w-full md:w-auto bg-neutral-900/50 border border-neutral-800 rounded-xl px-4 py-2 text-sm focus:outline-none focus:border-white/30 cursor-pointer text-neutral-100 hover:text-white transition-all appearance-none pr-10 relative"
          >
            <option value="">Todos los Géneros</option>
            <option value="rock">Rock</option>
            <option value="electronic">Electronic</option>
            <option value="metal">Metal</option>
            <option value="alternative">Alternative</option>
            <option value="hip-hop-rap">Hip Hop / Rap</option>
            <option value="experimental">Experimental</option>
            <option value="punk">Punk</option>
            <option value="pop">Pop</option>
            <option value="ambient">Ambient</option>
          </select>

          <select
            value={sort}
            onChange={(e) => {
              setSort(e.target.value);
              changePage(1);
            }}
            className="w-full md:w-auto bg-neutral-900/50 border border-neutral-800 rounded-xl px-4 py-2 text-sm focus:outline-none focus:border-white/30 cursor-pointer text-neutral-100 hover:text-white transition-all appearance-none pr-10"
          >
            <option value="newest">Más nuevos</option>
            <option value="oldest">Más antiguos</option>
            <option value="price-asc">Precio: Bajo a Alto</option>
            <option value="price-desc">Precio: Alto a Bajo</option>
          </select>
        </div>
      </div>

      <div className="p-8  min-h-screen text-white">
        <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-5 xl:grid-cols-6 gap-8">
          {vinylsData?.data.map((vinyl) => (
            <Link to={`/vinyl-details/${vinyl.id}`} key={vinyl.id}>
              <VinylCard vinyl={vinyl} />
            </Link>
          ))}
        </div>

        <div className="mt-8 flex gap-6 items-center justify-center border-t border-neutral-800/50 pt-8">
          <button
            onClick={() => changePage(currentPage - 1)}
            disabled={currentPage === 1}
            className="bg-neutral-800 hover:bg-neutral-400 px-5 py-2 rounded-xl disabled:opacity-20 disabled:cursor-not-allowed transition-colors cursor-pointer text-sm font-medium"
          >
            Anterior
          </button>

          <div className="flex flex-col items-center">
            <span className="text-neutral-800 font-bold">
              {currentPage}{" "}
              <span className="text-neutral-950 font-normal mx-1"> de </span>{" "}
              {vinylsData?.pagination.totalPages || "?"}
            </span>
          </div>

          <button
            onClick={() => changePage(currentPage + 1)}
            disabled={currentPage === vinylsData?.pagination.totalPages}
            className="bg-neutral-800 hover:bg-neutral-700 px-5 py-2 rounded-xl disabled:opacity-20 disabled:cursor-not-allowed transition-colors cursor-pointer text-sm font-medium"
          >
            Siguiente
          </button>
        </div>
      </div>
    </div>
  );
};

export default Catalog;
