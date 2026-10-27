// import 'package:ecommerce_frontend/data/model/product_model.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class DatabaseService {
//   static String get baseUrl {
//     return 'https://ecommerce-backend-4lg4.onrender.com/api';
//     // /// Flutter Web /chrome
//     // if (kIsWeb) {
//     //   return 'http://localhost:3000/api';
//     // }
//     // /// Android Emulator
//     // if (Platform.isAndroid) {
//     //   return 'http://192.168.1.12:3000/api';
//     // }

//     // /// iOS Simulator
//     // if (Platform.isIOS) {
//     //   return 'http://localhost:3000/api';
//     // }

//     // /// Physical Device
//     // return 'http://192.168.100.210:3000/api';
//   }

//   // FOR JSON
//   // Future<Product> createProduct(Product product) async {
//   //   try {
//   //     final response = await http.post(
//   //       Uri.parse('$baseUrl/products'),
//   //       body: jsonEncode(product.toJson()),
//   //       headers: {'Content-Type': 'application/json'},
//   //     );

//   //     final data = jsonDecode(response.body);
//   //     if (response.statusCode == 201) {
//   //       return Product.fromJson(data['data']);
//   //     } else {
//   //       throw Exception(data['message'] ?? ' Failed to create Product');
//   //     }
//   //   } catch (e) {
//   //     throw Exception(e.toString());
//   //   }
//   // }

//   // Get All Products
//   Future<List<Product>> getAllProducts() async {
//     try {
//       final response = await http.get(Uri.parse('$baseUrl/products'));

//       final data = jsonDecode(response.body);

//       if (response.statusCode == 200) {
//         final List products = data['data']; // type List<dynamic>

//         return products.map((e) => Product.fromJson(e)).toList();
//       } else {
//         throw Exception(
//           data['message'] ?? // data['message'] is empty...
//               'Failed to fetch products',
//         );
//       }
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }

//   Future<Product> getSingleProduct(String id) async {
//     try {
//       final response = await http.get(Uri.parse('$baseUrl/products/$id'));
//       final data = jsonDecode(response.body);

//       if (response.statusCode == 200) {
//         return Product.fromJson(data['data']);
//       } else {
//         throw Exception(data['message'] ?? 'failed to load to product');
//       }
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }

//   // FOR JSON
//   Future<Product> createProductforJsonData(Product product) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/products'),
//         body: jsonEncode(product.toJson()),
//         headers: {'Content-Type': 'application/json'},
//       );

//       final data = jsonDecode(response.body);
//       if (response.statusCode == 201) {
//         return Product.fromJson(data['data']);
//       } else {
//         throw Exception(data['message'] ?? ' Failed to create Product');
//       }
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }

//   Future<Product> updateProduct(String id, Product product) async {
//     try {
//       final response = await http.put(
//         Uri.parse('$baseUrl/products/$id'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode(product.toJson()),
//       );

//       final data = jsonDecode(response.body);

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         return Product.fromJson(data['data']);
//       } else {
//         throw Exception(data['message'] ?? ' Failed to create Product');
//       }
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }

//   Future<String> deleteProduct(String id) async {
//     try {
//       final response = await http.delete(Uri.parse('$baseUrl/products/$id'));

//       final data = jsonDecode(response.body);

//       if (response.statusCode == 200) {
//         return data['message'];
//       } else {
//         throw Exception(data['message'] ?? 'Failed to delete product');
//       }
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }

//   Future<List<Product>> searchProduct(String key) async {
//     try {
//       final response = await http.get(
//         Uri.parse('$baseUrl/products/search?key=$key'),
//       );

//       final data = jsonDecode(response.body);

//       if (response.statusCode == 200) {
//         final List products = data['data'];

//         return products.map((e) => Product.fromJson(e)).toList();
//       } else {
//         throw Exception(data['message'] ?? 'failed to search product');
//       }
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }
// }
