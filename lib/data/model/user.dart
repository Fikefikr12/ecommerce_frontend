class User {
  final String? id;
  final String firebaseUId;

  final String? name;
  final String username;
  final String email;

  final List<String>? profileImage;
  final String role;

  final String? address;
  final String? phone;
  final String? location;

  final bool isActive;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.id,
    required this.firebaseUId,
    this.name,
    required this.username,
    required this.email,
    this.profileImage,
    this.role = 'user',
    this.address,
    this.phone,
    this.location,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id']?.toString(),
      firebaseUId: json['firebaseUId'] ?? '',
      name: json['name'],
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      profileImage: List<String>.from(json['profileImage'] ?? []),
      role: json['role'] ?? 'user',
      address: json['address'],
      phone: json['phone'],
      location: json['location'],
      isActive: json['isActive'] ?? true,
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
      "firebaseUId": firebaseUId,
      "name": name,
      "username": username,
      "email": email,
      "profileImage": profileImage,
      "role": role,
      "address": address,
      "phone": phone,
      "location": location,
      "isActive": isActive,
    };
  }

  User copyWith({
    String? id,
    String? firebaseUId,
    String? name,
    String? username,
    String? email,
    List<String>? profileImage,
    String? role,
    String? address,
    String? phone,
    String? location,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      firebaseUId: firebaseUId ?? this.firebaseUId,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      role: role ?? this.role,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
