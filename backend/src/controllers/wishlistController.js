import WishList from "../models/WishList.js";
import WishItem from "../models/WishItem.js";
import Vinyl from "../models/Vinyl.js";

// MÉTODOS GET
export const getWishlistByUserId = async (req, res) => {
  try {
    const wishList = await WishList.findOne({
      where: { user_id: req.params.user_id },
    });

    if (!wishList) {
      return res.json({
        success: true,
        data: [],
      });
    }

    const wishItems = await WishItem.findAll({
      where: { wish_list_id: wishList.id },
    });

    if (wishItems.length === 0) {
      return res.json({
        success: true,
        data: [],
      });
    }

    const vinylIds = wishItems.map((item) => item.vinyl_id);
    const vinyls = await Vinyl.findAll({
      where: { id: vinylIds },
      attributes: ["id", "artist", "album", "price", "album_cover"],
    });

    const items = wishItems
      .map((item) => {
        const vinyl = vinyls.find((v) => v.id === item.vinyl_id);
        return vinyl
          ? {
              wish_item_id: item.id,
              vinyl: vinyl,
              added_at: item.created_at,
            }
          : null;
      })
      .filter(Boolean);

    res.json({
      success: true,
      data: {
        wish_list_id: wishList.id,
        user_id: wishList.user_id,
        items: items,
        count: items.length,
      },
    });
  } catch (error) {
    console.error("Error:", error);
    res.status(500).json({
      success: false,
      message: "Error",
    });
  }
};

export const checkVinylInWishList = async (req, res) => {
  try {
    const { vinyl_id } = req.params;
    const user_id = req.user.id;

    const wishList = await WishList.findOne({ where: { user_id } });

    if (!wishList) {
      return res.json({
        success: true,
        in_wishlist: false,
      });
    }

    const wishItem = await WishItem.findOne({
      where: { wish_list_id: wishList.id, vinyl_id },
    });

    res.json({
      success: true,
      in_wishlist: !!wishItem,
      wish_item_id: wishItem?.id,
    });
  } catch (error) {
    console.error("Error:", error);
    res.status(500).json({
      success: false,
      message: "Error",
    });
  }
};

export const addToWishList = async (req, res) => {
  try {
    const { vinyl_id } = req.body;
    const user_id = req.user.id;

    const vinyl = await Vinyl.findByPk(vinyl_id, {
      attributes: ["id", "artist", "album", "album_cover", "price"],
    });

    if (!vinyl) {
      return res
        .status(404)
        .json({ success: false, message: "El vinilo no existe" });
    }

    let [wishList] = await WishList.findOrCreate({ where: { user_id } });

    const existingItem = await WishItem.findOne({
      where: { wish_list_id: wishList.id, vinyl_id },
    });

    if (existingItem) {
      return res.status(409).json({
        success: false,
        message: "Este vinilo ya está en tu wish list",
        data: { wish_item_id: existingItem.id, already_exists: true },
      });
    }

    const wishItem = await WishItem.create({
      wish_list_id: wishList.id,
      vinyl_id,
    });

    res.status(201).json({
      success: true,
      message: "Añadido a wish list",
      data: {
        wish_item_id: wishItem.id,
        vinyl: vinyl,
      },
    });
  } catch (error) {
    console.error("Error:", error);
    res.status(500).json({ success: false, message: "Error interno" });
  }
};

// MÉTODOS DELETE
export const deleteFromWishList = async (req, res) => {
  try {
    const wishItem = await WishItem.findByPk(req.params.wish_item_id);

    if (!wishItem) {
      return res.status(404).json({
        success: false,
        message: "Item no encontrado",
      });
    }

    await wishItem.destroy();

    res.json({
      success: true,
      message: "Eliminado de wish list",
    });
  } catch (error) {
    console.error("Error:", error);
    res.status(500).json({
      success: false,
      message: "Error",
    });
  }
};

export const clearWishList = async (req, res) => {
  try {
    const wishList = await WishList.findOne({
      where: { user_id: req.params.user_id },
    });

    if (!wishList) {
      return res.json({
        success: true,
        message: "No hay wish list",
      });
    }

    await WishItem.destroy({ where: { wish_list_id: wishList.id } });

    res.json({
      success: true,
      message: "Wish list vaciada",
    });
  } catch (error) {
    console.error("Error:", error);
    res.status(500).json({
      success: false,
      message: "Error",
    });
  }
};
