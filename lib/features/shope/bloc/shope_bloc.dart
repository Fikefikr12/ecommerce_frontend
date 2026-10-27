import 'package:ecommerce_frontend/core/service/product_service.dart';
import 'package:ecommerce_frontend/core/service/user_service.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_state.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopeBloc extends Bloc<ShopeEvent, ShopeState> {
  final ProductService productService;
  final UserService userService;

  ShopeBloc(this.productService, this.userService) : super(ShopeState()) {
    on<CreateProductEvent>(_createProductEvent);
    on<GetAllProductsEvent>(_getAllProductsEvent);
    on<GetSingleProductEvent>(_getSingleProductEvent);
    on<SearchProductEvent>(_searchProductEvent);
    on<UpdateProductEvent>(_updateProductEvent);
    on<DeleteProductEvent>(_deleteProductEvent);
    on<ClearAllProductsEvent>(_clearAllProductsEvent);

    // User Events
    on<GetAllUsersEvent>(_getAllUsersEvent);
    on<GetSingleUserEvent>(_getSingleUserEvent);
    on<GetCurrentUserEvent>(_getCurrentUserEvent);
    on<CreateUserEvent>(_createUserEvent);
    on<UpdateUserEvent>(_updateUserEvent);
    on<DeleteUserEvent>(_deleteUserEvent);
    on<ChangeUserRoleEvent>(_changeUserRoleEvent);
    // category
    on<CreateCategoryEvent>(_createCategoryEvent);
    on<GetAllCategoriesEvent>(_getAllCategoriesEvent);
    on<GetSingleCategoryEvent>(_getSingleCategoryEvent);
    on<UpdateCategoryEvent>(_updateCategoryEvent);
    on<DeleteCategoryEvent>(_deleteCategoryEvent);
    // Banner
    on<CreateBannerEvent>(_createBannerEvent);
    on<GetAllBannersEvent>(_getAllBannersEvent);
    on<GetActiveBannerEvent>(_getActiveBannerEvent);
    on<GetSingleBannerEvent>(_getSingleBannerEvent);
    on<UpdateBannerEvent>(_updateBannerEvent);
    on<DeleteBannerEvent>(_deleteBannerEvent);

    // Brands
    on<CreateBrandEvent>(_createBrandEvent);
    on<GetAllBrandsEvent>(_getAllBrandsEvent);
    on<GetSingleBrandEvent>(_getSingleBrandEvent);
    on<GetFeaturedBrandsEvent>(_getFeaturedBrandsEvent);
    on<UpdateBrandEvent>(_updateBrandEvent);
    on<DeleteBrandEvent>(_deleteBrandEvent);

    // wishlist

    on<LoadWishlistEvent>(_loadWishlist);
    on<AddWishlistEvent>(_addWishlist);
    on<RemoveWishlistEvent>(_removeWishlist);

    /// address
    on<CreateAddressEvent>(_createAddressEvent);
    on<GetAllAddressAdmin>(_getAllAddressAdmin);

    // Cart
    on<AddToCartEvent>(_addToCart);
    on<GetCartEvent>(_getCart);
    on<UpdateCartQuantityEvent>(_updateCartQuantity);
    on<RemoveCartItemEvent>(_removeCartItem);
    on<ClearCartEvent>(_clearCart);

    // Orders
    on<CreateOrderEvent>(_createOrder);
    on<GetUserOrdersEvent>(_getUserOrders);
  }

  Future<void> _createProductEvent(
    CreateProductEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      await productService.createProduct(event.product, event.image);

      final newProducts = await productService.getAllProducts();

      emit(state.copyWith(products: newProducts, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _updateProductEvent(
    UpdateProductEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      await productService.updateProduct(event.id, event.product, event.image);

      final newProducts = await productService.getAllProducts();

      emit(state.copyWith(products: newProducts, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _getAllProductsEvent(
    GetAllProductsEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await productService.getAllProducts(limit: event.limit);

      emit(state.copyWith(products: result, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _getSingleProductEvent(
    GetSingleProductEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await productService.getSingleProduct(event.id);

      emit(state.copyWith(selectedProduct: result, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _searchProductEvent(
    SearchProductEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await productService.searchProduct(event.query);

      emit(state.copyWith(products: result, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _deleteProductEvent(
    DeleteProductEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      await productService.deleteProduct(event.id);

      final newProducts = await productService.getAllProducts();

      emit(state.copyWith(products: newProducts, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _clearAllProductsEvent(
    ClearAllProductsEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      for (final product in state.products) {
        await productService.deleteProduct(product.id);
      }

      emit(state.copyWith(isLoading: false, products: []));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _getAllUsersEvent(
    GetAllUsersEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      final allUsers = await userService.getAllUsers();

      emit(state.copyWith(users: allUsers, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _getCurrentUserEvent(
    GetCurrentUserEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      final user = await userService.getCurrentUser();

      print("DEBUG: User name = ${user.name}");

      emit(state.copyWith(currentUser: user, isLoading: false));
    } catch (e) {
      print("DEBUG ERROR in getCurrentUser: $e");
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _getSingleUserEvent(
    GetSingleUserEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final user = await userService.getSingleUser(event.id);

      emit(state.copyWith(selectedUser: user, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _createUserEvent(
    CreateUserEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      final user = await userService.createUser(event.user, event.imageFiles);

      emit(state.copyWith(currentUser: user, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _updateUserEvent(
    UpdateUserEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      final updatedUser = await userService.updateUser(event.id, event.user);

      emit(state.copyWith(currentUser: updatedUser, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _deleteUserEvent(
    DeleteUserEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      await userService.deleteUser(event.id);

      emit(state.copyWith(currentUser: null, users: [], isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _changeUserRoleEvent(
    ChangeUserRoleEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      await userService.changeUserRole(event.id, event.role);

      final users = await userService.getAllUsers();

      emit(state.copyWith(users: users, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _createCategoryEvent(
    CreateCategoryEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final category = await productService.createCategory(
        event.category,
        event.image,
      );
      emit(state.copyWith(selectedCategory: category, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _getAllCategoriesEvent(
    GetAllCategoriesEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      final allCategories = await productService.getAllCategories();

      emit(state.copyWith(categories: allCategories, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _getSingleCategoryEvent(
    GetSingleCategoryEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      final category = await productService.getSingleCategory(event.id);

      emit(state.copyWith(selectedCategory: category, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _updateCategoryEvent(
    UpdateCategoryEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      final category = await productService.updateCategory(
        event.category,
        event.id,
      );

      emit(state.copyWith(selectedCategory: category, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _deleteCategoryEvent(
    DeleteCategoryEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      await productService.deleteCategory(event.id);

      emit(state.copyWith(selectedCategory: null, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  // CREATE BANNER
  Future<void> _createBannerEvent(
    CreateBannerEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      final banner = await productService.createBanner(
        isActive: event.banner.isActive,
        targetScreen: event.banner.targetScreen ?? '',
        image: event.image,
      );

      emit(state.copyWith(selectedBanner: banner, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  // GET ALL BANNERS
  Future<void> _getAllBannersEvent(
    GetAllBannersEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      final banners = await productService.getAllBanners();

      emit(state.copyWith(banners: banners, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  // GET ACTIVE BANNERS
  Future<void> _getActiveBannerEvent(
    GetActiveBannerEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      final banners = await productService.getActiveBanners();

      emit(state.copyWith(banners: banners, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  // GET SINGLE BANNER
  Future<void> _getSingleBannerEvent(
    GetSingleBannerEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      final banner = await productService.getBanner(event.id);

      emit(state.copyWith(selectedBanner: banner, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  // UPDATE BANNER
  Future<void> _updateBannerEvent(
    UpdateBannerEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      final banner = await productService.updateBanner(
        id: event.id,
        isActive: event.banner.isActive,
        targetScreen: event.banner.targetScreen,
        image: event.image,
      );

      emit(state.copyWith(selectedBanner: banner, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  // DELETE BANNER
  Future<void> _deleteBannerEvent(
    DeleteBannerEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      await productService.deleteBanner(event.id);

      final updatedBanners = state.banners
          .where((banner) => banner.id != event.id)
          .toList();

      emit(state.copyWith(banners: updatedBanners, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  // brands
  // create brand

  Future<void> _createBrandEvent(
    CreateBrandEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      final brand = await productService.createBrand(
        name: event.name,
        isFeatured: event.isFeatured,
        image: event.image,
      );

      emit(state.copyWith(brands: [...state.brands, brand], isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  //get All Brands
  Future<void> _getAllBrandsEvent(
    GetAllBrandsEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      final allBrands = await productService.getAllBrands();
      emit(state.copyWith(brands: allBrands, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  // get single
  Future<void> _getSingleBrandEvent(
    GetSingleBrandEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      final brand = await productService.getSingleBrand(event.id);

      emit(state.copyWith(selectedBrand: brand, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  // feathered brands
  Future<void> _getFeaturedBrandsEvent(
    GetFeaturedBrandsEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      final featuredBrands = await productService.getFeaturedBrands();
      emit(state.copyWith(brands: featuredBrands, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _updateBrandEvent(
    UpdateBrandEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      final updated = await productService.updateBrand(
        id: event.id,
        name: event.name,
        isFeatured: event.isFeatured,
        image: event.image,
      );

      final brands = state.brands.map((brand) {
        if (brand.id == event.id) {
          return updated;
        }
        return brand;
      }).toList();

      emit(state.copyWith(brands: brands, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  // DELETE BANNER
  Future<void> _deleteBrandEvent(
    DeleteBrandEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      await productService.deleteBrand(event.id);

      final UpdatedBrand = state.brands
          .where((brand) => brand.id != event.id)
          .toList();

      emit(state.copyWith(brands: UpdatedBrand, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<String> _getUserToken() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User is not signed in');
    }

    final token = await user.getIdToken();
    if (token == null || token.isEmpty) {
      throw Exception('Unable to retrieve user token');
    }

    return token;
  }
  // wishlist

  Future<void> _loadWishlist(
    LoadWishlistEvent event,
    Emitter<ShopeState> emit,
  ) async {
    final token = await _getUserToken();

    final products = await productService.getWishlist(token);

    emit(state.copyWith(wishlist: products));
  }

  Future<void> _addWishlist(
    AddWishlistEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      final token = await _getUserToken();

      await productService.addWishlist(token, event.productId);

      final product = state.products.firstWhere((e) => e.id == event.productId);

      final updatedWishlist = [...state.wishlist, product];

      emit(
        state.copyWith(
          wishlist: updatedWishlist,
          message: "Product added to wishlist",
        ),
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> _removeWishlist(
    RemoveWishlistEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      final token = await _getUserToken();

      await productService.removeWishlist(token, event.productId);

      final updatedWishlist = state.wishlist
          .where((e) => e.id != event.productId)
          .toList();

      emit(
        state.copyWith(
          wishlist: updatedWishlist,
          message: "Product removed from wishlist",
        ),
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  //// address

  Future<void> _createAddressEvent(
    CreateAddressEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      final token = await _getUserToken();

      final address = await productService.createAddress(
        token: token,
        address: event.address,
      );

      final updateAddresses = [...state.addresses, address];

      emit(state.copyWith(isLoading: true, addresses: updateAddresses));
    } catch (e) {
      emit(state.copyWith(isLoading: true, errorMessage: e.toString()));
    }
  }

  Future<void> _getAllAddressAdmin(
    GetAllAddressAdmin event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final token = await _getUserToken();

      final addresses = await productService.getAllAddressAdimin(token);

      emit(state.copyWith(isLoading: false, addresses: addresses));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  /// cart
  Future<void> _addToCart(
    AddToCartEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      final token = await _getUserToken();

      final cart = await productService.addToCart(
        token: token,
        productItem: event.productItem,
        quantity: event.quantity,
        selectedSize: event.selectedSize,
        selectedColor: event.selectedColor,
        selectedImage: event.selectedImage,
      );

      emit(
        state.copyWith(
          isLoading: false,
          cart: cart,
          cartItems: cart.items,
          message: "Product added to cart",
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _getCart(GetCartEvent event, Emitter<ShopeState> emit) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      final token = await _getUserToken();

      final cart = await productService.getCart(token: token);

      emit(state.copyWith(isLoading: false, cart: cart, cartItems: cart.items));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _updateCartQuantity(
    UpdateCartQuantityEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      final token = await _getUserToken();

      final cart = await productService.updateCartQuantity(
        token: token,
        itemId: event.itemId,
        quantity: event.quantity,
      );

      emit(
        state.copyWith(
          isLoading: false,
          cart: cart,
          cartItems: cart.items,
          message: "Cart quantity updated",
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _removeCartItem(
    RemoveCartItemEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      final token = await _getUserToken();

      final cart = await productService.removeCartItem(
        token: token,
        itemId: event.itemId,
      );

      emit(
        state.copyWith(
          isLoading: false,
          cart: cart,
          cartItems: cart.items,
          message: "Item removed from cart",
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _clearCart(
    ClearCartEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      final token = await _getUserToken();

      await productService.clearCart(token: token);

      emit(
        state.copyWith(
          isLoading: false,
          clearCart: true,
          cartItems: [],
          message: "Cart cleared successfully",
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _createOrder(
    CreateOrderEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      final token = await _getUserToken();

      final order = await productService.createOrder(
        token: token,
        shippingAddress: event.shippingAddress,
        paymentMethod: event.paymentMethod,
        deliveryFee: event.deliveryFee,
      );

      emit(
        state.copyWith(
          isLoading: false,
          currentOrder: order,
          clearCart: true,
          cartItems: [],
          message: "Order created successfully",
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _getUserOrders(
    GetUserOrdersEvent event,
    Emitter<ShopeState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      final token = await _getUserToken();

      final orders = await productService.getUserOrders(token: token);

      emit(state.copyWith(isLoading: false, orders: orders));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
