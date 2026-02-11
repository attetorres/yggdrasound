import { create } from "zustand";
import { persist } from "zustand/middleware";
import { addItemToCart } from "../services/shoppingCartService";

export const useShoppingCartStore = create(
  persist((set, get) => ({
    items: [],
    total: "0.00",
    cart_id: null,

    addItem: async (vinyl_id) => {
      try {
        const res = await addItemToCart(vinyl_id);
        if (res.success) {
          const newItem = res.data;
          set((state) => ({
            items: [...state.items, newItem],
          }));
          return res;
        }
      } catch (error) {
        console.error("Error al añadir el vinilo en el carrito:", error);
        throw error;
      }
    },
  })),
);
