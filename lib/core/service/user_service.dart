import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:ecommerce_frontend/data/model/user.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class UserService {
  static String get baseUrl {
    // return 'https://ecommerce-backend-4lg4.onrender.com/api';
    /// Flutter Web /chrome
    if (kIsWeb) {
      return 'http://localhost:3000/api';
    }

    /// Android Emulator
    if (Platform.isAndroid) {
      return 'http://192.168.100.210:3000/api';
    }

    /// iOS Simulator
    if (Platform.isIOS) {
      return 'http://localhost:3000/api';
    }

    /// Physical Device
    return 'http://192.168.100.210:3000/api';
  }

  Future<User> createUser(User user, List<XFile>? imageFiles) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/users'),
      );

      // Text fields
      request.fields['firebaseUId'] = user.firebaseUId;
      request.fields['name'] = user.name ?? '';
      request.fields['username'] = user.username;
      request.fields['email'] = user.email;
      request.fields['role'] = user.role;
      request.fields['address'] = user.address ?? '';
      request.fields['phone'] = user.phone ?? '';
      request.fields['location'] = user.location ?? '';
      request.fields['isActive'] = user.isActive.toString();

      // Upload images
      if (imageFiles != null && imageFiles.isNotEmpty) {
        for (final imageFile in imageFiles) {
          request.files.add(
            await http.MultipartFile.fromPath(
              'images', // Must match Multer field name
              imageFile.path,
            ),
          );
        }
      }

      final response = await request.send();

      final responseData = await response.stream.bytesToString();

      final data = jsonDecode(responseData);

      if (response.statusCode == 201) {
        return User.fromJson(data['data']);
      } else {
        throw Exception(data['message'] ?? 'Failed to create user');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// GET CURRENT USER
  Future<User> getCurrentUser() async {
    try {
      // 🔥 Get Firebase token to send in header
      final token = await auth.FirebaseAuth.instance.currentUser?.getIdToken();

      final response = await http.get(
        Uri.parse('$baseUrl/users/me'), // 🔥 Fix: use /me not /current/:uid
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer $token', // 🔥 Required by verifyFirebaseToken middleware
        },
      );

      // 🔥 Debug
      print("getCurrentUser status: ${response.statusCode}");
      print("getCurrentUser body: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return User.fromJson(data['data']);
      }

      throw Exception(data['message'] ?? 'Failed to load current user');
    } catch (e) {
      throw Exception('Get Current User Error: $e');
    }
  }

  /// GET SINGLE USER
  Future<User> getSingleUser(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/users/$id'));

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return User.fromJson(data['data']);
      }

      throw Exception(data['message'] ?? 'Failed to load user');
    } catch (e) {
      throw Exception('Get User Error: $e');
    }
  }

  // get all users
  Future<List<User>> getAllUsers() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/users'));

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return (data['data'] as List).map((e) => User.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<User> updateUser(String id, User user) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/users/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': user.name,
          'username': user.username,
          'email': user.email,
          'profileImage': user.profileImage,
          'address': user.address,
          'phone': user.phone,
          'location': user.location,
          'isActive': user.isActive,
        }),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return User.fromJson(data['data']);
      }
      throw Exception(data['message'] ?? 'Failed to update user');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// DELETE USER
  Future<bool> deleteUser(String id) async {
    try {
      final token = await auth.FirebaseAuth.instance.currentUser?.getIdToken();

      final response = await http.delete(
        Uri.parse('$baseUrl/users/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer$token',
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return true;
      }

      throw Exception(data['message'] ?? 'Failed to delete user');
    } catch (e) {
      throw Exception('Delete User Error: $e');
    }
  }

  // change user role
  Future<User> changeUserRole(String userId, String role) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/users/$userId/role'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'role': role}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return User.fromJson(data['data']);
      }

      throw Exception(data['message'] ?? 'Failed to update role');
    } catch (e) {
      throw Exception('Change Role Error: $e');
    }
  }
}
