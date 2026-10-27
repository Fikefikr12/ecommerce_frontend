int discountPercentOf(double price, double sale) =>
    (sale > 0 && sale < price && price > 0)
    ? (((price - sale) / price) * 100).round()
    : 0;

class ProductAttribute {
  final String name;
  final List<String> values;

  const ProductAttribute({required this.name, this.values = const []});

  factory ProductAttribute.fromJson(Map<String, dynamic> json) {
    return ProductAttribute(
      name: json['name'] ?? '',
      values: List<String>.from(json['values'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'values': values};
  }

  ProductAttribute copyWith({String? name, List<String>? values}) {
    return ProductAttribute(
      name: name ?? this.name,
      values: values ?? this.values,
    );
  }
}

class ProductVariation {
  final Map<String, String> attributeValues;

  final String image;

  final String sku;

  final double price;

  final double salePrice;

  final int stock;

  const ProductVariation({
    this.attributeValues = const {},
    this.image = '',
    this.sku = '',
    required this.price,
    this.salePrice = 0,
    this.stock = 0,
  });

  factory ProductVariation.fromJson(Map<String, dynamic> json) {
    return ProductVariation(
      attributeValues: Map<String, String>.from(json['attributeValues'] ?? {}),

      image: json['image'] ?? '',

      sku: json['sku'] ?? '',

      price: double.parse((json['price'] ?? 0.0).toString()),

      salePrice: (json['salePrice'] as num?)?.toDouble() ?? 0,

      stock: (json['stock'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attributeValues': attributeValues,
      'image': image,
      'sku': sku,
      'price': price,
      'salePrice': salePrice,
      'stock': stock,
    };
  }

  ProductVariation copyWith({
    Map<String, String>? attributeValues,
    String? image,
    String? sku,
    double? price,
    double? salePrice,
    int? stock,
  }) {
    return ProductVariation(
      attributeValues: attributeValues ?? this.attributeValues,
      image: image ?? this.image,
      sku: sku ?? this.sku,
      price: price ?? this.price,
      salePrice: salePrice ?? this.salePrice,
      stock: stock ?? this.stock,
    );
  }
}

class Product {
  final String id;

  final String name;

  final String title;

  final String category;

  final String description;

  final String brand;

  final String thumbnail;

  final String sku;

  final double price;

  final double salePrice;

  final int stock;

  final List<String> imageUrl;

  final bool isFeatured;

  final List<ProductAttribute> productAttributes;

  final List<ProductVariation> productVariations;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  const Product({
    required this.id,
    required this.name,
    required this.title,
    required this.category,
    this.description = '',
    this.brand = '',
    this.thumbnail = '',
    this.sku = '',
    required this.price,
    this.salePrice = 0,
    this.stock = 0,
    this.imageUrl = const [],
    this.isFeatured = false,
    this.productAttributes = const [],
    this.productVariations = const [],
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id']?.toString() ?? '',

      name: json['name'] ?? '',

      title: json['title'] ?? '',

      category: json['category'] ?? '',

      description: json['description'] ?? '',

      brand: json['brand'] ?? '',

      thumbnail: json['thumbnail'] ?? '',

      sku: json['sku'] ?? '',

      price: (json['price'] as num?)?.toDouble() ?? 0,

      salePrice: (json['salePrice'] as num?)?.toDouble() ?? 0,

      stock: json['stock'] ?? 0,

      imageUrl: List<String>.from(json['imageUrl'] ?? []),

      isFeatured: json['isFeatured'] ?? false,

      productAttributes: (json['productAttributes'] as List<dynamic>? ?? [])
          .map((e) => ProductAttribute.fromJson(e))
          .toList(),

      productVariations: (json['productVariations'] as List<dynamic>? ?? [])
          .map((e) => ProductVariation.fromJson(e))
          .toList(),

      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,

      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'title': title,
      'category': category,
      'description': description,
      'brand': brand,
      'thumbnail': thumbnail,
      'sku': sku,
      'price': price,
      'salePrice': salePrice,
      'stock': stock,
      'imageUrl': imageUrl,
      'isFeatured': isFeatured,
      'productAttributes': productAttributes.map((e) => e.toJson()).toList(),
      'productVariations': productVariations.map((e) => e.toJson()).toList(),
    };
  }

  Product copyWith({
    String? id,
    String? name,
    String? title,
    String? category,
    String? description,
    String? brand,
    String? thumbnail,
    String? sku,
    double? price,
    double? salePrice,
    int? stock,
    List<String>? imageUrl,
    bool? isFeatured,
    List<ProductAttribute>? productAttributes,
    List<ProductVariation>? productVariations,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      title: title ?? this.title,
      category: category ?? this.category,
      description: description ?? this.description,
      brand: brand ?? this.brand,
      thumbnail: thumbnail ?? this.thumbnail,
      sku: sku ?? this.sku,
      price: price ?? this.price,
      salePrice: salePrice ?? this.salePrice,
      stock: stock ?? this.stock,
      imageUrl: imageUrl ?? this.imageUrl,
      isFeatured: isFeatured ?? this.isFeatured,
      productAttributes: productAttributes ?? this.productAttributes,
      productVariations: productVariations ?? this.productVariations,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get hasVariations => productVariations.isNotEmpty;

  bool get hasSale => salePrice > 0 && salePrice < price;

  int get discountPercent =>
      hasSale ? (((price - salePrice) / price) * 100).round() : 0;

  /// the price the customer actually pays at product level
  double get displayPrice => hasSale ? salePrice : price;

  int get totalStock => hasVariations
      ? productVariations.fold<int>(0, (sum, v) => sum + v.stock)
      : stock;

  bool get inStock => totalStock > 0;

  /// best image for list/grid cards
  String get cardImage {
    if (thumbnail.isNotEmpty) return thumbnail;
    if (imageUrl.isNotEmpty) return imageUrl.first;
    for (final v in productVariations) {
      if (v.image.isNotEmpty) return v.image;
    }
    return '';
  }

  List<String> valuesOf(String attr) => productAttributes
      .firstWhere(
        (e) => e.name.toLowerCase() == attr.toLowerCase(),
        orElse: () => const ProductAttribute(name: ''),
      )
      .values;

  ProductVariation? findVariation({String? color, String? size}) {
    String? read(Map<String, String> m, String key) {
      for (final e in m.entries) {
        if (e.key.toLowerCase() == key) return e.value;
      }
      return null;
    }

    for (final v in productVariations) {
      final colorOk =
          color == null || read(v.attributeValues, 'color') == color;
      final sizeOk = size == null || read(v.attributeValues, 'size') == size;
      if (colorOk && sizeOk) return v;
    }
    return null;
  }

  List<String> get galleryImages {
    final list = <String>[...imageUrl];
    for (final v in productVariations) {
      if (v.image.isNotEmpty) list.add(v.image);
    }
    if (thumbnail.isNotEmpty) list.add(thumbnail);
    return list.toSet().toList();
  }
}
