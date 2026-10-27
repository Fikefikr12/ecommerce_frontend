import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_frontend/data/model/address.dart';
import 'package:ecommerce_frontend/data/model/banner.dart';
import 'package:ecommerce_frontend/data/model/brand.dart';
import 'package:ecommerce_frontend/data/model/cart.dart';
import 'package:ecommerce_frontend/data/model/category.dart';
import 'package:ecommerce_frontend/data/model/product_model.dart';
import 'package:ecommerce_frontend/data/model/review.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ProductService {
  static String get baseUrl {
    // return 'https://ecommerce-backend-4lg4.onrender.com/api';

    if (kIsWeb) {
      return 'http://localhost:3000/api';
    }

    /// Android Emulator
    if (Platform.isAndroid) {
      return 'http://192.168.0.117:3000/api';
    }

    /// iOS Simulator
    if (Platform.isIOS) {
      return 'http://localhost:3000/api';
    }

    /// Physical Device
    return 'http://192.168.0.117:3000/api';
  }

  Future<Product> createProduct(Product product, XFile? imageFile) async {
    try {
      final request = http.MultipartRequest(
        'POST',

        Uri.parse('$baseUrl/products'),
      );

      /// TEXT FIELDS
      request.fields['name'] = product.name;
      request.fields['title'] = product.title;
      request.fields['category'] = product.category;
      request.fields['description'] = product.description;
      request.fields['brand'] = product.brand;
      request.fields['thumbnail'] = product.thumbnail;
      request.fields['sku'] = product.sku;

      request.fields['price'] = product.price.toString();
      request.fields['salePrice'] = product.salePrice.toString();
      request.fields['stock'] = product.stock.toString();

      request.fields['isFeatured'] = product.isFeatured.toString();

      /// Attributes
      request.fields['productAttributes'] = jsonEncode(
        product.productAttributes.map((e) => e.toJson()).toList(),
      );

      /// Variations
      request.fields['productVariations'] = jsonEncode(
        product.productVariations.map((e) => e.toJson()).toList(),
      );

      /// IMAGE FILE
      if (imageFile != null) {
        final bytes = await imageFile.readAsBytes();

        final imageMultipart = http.MultipartFile.fromBytes(
          'images',

          bytes,

          filename: imageFile.name,

          contentType: http.MediaType('image', 'jpeg'),
        );

        request.files.add(imageMultipart);
      }

      print("SENDING REQUEST");

      /// SEND REQUEST
      final response = await request.send();
      print("STATUS CODE: ${response.statusCode}");

      /// CONVERT RESPONSE
      final responseData = await response.stream.bytesToString();

      print("RESPONSE:");
      print(responseData);

      final data = jsonDecode(responseData);

      if (response.statusCode == 201) {
        return Product.fromJson(data['data']);
      } else {
        throw Exception(data['message'] ?? 'Failed to create product');
      }
    } catch (e) {
      print(e);

      throw Exception(e.toString());
    }
  }

  Future<Product> updateProduct(
    String id,
    Product product,
    XFile? imageFile,
  ) async {
    try {
      final request = http.MultipartRequest(
        'PUT',
        Uri.parse('$baseUrl/products/$id'),
      );

      /// Basic Fields
      request.fields['name'] = product.name;
      request.fields['title'] = product.title;
      request.fields['category'] = product.category;
      request.fields['description'] = product.description;
      request.fields['brand'] = product.brand;
      request.fields['thumbnail'] = product.thumbnail;
      request.fields['sku'] = product.sku;

      request.fields['price'] = product.price.toString();
      request.fields['salePrice'] = product.salePrice.toString();
      request.fields['stock'] = product.stock.toString();

      request.fields['isFeatured'] = product.isFeatured.toString();

      /// Attributes
      request.fields['productAttributes'] = jsonEncode(
        product.productAttributes.map((e) => e.toJson()).toList(),
      );

      /// Variations
      request.fields['productVariations'] = jsonEncode(
        product.productVariations.map((e) => e.toJson()).toList(),
      );
      if (imageFile != null) {
        final bytes = await imageFile.readAsBytes();

        final imagePartFile = await http.MultipartFile.fromBytes(
          'images',
          bytes,
          filename: imageFile.name,
          contentType: http.MediaType('image', 'jpeg'),
        );
        request.files.add(imagePartFile);
      }
      final response = await request.send();

      final responseData = await response.stream.bytesToString();

      final data = jsonDecode(responseData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Product.fromJson(data['data']);
      } else {
        throw Exception(data['message'] ?? 'Failed to update product');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Get All Products
  Future<List<Product>> getAllProducts({int? limit}) async {
    try {
      String url = '$baseUrl/products';

      if (limit != null) {
        url += '?limit=$limit';
      }

      print('API URL => $url');

      final response = await http.get(Uri.parse(url));

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return (data['data'] as List).map((e) => Product.fromJson(e)).toList();
      } else {
        throw Exception(
          data['message'] ?? // data['message'] is empty...
              'Failed to fetch products',
        );
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Product> getSingleProduct(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products/$id'));
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return Product.fromJson(data['data']);
      } else {
        throw Exception(data['message'] ?? 'failed to load to product');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Product> updateProductll(String id, Product product) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/products/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(product.toJson()),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Product.fromJson(data['data']);
      } else {
        throw Exception(data['message'] ?? ' Failed to create Product');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> deleteProduct(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/products/$id'));

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return data['message'];
      } else {
        throw Exception(data['message'] ?? 'Failed to delete product');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Product>> searchProduct(String key) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products/search?key=$key'),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final List products = data['data'];

        return products.map((e) => Product.fromJson(e)).toList();
      } else {
        throw Exception(data['message'] ?? 'failed to search product');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<CategoryModel> createCategory(
    CategoryModel category,
    XFile? imageFile,
  ) async {
    try {
      final request = await http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/category'),
      );

      request.fields['name'] = category.name;
      request.fields['description'] = category.description ?? '';
      request.fields['isActive'] = category.isActive.toString();

      if (imageFile != null) {
        final bytes = await imageFile.readAsBytes();

        final imageMultipart = http.MultipartFile.fromBytes(
          "images",
          bytes,
          filename: imageFile.name,
          contentType: http.MediaType('image', 'jpeg'),
        );

        request.files.add(imageMultipart);
      }

      final response = await request.send();

      final responseData = await response.stream.bytesToString();

      final data = jsonDecode(responseData);

      if (response.statusCode == 201) {
        return CategoryModel.fromJson(data['data']);
      } else {
        throw Exception(data['message'] ?? 'Failed to create product');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/category'),
        headers: {"Content-Type": "application/json"},
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return List<CategoryModel>.from(
          data['data'].map((e) => CategoryModel.fromJson(e)),
        );
      } else {
        throw Exception(data['message'] ?? 'Failed to load categories');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<CategoryModel> getSingleCategory(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/category/$id'),
        headers: {"Content-Type": "application/json"},
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return CategoryModel.fromJson(data['data']);
      } else {
        throw Exception(data['message'] ?? 'Failed to load category');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<CategoryModel> updateCategory(
    CategoryModel category,
    String id,
  ) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/category/$id'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": category.name,
          "image": category.image,
          "description": category.description,
          "isActive": category.isActive,
        }),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return CategoryModel.fromJson(data['data']);
      } else {
        throw Exception(data['message'] ?? 'Failed to update category');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> deleteCategory(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/category/$id'),
        headers: {"Content-Type": "application/json"},
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return true;
      } else {
        throw Exception(data['message'] ?? 'Failed to delete category');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // banner
  Future<BannerModel> createBanner({
    required bool isActive,
    required String targetScreen,
    required XFile image,
  }) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/banners'),
      );

      request.fields['isActive'] = isActive.toString();
      request.fields['targetScreen'] = targetScreen;

      request.files.add(await http.MultipartFile.fromPath('image', image.path));

      final streamedResponse = await request.send();

      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);

        return BannerModel.fromJson(jsonData['data']);
      }

      throw Exception(jsonDecode(response.body)['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// GET ALL BANNERS
  Future<List<BannerModel>> getAllBanners() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/banners'));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        return (jsonData['data'] as List)
            .map((banner) => BannerModel.fromJson(banner))
            .toList();
      }

      throw Exception('Failed to load banners');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// GET ACTIVE BANNERS
  Future<List<BannerModel>> getActiveBanners() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/banners/active'));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        return (jsonData['data'] as List)
            .map((banner) => BannerModel.fromJson(banner))
            .toList();
      }

      throw Exception('Failed to load active banners');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// GET SINGLE BANNER
  Future<BannerModel> getBanner(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/banners/$id'));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        return BannerModel.fromJson(jsonData['data']);
      }

      throw Exception('Banner not found');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// UPDATE BANNER
  Future<BannerModel> updateBanner({
    required String id,
    bool? isActive,
    String? targetScreen,
    XFile? image,
  }) async {
    try {
      final request = http.MultipartRequest(
        'PUT',
        Uri.parse('$baseUrl/banners/$id'),
      );

      if (isActive != null) {
        request.fields['isActive'] = isActive.toString();
      }

      if (targetScreen != null) {
        request.fields['targetScreen'] = targetScreen;
      }

      if (image != null) {
        request.files.add(
          await http.MultipartFile.fromPath('image', image.path),
        );
      }

      final streamedResponse = await request.send();

      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        return BannerModel.fromJson(jsonData['data']);
      }

      throw Exception(jsonDecode(response.body)['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// DELETE BANNER
  Future<void> deleteBanner(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/banners/$id'));

      if (response.statusCode != 200) {
        throw Exception('Failed to delete banner');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // review

  Future<ReviewModel> createReview({
    required String token,
    required String productId,
    required double rating,
    required String comment,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/reviews'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'productId': productId,
          'rating': rating,
          'comment': comment,
        }),
      );

      final jsonData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return ReviewModel.fromJson(jsonData['data']);
      }
      throw Exception(jsonData['message'] ?? ' faild to create review');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// GET PRODUCT REVIEWS
  Future<List<ReviewModel>> getProductReviews(String productId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/reviews/product/$productId'),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return (data['data'] as List)
            .map((e) => ReviewModel.fromJson(e))
            .toList();
      }

      throw Exception(data['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// GET SINGLE REVIEW
  Future<ReviewModel> getSingleReview(String reviewId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/reviews/$reviewId'));

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ReviewModel.fromJson(data['data']);
      }

      throw Exception(data['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// UPDATE REVIEW
  Future<ReviewModel> updateReview({
    required String token,
    required String reviewId,
    double? rating,
    String? comment,
  }) async {
    try {
      final Map<String, dynamic> body = {};

      if (rating != null) body['rating'] = rating;
      if (comment != null) body['comment'] = comment;

      final response = await http.put(
        Uri.parse('$baseUrl/reviews/$reviewId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );

      final jsonData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ReviewModel.fromJson(jsonData['data']);
      }

      throw Exception(jsonData['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// DELETE REVIEW
  Future<void> deleteReview({
    required String token,
    required String reviewId,
  }) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/reviews/$reviewId'),
        headers: {'Authorization': 'Bearer $token'},
      );

      final jsonData = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw Exception(jsonData['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// GET AVERAGE RATING
  Future<Map<String, dynamic>> getAverageRating(String productId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/reviews/product/$productId/rating'),
      );

      final jsonData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'averageRating': double.parse(jsonData['averageRating'].toString()),
          'totalReviews': jsonData['totalReviews'],
        };
      }

      throw Exception(jsonData['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // brands

  /// CREATE BRAND
  Future<BrandModel> createBrand({
    required String name,
    required bool isFeatured,
    XFile? image,
  }) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/brands'),
      );

      request.fields['name'] = name;
      request.fields['isFeatured'] = isFeatured.toString();

      if (image != null) {
        request.files.add(
          await http.MultipartFile.fromPath('image', image.path),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      final jsonData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return BrandModel.fromJson(jsonData['data']);
      }

      throw Exception(jsonData['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// GET ALL BRANDS
  Future<List<BrandModel>> getAllBrands() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/brands'));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        return (jsonData['data'] as List)
            .map((brand) => BrandModel.fromJson(brand))
            .toList();
      }

      throw Exception('Failed to load brands');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// GET FEATURED BRANDS
  Future<List<BrandModel>> getFeaturedBrands() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/brands/featured'));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        return (jsonData['data'] as List)
            .map((brand) => BrandModel.fromJson(brand))
            .toList();
      }

      throw Exception('Failed to load featured brands');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// GET SINGLE BRAND
  Future<BrandModel> getSingleBrand(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/brands/$id'));

      final jsonData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return BrandModel.fromJson(jsonData['data']);
      }

      throw Exception(jsonData['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// UPDATE BRAND
  Future<BrandModel> updateBrand({
    required String id,
    String? name,
    bool? isFeatured,
    XFile? image,
  }) async {
    try {
      final request = http.MultipartRequest(
        'PUT',
        Uri.parse('$baseUrl/brands/$id'),
      );

      if (name != null) {
        request.fields['name'] = name;
      }

      if (isFeatured != null) {
        request.fields['isFeatured'] = isFeatured.toString();
      }

      if (image != null) {
        request.files.add(
          await http.MultipartFile.fromPath('image', image.path),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      final jsonData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return BrandModel.fromJson(jsonData['data']);
      }

      throw Exception(jsonData['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// DELETE BRAND
  Future<void> deleteBrand(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/brands/$id'));

      if (response.statusCode != 200) {
        final jsonData = jsonDecode(response.body);
        throw Exception(jsonData['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // wish list
  Future<void> addWishlist(String token, String productId) async {
    final response = await http.post(
      Uri.parse("$baseUrl/wishlist"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"productId": productId}),
    );

    if (response.statusCode != 200) {
      final data = jsonDecode(response.body);
      throw Exception(data["message"]);
    }
  }

  Future<void> removeWishlist(String token, String productId) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/wishlist/product/$productId"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode != 200) {
      final data = jsonDecode(response.body);
      throw Exception(data["message"]);
    }
  }

  Future<List<Product>> getWishlist(String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/wishlist"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      return (json["data"] as List).map((e) => Product.fromJson(e)).toList();
    }

    throw Exception("Failed");
  }

  // address
  Future<AddressModel> createAddress({
    required String token,
    required AddressModel address,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/addresses'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'name': address.name,
          'phoneNumber': address.phoneNumber,
          'street': address.street,
          'city': address.city,
          'SubCity': address.subCity,
          'postalCode': address.postalCode,
          'country': address.country,
          'latitude': address.latitude,
          'longitude': address.longitude,
        }),
      );
      final jsonData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return AddressModel.fromJson(jsonData['data']);
      }
      throw Exception(jsonData['message'] ?? 'Failed to create address');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<AddressModel>> getAllAddressAdimin(String token) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/addresses/admin/all"),
        headers: {"Authorization": "Bearer $token"},
      );
      final jsonData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return (jsonData['data'] as List)
            .map((address) => AddressModel.fromJson(address))
            .toList();
      }
      throw Exception(jsonData['message'] ?? 'Failed to load addresses');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // cart
  Future<Cart> addToCart({
    required String token,
    required String productItem,
    required int quantity,
    String? selectedSize,
    String? selectedColor,
    String? selectedImage,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/cart'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'productItem': productItem,
          'quantity': quantity,
          'selectedSize': selectedSize,
          'selectedColor': selectedColor,
          'selectedImage': selectedImage,
        }),
      );

      final jsonData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return Cart.fromJson(jsonData['data']);
      }

      throw Exception(jsonData['message'] ?? 'Failed to add product to cart');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Get Current user cart
  Future<Cart> getCart({required String token}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/cart'),
        headers: {'Authorization': 'Bearer $token'},
      );

      final jsonData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return Cart.fromJson(jsonData['data']);
      }
      throw Exception(jsonData['message'] ?? 'Failed to load cart');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// UPDATE CART ITEM QUANTITY
  Future<Cart> updateCartQuantity({
    required String token,
    required String itemId,
    required int quantity,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/cart/$itemId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'quantity': quantity}),
      );

      final jsonData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return Cart.fromJson(jsonData['data']);
      }

      throw Exception(jsonData['message'] ?? 'Failed to update cart quantity');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // remove single item
  Future<Cart> removeCartItem({
    required String token,
    required String itemId,
  }) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/cart/$itemId'),
        headers: {'Authorization': 'Bearer $token'},
      );

      final jsonData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return Cart.fromJson(jsonData['data']);
      }
      throw Exception(jsonData['message'] ?? 'Failed to remove cart item');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// CLEAR ENTIRE CART
  Future<void> clearCart({required String token}) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/cart'),
        headers: {'Authorization': 'Bearer $token'},
      );

      final jsonData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return;
      }

      throw Exception(jsonData['message'] ?? 'Failed to clear cart');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // ========== ORDERS ==========
  Future<Map<String, dynamic>> createOrder({
    required String token,
    required Map<String, dynamic> shippingAddress,
    String paymentMethod = 'chapa',
    double deliveryFee = 0,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/orders'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'shippingAddress': shippingAddress,
          'paymentMethod': paymentMethod,
          'deliveryFee': deliveryFee,
        }),
      );

      final jsonData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return jsonData['data'];
      }

      throw Exception(jsonData['message'] ?? 'Failed to create order');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<dynamic>> getUserOrders({required String token}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/orders/my-orders'),
        headers: {'Authorization': 'Bearer $token'},
      );

      final jsonData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return jsonData['data'] as List;
      }

      throw Exception(jsonData['message'] ?? 'Failed to load orders');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
