class Network {
  static final String BASE_URLs = "https://cliqbazar.com/Api/v1/";
  static final String AUTH_KEY = "4cae3ac458f4dfa3c9e1f6bb11eab33";

  //images url
  static final String profileImagesUrl =
      "https://cliqbazar.com/users/profile_images/";
  static final String imageBanner = BASE_URLs + "banner.php";
  static final String Product_Images =
      "https://cliqbazar.com/admin/product_images/";
  static final String Profile_Images =
      "https://cliqbazar.com/users/profile_images/";
  static final String Profile_Images_vendor =
      "https://cliqbazar.com/vendor/logos/";

  //auth url
  static final String LOGIN_URL = BASE_URLs + "login.php?";
  static final String SIGN_UP = BASE_URLs + "register.php?";
  static final String forgetPasswordAPI = BASE_URLs + "forgot-password.php";
  static final String resetPasswordAPI =
      BASE_URLs + "forgot-password-sec-level.php";

  //profile url
  static final String updateProfileUrl = BASE_URLs + "useredit-profile.php";
  static final String getUserProfile = BASE_URLs + "userget-profile.php";

  //cart url
  static final String getCartList = BASE_URLs + "cartlist.php";
  static final String updateQuantity = BASE_URLs + "updateqty.php";
  static final String deleteFromCart = BASE_URLs + "removeCart.php";
  static final String clearCart = BASE_URLs + "clearaddtoCart.php";
  static final String addToCart = BASE_URLs + "addtoCart.php";
  static final String placeOrderApi = BASE_URLs + "orders.php";

  static final String getNotificationCount =
      BASE_URLs + "notificationcount.php";
  static final String getNotificationsList = BASE_URLs + "notification.php";

//orders
  static final String getUserOrders = BASE_URLs + "orderlist.php";
  static final String orderProductList = BASE_URLs + "orderProductlist.php";

  //products api
  static final String getProducts = BASE_URLs + "product.php?";
  static final String getAllProducts = BASE_URLs + "allproduct.php?";
  static final String getProductDetails = BASE_URLs + "productDetail.php?";

  // search Api
  static final String searchProduct = BASE_URLs + "search.php";

  //vendor
  static final String vendorProfile = BASE_URLs + "vendorget-profile.php";
  static final String getPromotedVendor = BASE_URLs + "prmotedVendors.php";
  static final String getAllVendors = BASE_URLs + "allvendor.php";
  static final String getProductByVendor = BASE_URLs + "vendorOnproduct.php";

  //offer button
  static final String offerAPI = BASE_URLs + "offer.php";

  //wallet
  static final String walletAPI = BASE_URLs + "wallet.php";

  // fav api
  static final String setFavouriteAPI = BASE_URLs + "favourite.php";
  static final String favouriteAPI = BASE_URLs + "fav-vendor.php";

//category
  static final String vendorByCategory = BASE_URLs + "category-vendor.php";
  static final String getCategory = BASE_URLs + "category.php";
}
