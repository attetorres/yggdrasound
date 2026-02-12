import toast from "react-hot-toast";

const baseStyle = {
  background: "#24181c",
  color: "#e5e1d8",
  border: "1px solid #414143",
  fontSize: "12px",
  fontWeight: "700",
  textTransform: "uppercase",
  letterSpacing: "0.1em",
  borderRadius: "10px",
  padding: "12px 16px",
  boxShadow: "0 10px 15px -3px rgba(0, 0, 0, 0.4)",
};

export const showToast = {
  success: (message) =>
    toast.success(message, {
      style: { ...baseStyle, border: "1px solid #7d4c5a" },
      iconTheme: {
        primary: "#9a7b84",
        secondary: "#24181c",
      },
    }),

  error: (message) =>
    toast.error(message || "Ocurrió un error inesperado", {
      style: { ...baseStyle, border: "1px solid #b91c1c" },
      iconTheme: {
        primary: "#b91c1c",
        secondary: "#f2efea",
      },
    }),

  warning: (message) =>
    toast(message, {
      style: { ...baseStyle, border: "1px solid #d97706" },
    }),

  info: (message) =>
    toast(message, {
      style: { ...baseStyle, border: "1px solid #806d71" },
    }),

  cart: (album) =>
    toast.success(`¡${album} añadido al carrito!`, {
      duration: 3000,
      style: {
        ...baseStyle,
        background: "#7d4c5a",
        color: "#f2efea",
        border: "1px solid #e5e1d8",
      },
      iconTheme: {
        primary: "#f2efea",
        secondary: "#7d4c5a",
      },
    }),

  loading: (message) =>
    toast.loading(message, {
      style: baseStyle,
    }),
};
