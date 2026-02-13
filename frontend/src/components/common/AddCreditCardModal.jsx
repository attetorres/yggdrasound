import React, { useState } from "react";
import { X, CreditCard, Lock } from "lucide-react";

const AddCreditCardModal = ({ isOpen, onClose, onSuccess }) => {
  const initialState = {
    card_number: "",
    expiration_date: "",
    cvv: "",
    brand: "VISA",
  };

  const [formData, setFormData] = useState(initialState);

  if (!isOpen) return null;

  const handleChange = (e) => {
    const { name, value } = e.target;
    let newBrand = formData.brand;

    if (name === "card_number") {
      if (value.startsWith("4")) newBrand = "VISA";
      else if (value.startsWith("5")) newBrand = "MASTERCARD";
      else if (value.startsWith("3")) newBrand = "AMERICAN EXPRESS";
    }

    setFormData((prev) => ({
      ...prev,
      [name]: value,
      brand: newBrand,
    }));
  };

  const handleSubmit = (e) => {
    e.preventDefault();

    onSuccess(formData);

    setFormData(initialState);
  };

  return (
    <div className="fixed inset-0 z-100 flex items-center justify-center bg-black/80 backdrop-blur-sm p-4">
      <div className="bg-neutral-100 w-full max-w-md rounded-[2.5rem] overflow-hidden shadow-2xl animate-in zoom-in-95 duration-300">
        <div className="bg-neutral-950 p-6 text-white flex justify-between items-center">
          <div className="flex flex-col">
            <h3 className="text-xl font-black uppercase italic tracking-tighter">
              Nueva Tarjeta
            </h3>
            <span className="text-[10px] text-primary-400 font-bold tracking-[0.2em] uppercase">
              {formData.brand}
            </span>
          </div>
          <button
            onClick={onClose}
            className="hover:text-primary-400 transition-colors cursor-pointer"
          >
            <X size={24} />
          </button>
        </div>

        <form onSubmit={handleSubmit} className="p-8 space-y-6">
          <div className="flex flex-col gap-1">
            <label className="text-[10px] uppercase font-black text-neutral-400 tracking-widest">
              Número de Tarjeta
            </label>
            <div className="relative">
              <input
                type="text"
                name="card_number"
                value={formData.card_number}
                placeholder="4000 0000 0000 0000"
                className="w-full text-lg font-bold border-b border-neutral-300 pb-2 bg-transparent outline-none focus:border-primary-400 transition-colors text-neutral-900"
                onChange={handleChange}
                maxLength="16"
                required
              />
              <CreditCard
                className="absolute right-0 top-1 text-neutral-300"
                size={20}
              />
            </div>
          </div>

          <div className="grid grid-cols-2 gap-8">
            <div className="flex flex-col gap-1">
              <label className="text-[10px] uppercase font-black text-neutral-400 tracking-widest">
                Expiración
              </label>
              <input
                type="date"
                name="expiration_date"
                value={formData.expiration_date}
                className="text-lg font-bold border-b border-neutral-300 pb-2 bg-transparent outline-none focus:border-primary-400 transition-colors text-neutral-900"
                onChange={handleChange}
                required
              />
            </div>
            <div className="flex flex-col gap-1">
              <label className="text-[10px] uppercase font-black text-neutral-400 tracking-widest">
                CVV
              </label>
              <input
                type="text"
                name="cvv"
                value={formData.cvv}
                placeholder="123"
                className="text-lg font-bold border-b border-neutral-300 pb-2 bg-transparent outline-none focus:border-primary-400 transition-colors text-neutral-900"
                onChange={handleChange}
                maxLength="4"
                required
              />
            </div>
          </div>

          <div className="flex items-center gap-2 text-neutral-400">
            <Lock size={12} />
            <span className="text-[9px] uppercase font-bold tracking-tighter">
              Pago seguro encriptado
            </span>
          </div>

          <button
            type="submit"
            className="w-full bg-neutral-950 text-white py-4 rounded-2xl font-black uppercase tracking-widest hover:bg-primary-500 hover:text-neutral-950 transition-all duration-300 cursor-pointer"
          >
            Guardar Tarjeta
          </button>
        </form>
      </div>
    </div>
  );
};

export default AddCreditCardModal;
