import 'package:ecommerce_frontend/data/model/cart_Item.dart';

class Cart {
  final String id;
  final String userId;
  final List<CartItemModel> items;
  final double totalPrice;
  final int totalItems;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Cart({
    required this.id,
    required this.userId,
    this.items = const [],
    this.totalPrice = 0,
    this.totalItems = 0,
    this.createdAt,
    this.updatedAt,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['_id']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',

      items: (json['items'] as List<dynamic>? ?? [])
          .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>))
          .toList(),

      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0,

      totalItems: (json['totalItems'] as num?)?.toInt() ?? 0,

      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,

      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'items': items.map((item) => item.toJson()).toList(),
      'totalPrice': totalPrice,
      'totalItems': totalItems,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  Cart copyWith({
    String? id,
    String? userId,
    List<CartItemModel>? items,
    double? totalPrice,
    int? totalItems,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Cart(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      items: items ?? this.items,
      totalPrice: totalPrice ?? this.totalPrice,
      totalItems: totalItems ?? this.totalItems,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
