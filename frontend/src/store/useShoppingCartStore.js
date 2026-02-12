import { create } from "zustand";
import { persist } from "zustand/middleware";
import {
  addItemToCart,
  getCart,
  updateItemCart,
} from "../services/shoppingCartService";

let debounceTimer = null;

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

      updateItem: async (item_id, newQuantity) => {
        const currentItems = get().items.map((item) => {
          if (item.id === item_id) {
            return {
              ...item,
              quantity: newQuantity,
              subtotal: (item.vinyl.price * newQuantity).toFixed(2),
            };
          }
          return item;
        });

        set({ items: currentItems });

        if (debounceTimer) clearTimeout(debounceTimer);

        debounceTimer = setTimeout(async () => {
          try {
            const res = await updateItemCart(item_id, newQuantity);
            if (res.success) {
              await get().fetchCart();
            }
          } catch (error) {
            console.error("Error sincronizando con servidor:", error);
            await get().fetchCart();
          }
        }, 500);
      },
    }),
    {
      name: "shopping-cart-storage",
    },
  ),
);
