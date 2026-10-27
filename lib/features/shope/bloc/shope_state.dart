import 'package:ecommerce_frontend/data/model/cart_Item.dart';
import 'package:ecommerce_frontend/data/model/address.dart';
import 'package:ecommerce_frontend/data/model/banner.dart';
import 'package:ecommerce_frontend/data/model/brand.dart';
import 'package:ecommerce_frontend/data/model/cart.dart';
import 'package:ecommerce_frontend/data/model/category.dart';
import 'package:ecommerce_frontend/data/model/product_model.dart';
import 'package:ecommerce_frontend/data/model/user.dart';

class ShopeState {
  final bool isLoading;
  final List<Product> products;
  final Product? selectedProduct;
  final String? errorMessage;
  final List<User> users;
  final User? selectedUser;
  final User? currentUser;
  final List<CategoryModel> categories;
  final CategoryModel? selectedCategory;
  final List<BannerModel> banners;
  final BannerModel? selectedBanner;
  final List<BrandModel> brands;
  final BrandModel? selectedBrand;
  final List<Product> wishlist;
  final String? message;
  final List<AddressModel> addresses;
  final AddressModel? selectedAddress;
  final Cart? cart;
  final List<CartItemModel> cartItems;
  // Orders
  final List<dynamic> orders;
  final Map<String, dynamic>? selectedOrder;
  final Map<String, dynamic>? currentOrder;

  ShopeState({
    this.isLoading = false,
    this.products = const [],
    this.selectedProduct,
    this.errorMessage,
    this.users = const [],
    this.selectedUser,
    this.currentUser,
    this.categories = const [],
    this.selectedCategory,
    this.banners = const [],
    this.selectedBanner,
    this.brands = const [],
    this.selectedBrand,
    this.wishlist = const [],
    this.message,
    this.addresses = const [],
    this.selectedAddress,
    // Cart
    this.cart,
    this.cartItems = const [],
    this.orders = const [],
    this.selectedOrder,
    this.currentOrder,
  });

  ShopeState copyWith({
    bool? isLoading,
    List<Product>? products,
    Product? selectedProduct,
    String? errorMessage,
    List<User>? users,
    User? selectedUser,
    User? currentUser,
    List<CategoryModel>? categories,
    CategoryModel? selectedCategory,
    List<BannerModel>? banners,
    BannerModel? selectedBanner,
    List<BrandModel>? brands,
    BrandModel? selectedBrand,
    List<Product>? wishlist,
    String? message,
    List<AddressModel>? addresses,
    AddressModel? selectedAddress,
    Cart? cart,
    List<CartItemModel>? cartItems,
    List<dynamic>? orders,
    Map<String, dynamic>? selectedOrder,
    Map<String, dynamic>? currentOrder,
    // ADDED: `x ?? this.x` can never set a value to null, so these flags do it.
    bool clearCart = false,
    bool clearError = false,
  }) {
    return ShopeState(
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
      selectedProduct: selectedProduct ?? this.selectedProduct,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      users: users ?? this.users,
      selectedUser: selectedUser ?? this.selectedUser,
      currentUser: currentUser ?? this.currentUser,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      banners: banners ?? this.banners,
      selectedBanner: selectedBanner ?? this.selectedBanner,
      brands: brands ?? this.brands,
      selectedBrand: selectedBrand ?? this.selectedBrand,
      wishlist: wishlist ?? this.wishlist,
      message: message,
      addresses: addresses ?? this.addresses,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      cart: clearCart ? null : (cart ?? this.cart),
      cartItems: cartItems ?? this.cartItems,
      orders: orders ?? this.orders,
      selectedOrder: selectedOrder ?? this.selectedOrder,
      currentOrder: currentOrder ?? this.currentOrder,
    );
  }
}
