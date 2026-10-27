class OrderModel {
  final String? id;
  final String userId;
  final List<OrderItem> items;
  final ShippingAddress shippingAddress;
  final String? orderName;
  final String paymentMethod;
  final String paymentStatus;
  final String orderStatus;
  final double subtotal;
  final double deliveryFee;
  final double total;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  OrderModel({
    this.id,
    required this.userId,
    required this.items,
    required this.shippingAddress,
    this.orderName,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.orderStatus,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['_id'],
      userId: json['userId'],
      items: (json['items'] as List).map((e) => OrderItem.fromJson(e)).toList(),
      shippingAddress: ShippingAddress.fromJson(json['shippingAddress']),
      orderName: json['orderName'],
      paymentMethod: json['paymentMethod'],
      paymentStatus: json['paymentStatus'],
      orderStatus: json['orderStatus'],
      subtotal: (json['subtotal'] as num).toDouble(),
      deliveryFee: (json['deliveryFee'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'items': items.map((e) => e.toJson()).toList(),
      'shippingAddress': shippingAddress.toJson(),
      'orderName': orderName,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'orderStatus': orderStatus,
      'subtotal': subtotal,
      'deliveryFee': deliveryFee,
      'total': total,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  OrderModel copyWith({
    String? id,
    String? userId,
    List<OrderItem>? items,
    ShippingAddress? shippingAddress,
    String? orderName,
    String? paymentMethod,
    String? paymentStatus,
    String? orderStatus,
    double? subtotal,
    double? deliveryFee,
    double? total,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return OrderModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      items: items ?? this.items,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      orderName: orderName ?? this.orderName,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      orderStatus: orderStatus ?? this.orderStatus,
      subtotal: subtotal ?? this.subtotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      total: total ?? this.total,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class OrderItem {
  final String productId;
  final int quantity;
  final String? selectedSize;
  final String? selectedColor;
  final double price;

  OrderItem({
    required this.productId,
    required this.quantity,
    this.selectedSize,
    this.selectedColor,
    required this.price,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId'],
      quantity: json['quantity'],
      selectedSize: json['selectedSize'],
      selectedColor: json['selectedColor'],
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
      'selectedSize': selectedSize,
      'selectedColor': selectedColor,
      'price': price,
    };
  }

  OrderItem copyWith({
    String? productId,
    int? quantity,
    String? selectedSize,
    String? selectedColor,
    double? price,
  }) {
    return OrderItem(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
      price: price ?? this.price,
    );
  }
}

class ShippingAddress {
  final String fullName;
  final String phone;
  final String city;
  final String? subCity;
  final String street;
  final String? postalCode;

  ShippingAddress({
    required this.fullName,
    required this.phone,
    required this.city,
    this.subCity,
    required this.street,
    this.postalCode,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
      fullName: json['fullName'],
      phone: json['phone'],
      city: json['city'],
      subCity: json['subCity'],
      street: json['street'],
      postalCode: json['postalCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'phone': phone,
      'city': city,
      'subCity': subCity,
      'street': street,
      'postalCode': postalCode,
    };
  }

  ShippingAddress copyWith({
    String? fullName,
    String? phone,
    String? city,
    String? subCity,
    String? street,
    String? postalCode,
  }) {
    return ShippingAddress(
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      city: city ?? this.city,
      subCity: subCity ?? this.subCity,
      street: street ?? this.street,
      postalCode: postalCode ?? this.postalCode,
    );
  }
}
