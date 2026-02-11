import { create } from "zustand";
import { persist } from "zustand/middleware";
import { addItemToCart, getCart } from "../services/shoppingCartService";

export const useShoppingCartStore = create(
  persist(
    (set, get) => ({
      items: [],
      total: "0.00",
      cart_id: null,

      fetchCart: async () => {
        try {
          const res = await getCart();
          if (res.success) {
            set({
              items: res.data.items,
              total: res.data.total,
              cart_id: res.data.cart_id,
            });
          }
        } catch (error) {
          console.error("Error al poblar la store:", error);
        }
      },

      addItem: async (vinyl_id) => {
        try {
          const res = await addItemToCart(vinyl_id);
          if (res.success) {
            await get().fetchCart();
            return res;
          }
        } catch (error) {
          console.error("Error al añadir el vinilo en el carrito:", error);
          throw error;
        }
      },
    }),
    {
      name: "shopping-cart-storage",
    },
  ),
);
