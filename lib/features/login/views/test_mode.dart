// import 'dart:io';

// import 'package:ecommerce_frontend/core/service/database_service.dart';
// import 'package:ecommerce_frontend/core/service/product_service.dart';
// import 'package:ecommerce_frontend/data/model/product_model.dart';
// import 'package:ecommerce_frontend/features/login/views/poduct_detail.dart';
// import 'package:ecommerce_frontend/features/login/views/product_bloc_ui.dart';
// import 'package:ecommerce_frontend/features/shope/view/product_details/product_details_page.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class TestMode extends StatefulWidget {
//   const TestMode({super.key});

//   @override
//   State<TestMode> createState() => _TestModeState();
// }

// class _TestModeState extends State<TestMode> {
//   final ProductService databaseService = ProductService();
//   final searchController = TextEditingController();
//   final nameController = TextEditingController();
//   final descriptionController = TextEditingController();
//   final categoryController = TextEditingController();
//   final priceController = TextEditingController();
//   final discountPriceController = TextEditingController();
//   final titleController = TextEditingController();
//   List<Product> products = [];
//   bool isLoading = false;
//   Product? selectedProduct;
//   XFile? selectedImage;

//   @override
//   void initState() {
//     super.initState();
//     getAllProducts();
//   }

//   // get all product
//   Future<void> getAllProducts() async {
//     try {
//       setState(() {
//         isLoading = true;
//       });

//       final result = await databaseService.getAllProducts();

//       setState(() {
//         products = result;
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       debugPrint(e.toString());
//     }
//   }

//   // get single product
//   Future<void> getSingleProduct(String id) async {
//     try {
//       setState(() {
//         isLoading = true;
//       });

//       final result = await databaseService.getSingleProduct(id);

//       setState(() {
//         selectedProduct = result;
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       debugPrint(e.toString());
//     }
//   }

//   // search product
//   Future<void> searchProduct() async {
//     try {
//       setState(() {
//         isLoading = true;
//       });

//       final result = await databaseService.searchProduct(searchController.text);

//       setState(() {
//         products = result;
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       debugPrint(e.toString());
//     }
//   }

//   Future<void> deleteProduct(String id) async {
//     try {
//       await databaseService.deleteProduct(id);
//       getAllProducts();
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           backgroundColor: Colors.red,
//           content: Text('Product deleted'),
//         ),
//       );
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   // CLEAR ALL PRODUCTS
//   Future<void> clearAllProducts() async {
//     try {
//       for (final product in products) {
//         await databaseService.deleteProduct(product.id);
//       }

//       getAllProducts();

