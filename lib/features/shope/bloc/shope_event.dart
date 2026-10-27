import 'dart:io';
import 'package:ecommerce_frontend/data/model/address.dart';
import 'package:ecommerce_frontend/data/model/banner.dart';
import 'package:ecommerce_frontend/data/model/brand.dart';
import 'package:ecommerce_frontend/data/model/category.dart';
import 'package:ecommerce_frontend/data/model/product_model.dart';
import 'package:ecommerce_frontend/data/model/user.dart';
import 'package:image_picker/image_picker.dart';

abstract class ShopeEvent {}

class GetAllProductsEvent extends ShopeEvent {
  final int? limit;
  GetAllProductsEvent({this.limit});
}

class GetSingleProductEvent extends ShopeEvent {
  final String id;
  GetSingleProductEvent({required this.id});
}

class CreateProductEvent extends ShopeEvent {
  final Product product;
  final XFile? image;
  CreateProductEvent({required this.product, this.image});
}

class UpdateProductEvent extends ShopeEvent {
  final String id;
  final Product product;
  final XFile? image;
  UpdateProductEvent({required this.id, required this.product, this.image});
}

class DeleteProductEvent extends ShopeEvent {
  final String id;
  DeleteProductEvent({required this.id});
}

class ClearAllProductsEvent extends ShopeEvent {}

class SearchProductEvent extends ShopeEvent {
  final String query;
  SearchProductEvent({required this.query});
}

class GetAllUsersEvent extends ShopeEvent {}

class GetSingleUserEvent extends ShopeEvent {
  final String id;

  GetSingleUserEvent({required this.id});
}

class GetCurrentUserEvent extends ShopeEvent {}

class CreateUserEvent extends ShopeEvent {
  final User user;
  final List<XFile>? imageFiles;
  CreateUserEvent({required this.user, this.imageFiles});
}

class UpdateUserEvent extends ShopeEvent {
  final User user;
  final String id;
  UpdateUserEvent({required this.user, required this.id});
}

class DeleteUserEvent extends ShopeEvent {
  final String id;
  DeleteUserEvent({required this.id});
}

class ChangeUserRoleEvent extends ShopeEvent {
  final String id;
  final String role;

  ChangeUserRoleEvent({required this.id, required this.role});
}

class CreateCategoryEvent extends ShopeEvent {
  final CategoryModel category;
  final XFile image;
  CreateCategoryEvent({required this.category, required this.image});
}

class GetAllCategoriesEvent extends ShopeEvent {}

class GetSingleCategoryEvent extends ShopeEvent {
  final String id;

  GetSingleCategoryEvent({required this.id});
}

class UpdateCategoryEvent extends ShopeEvent {
  final CategoryModel category;
  final String id;
  UpdateCategoryEvent({required this.category, required this.id});
}

class DeleteCategoryEvent extends ShopeEvent {
  final String id;
  DeleteCategoryEvent({required this.id});
}

// banner
class CreateBannerEvent extends ShopeEvent {
  final BannerModel banner;
  final XFile image;
  CreateBannerEvent({required this.banner, required this.image});
}

class GetAllBannersEvent extends ShopeEvent {}

class GetActiveBannerEvent extends ShopeEvent {}

class GetSingleBannerEvent extends ShopeEvent {
  final String id;

  GetSingleBannerEvent({required this.id});
}

class UpdateBannerEvent extends ShopeEvent {
  final BannerModel banner;
  final String id;
  final XFile? image;
  UpdateBannerEvent({required this.banner, required this.id, this.image});
}

class DeleteBannerEvent extends ShopeEvent {
  final String id;
  DeleteBannerEvent({required this.id});
}

// brands
class CreateBrandEvent extends ShopeEvent {
  final String name;
  final bool isFeatured;
  final XFile? image;
  CreateBrandEvent({required this.name, required this.isFeatured, this.image});
}

class GetAllBrandsEvent extends ShopeEvent {}

class GetFeaturedBrandsEvent extends ShopeEvent {}

class GetSingleBrandEvent extends ShopeEvent {
  final String id;

  GetSingleBrandEvent({required this.id});
}

class UpdateBrandEvent extends ShopeEvent {
  final String id;
  final String? name;
  final bool? isFeatured;
  final XFile? image;
  UpdateBrandEvent({required this.id, this.name, this.isFeatured, this.image});
}

class DeleteBrandEvent extends ShopeEvent {
  final String id;
  DeleteBrandEvent({required this.id});
}

class LoadWishlistEvent extends ShopeEvent {}

class AddWishlistEvent extends ShopeEvent {
  final String productId;

  AddWishlistEvent(this.productId);
}

class RemoveWishlistEvent extends ShopeEvent {
  final String productId;

  RemoveWishlistEvent(this.productId);
}
// address

class CreateAddressEvent extends ShopeEvent {
  final AddressModel address;

  CreateAddressEvent({required this.address});
}

class GetAllAddressAdmin extends ShopeEvent {}

class AddToCartEvent extends ShopeEvent {
  final String productItem;
  final int quantity;
  final String? selectedSize;
  final String? selectedColor;
  final String? selectedImage;

  AddToCartEvent({
    required this.productItem,
    this.quantity = 1,
    this.selectedSize,
    this.selectedColor,
    this.selectedImage,
  });
}

class GetCartEvent extends ShopeEvent {}

class UpdateCartQuantityEvent extends ShopeEvent {
  final String itemId;
  final int quantity;

  UpdateCartQuantityEvent({required this.itemId, required this.quantity});
}

class RemoveCartItemEvent extends ShopeEvent {
  final String itemId;

  RemoveCartItemEvent({required this.itemId});
}

class ClearCartEvent extends ShopeEvent {}

class CreateOrderEvent extends ShopeEvent {
  final Map<String, dynamic> shippingAddress;
  final String paymentMethod;
  final double deliveryFee;

  CreateOrderEvent({
    required this.shippingAddress,
    this.paymentMethod = 'chapa',
    this.deliveryFee = 0,
  });
}

class GetUserOrdersEvent extends ShopeEvent {}
