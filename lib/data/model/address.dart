class AddressModel {
  final String? id;
  final String userId;
  final String name;
  final String phoneNumber;
  final String street;
  final String city;
  final String subCity;
  final String postalCode;
  final String country;
  final bool isSelected;
  final double? latitude;
  final double? longitude;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const AddressModel({
    this.id,
    required this.userId,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.city,
    required this.subCity,
    required this.postalCode,
    required this.country,
    required this.isSelected,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['_id'],
      userId: json['userId'] is Map
          ? json['userId']['_id']?.toString() ?? ''
          : json['userId']?.toString() ?? '',

      name: json['name'],
      phoneNumber: json['phoneNumber'],
      street: json['street'],
      city: json['city'],
      subCity: json['SubCity'] ?? '',
      postalCode: json['postalCode'] ?? '',
      country: json['country'],
      latitude: json['latitude'] != null
          ? (json['latitude'] as num).toDouble()
          : null,
      longitude: json['longitude'] != null
          ? (json['longitude'] as num).toDouble()
          : null,
      isSelected: json['isSelected'] ?? false,
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
      'name': name,
      'phoneNumber': phoneNumber,
      'street': street,
      'city': city,
      'SubCity': subCity,
      'postalCode': postalCode,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
      'isSelected': isSelected,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  AddressModel copyWith({
    String? id,
    String? userId,
    String? name,
    String? phoneNumber,
    String? street,
    String? city,
    String? subCity,
    String? postalCode,
    String? country,
    double? latitude,
    double? longitude,
    bool? isSelected,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AddressModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      street: street ?? this.street,
      city: city ?? this.city,
      subCity: subCity ?? this.subCity,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isSelected: isSelected ?? this.isSelected,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