//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('All products deleted')));
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   void clearControllers() {
//     nameController.clear();
//     titleController.clear();
//     categoryController.clear();
//     descriptionController.clear();
//     priceController.clear();
//     discountPriceController.clear();
//   }

//   // update values
//   void fillControllers(Product product) {
//     nameController.text = product.name;
//     titleController.text = product.title;
//     categoryController.text = product.category;
//     descriptionController.text = product.description;
//     priceController.text = product.price.toString();
//     discountPriceController.text = product.discountPrice.toString();
//   }

//   Future<void> createProduct() async {
//     try {
//       final product = Product(
//         id: '',
//         name: nameController.text.trim(),
//         title: titleController.text.trim(),
//         category: categoryController.text.trim(),
//         description: descriptionController.text.trim(),
//         imageUrl: [],
//         price: double.tryParse(priceController.text) ?? 0,
//         discountPrice: double.tryParse(discountPriceController.text) ?? 0,
//       );

//       await databaseService.createProduct(product, selectedImage);

//       Navigator.pop(context);

//       clearControllers();

//       getAllProducts();

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           backgroundColor: Colors.green,
//           content: Text('Product Created'),
//         ),
//       );
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   Future<void> updateProduct(Product oldProduct) async {
//     try {
//       final updatedProduct = Product(
//         id: oldProduct.id,
//         name: nameController.text.trim(),
//         title: titleController.text.trim(),
//         category: categoryController.text.trim(),
//         description: descriptionController.text.trim(),
//         imageUrl: oldProduct.imageUrl,
//         price: double.tryParse(priceController.text) ?? 0,
//         discountPrice: double.tryParse(discountPriceController.text) ?? 0,
//       );

//       await databaseService.updateProduct(
//         oldProduct.id,
//         updatedProduct,
//         selectedImage,
//       );

//       Navigator.pop(context);

//       clearControllers();

//       getAllProducts();

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           backgroundColor: Colors.blue,
//           content: Text('Product Updated'),
//         ),
//       );
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   Future<void> showProductDialog({Product? product}) async {
//     if (product != null) {
//       fillControllers(product);
//     } else {
//       clearControllers();
//     }

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(product == null ? 'Create Product' : 'Update Product'),

//           content: SingleChildScrollView(
//             child: SizedBox(
//               width: 400,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   TextField(
//                     controller: nameController,
//                     decoration: const InputDecoration(labelText: 'Name'),
//                   ),

//                   const SizedBox(height: 12),

//                   TextField(
//                     controller: titleController,
//                     decoration: const InputDecoration(labelText: 'Title'),
//                   ),

//                   const SizedBox(height: 12),

//                   TextField(
//                     controller: categoryController,
//                     decoration: const InputDecoration(labelText: 'Category'),
//                   ),

//                   const SizedBox(height: 12),

//                   TextField(
//                     controller: descriptionController,
//                     maxLines: 3,
//                     decoration: const InputDecoration(labelText: 'Description'),
//                   ),

//                   const SizedBox(height: 12),

//                   TextField(
//                     controller: priceController,
//                     keyboardType: TextInputType.number,
//                     decoration: const InputDecoration(labelText: 'Price'),
//                   ),

//                   const SizedBox(height: 12),

//                   TextField(
//                     controller: discountPriceController,
//                     keyboardType: TextInputType.number,
//                     decoration: const InputDecoration(labelText: 'Old Price'),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('Cancel'),
//             ),

//             ElevatedButton(
//               onPressed: () {
//                 if (product == null) {
//                   createProduct();
//                 } else {
//                   updateProduct(product);
//                 }
//               },
//               child: Text(product == null ? 'Create' : 'Update'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Products"),
//         actions: [
//           // CREATE PRODUCT
//           IconButton(
//             onPressed: () {
//               showProductDialog();
//             },
//             icon: const Icon(Icons.add),
//           ),
//           SizedBox(width: 50),
//           TextButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => ProductBlocUi()),
//               );
//             },
//             child: Text("Bloc ui "),
//           ),
//         ],
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: SizedBox(
//               width: 400,
//               child: TextField(
//                 controller: searchController,
//                 onSubmitted: (value) {
//                   if (value.trim().isEmpty) {
//                     getAllProducts();
//                   } else {
//                     searchProduct();
//                   }
//                 },
//                 decoration: InputDecoration(
//                   hintText: 'Search products',
//                   prefixIcon: Icon(Icons.search),
//                   suffixIcon: IconButton(
//                     onPressed: () {
//                       searchController.clear();
//                       getAllProducts();
//                     },
//                     icon: Icon(Icons.close),
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(16),
//                     borderSide: BorderSide(width: 2, color: Colors.black38),
//                   ),
//                   filled: true,
//                   fillColor: Colors.grey.shade200,
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: isLoading
//                 ? Center(child: CircularProgressIndicator())
//                 : products.isEmpty
//                 ? const Center(child: Text("No products found"))
//                 : ListView.builder(
//                     itemCount: products.length,
//                     itemBuilder: (context, index) {
//                       final product = products[index];

//                       return SizedBox(
//                         width: 600,
//                         child: Card(
//                           margin: const EdgeInsets.symmetric(
//                             horizontal: 12,
//                             vertical: 6,
//                           ),
//                           child: ListTile(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) =>
//                                       PoductDetail(productId: product.id),
//                                 ),
//                               );
//                             },
//                             leading: Text('${product.discountPrice}'),
//                             title: Text(product.name),
//                             subtitle: Text(product.description),
//                             trailing: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 IconButton(
//                                   onPressed: () {
//                                     showProductDialog(product: product);
//                                   },
//                                   icon: const Icon(
//                                     Icons.edit,
//                                     color: Colors.blue,
//                                   ),
//                                 ),
//                                 IconButton(
//                                   onPressed: () {
//                                     deleteProduct(product.id);
//                                   },
//                                   icon: Icon(Icons.delete, color: Colors.red),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: showProductDialog,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
