import 'package:ecommerce_frontend/data/model/product_model.dart';

class CartItemModel {
  final String id;
  final Product productItem;
  final int quantity;
  final String? selectedSize;
  final String? selectedColor;
  final String selectedImage;
  final double subtotal;

  const CartItemModel({
    required this.id,
    required this.productItem,
    this.quantity = 1,
    this.selectedSize,
    this.selectedColor,
    this.selectedImage = '',
    this.subtotal = 0,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    final productJson = json['productItem'];

    return CartItemModel(
      id: json['_id']?.toString() ?? '',
      productItem: productJson is Map
          ? Product.fromJson(Map<String, dynamic>.from(productJson))
          : Product.fromJson({}),
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      selectedSize: json['selectedSize']?.toString(),
      selectedColor: json['selectedColor']?.toString(),
      selectedImage: json['selectedImage']?.toString() ?? '',
      subtotal: (json['subtotal'] as num?)?.toDouble() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'productItem': productItem.toJson(),
      'quantity': quantity,
      'selectedSize': selectedSize,
      'selectedColor': selectedColor,
      'selectedImage': selectedImage,
      'subtotal': subtotal,
    };
  }

  CartItemModel copyWith({
    String? id,
    Product? productItem,
    int? quantity,
    String? selectedSize,
    String? selectedColor,
    String? selectedImage,
    double? subtotal,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      productItem: productItem ?? this.productItem,
      quantity: quantity ?? this.quantity,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedImage: selectedImage ?? this.selectedImage,
      subtotal: subtotal ?? this.subtotal,
    );
  }

  // ---------- derived values (used by cart AND checkout) ----------

  // Variation that matches the chosen color + size (null if none)
  ProductVariation? get variation =>
      productItem.findVariation(color: selectedColor, size: selectedSize);

  // Price per unit: variation price, sale price if on sale
  double get unitPrice {
    final v = variation;
    final price = v?.price ?? productItem.price;
    final sale = v?.salePrice ?? productItem.salePrice;
    return (sale > 0 && sale < price) ? sale : price;
  }

  double get lineTotal => unitPrice * quantity;

  // Stock limit for this line (null = unknown)
  int? get availableStock => variation?.stock;

  // One place decides which image is shown
  String get displayImage {
    if (selectedImage.isNotEmpty) return selectedImage;
    final v = variation;
    if (v != null && v.image.isNotEmpty) return v.image;
    return productItem.cardImage;
  }
}
