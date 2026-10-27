// import 'dart:io';

// import 'package:ecommerce_frontend/data/model/product_model.dart';
// import 'package:ecommerce_frontend/features/login/views/poduct_detail.dart';
// import 'package:ecommerce_frontend/features/shope/bloc/shope_bloc.dart';
// import 'package:ecommerce_frontend/features/shope/bloc/shope_event.dart';
// import 'package:ecommerce_frontend/features/shope/bloc/shope_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';

// class ProductBlocUi extends StatefulWidget {
//   const ProductBlocUi({super.key});

//   @override
//   State<ProductBlocUi> createState() => _ProductBlocUiState();
// }

// class _ProductBlocUiState extends State<ProductBlocUi> {
//   final searchController = TextEditingController();
//   final nameController = TextEditingController();
//   final descriptionController = TextEditingController();
//   final categoryController = TextEditingController();
//   final priceController = TextEditingController();
//   final discountPriceController = TextEditingController();
//   final titleController = TextEditingController();
//   XFile? selectedImage;

//   @override
//   void initState() {
//     super.initState();
//     context.read<ShopeBloc>().add(GetAllProductsEvent());
//   }

//   Future<void> pickImage() async {
//     final picker = ImagePicker();

//     final image = await picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         selectedImage = image;
//       });
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

//   void fillControllers(Product product) {
//     nameController.text = product.name;
//     titleController.text = product.title;
//     categoryController.text = product.category;
//     descriptionController.text = product.description;
//     priceController.text = product.price.toString();
//     discountPriceController.text = product.discountPrice.toString();
//   }

//   void createProduct() {
//     final product = Product(
//       id: '',
//       name: nameController.text.trim(),
//       title: titleController.text.trim(),
//       category: categoryController.text.trim(),
//       description: descriptionController.text.trim(),
//       imageUrl: [],
//       price: double.tryParse(priceController.text) ?? 0,
//       discountPrice: double.tryParse(discountPriceController.text) ?? 0,
//       brand: '',
//       stock: 0,
//       colors: [],
//       sizes: [],
//     );
//     context.read<ShopeBloc>().add(
//       CreateProductEvent(product: product, image: selectedImage),
//     );
//     Navigator.pop(context);

//     clearControllers();

//     selectedImage = null;
//   }

//   void updateProduct(Product oldProduct) {
//     final updatedProduct = Product(
//       id: oldProduct.id,
//       name: nameController.text.trim(),
//       title: titleController.text.trim(),
//       category: categoryController.text.trim(),
//       description: descriptionController.text.trim(),
//       imageUrl: oldProduct.imageUrl,
//       price: double.tryParse(priceController.text) ?? 0,
//       discountPrice: double.tryParse(discountPriceController.text) ?? 0,
//       brand: oldProduct.brand,
//       stock: oldProduct.stock,
//       colors: oldProduct.colors,
//       sizes: oldProduct.sizes,
//       createdAt: oldProduct.createdAt,
//       updatedAt: oldProduct.updatedAt,
//     );

//     context.read<ShopeBloc>().add(
//       UpdateProductEvent(
//         id: oldProduct.id,
//         product: updatedProduct,
//         image: selectedImage,
//       ),
//     );

//     Navigator.pop(context);

//     clearControllers();

//     selectedImage = null;
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
//         return StatefulBuilder(
//           builder: (context, setDialogState) {
//             return AlertDialog(
//               title: Text(
//                 product == null ? 'Create Product' : 'Update Product',
//               ),

//               content: SingleChildScrollView(
//                 child: SizedBox(
//                   width: 400,

//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       GestureDetector(
//                         onTap: pickImage,
//                         child: Container(
//                           height: 120,
//                           width: 120,
//                           decoration: BoxDecoration(border: Border.all()),
//                           child: selectedImage != null
//                               ? Image.file(
//                                   File(selectedImage!.path),
//                                   fit: BoxFit.cover,
//                                 )
//                               : const Icon(Icons.add_a_photo, size: 40),
//                         ),
//                       ),
//                       TextField(
//                         controller: nameController,
//                         decoration: const InputDecoration(labelText: 'Name'),
//                       ),

//                       const SizedBox(height: 12),

//                       TextField(
//                         controller: titleController,
//                         decoration: const InputDecoration(labelText: 'Title'),
//                       ),

//                       const SizedBox(height: 12),

//                       TextField(
//                         controller: categoryController,
//                         decoration: const InputDecoration(
//                           labelText: 'Category',
//                         ),
//                       ),

//                       const SizedBox(height: 12),

//                       TextField(
//                         controller: descriptionController,
//                         maxLines: 3,
//                         decoration: const InputDecoration(
//                           labelText: 'Description',
//                         ),
//                       ),

//                       const SizedBox(height: 12),

//                       TextField(
//                         controller: priceController,
//                         keyboardType: TextInputType.number,
//                         decoration: const InputDecoration(labelText: 'Price'),
//                       ),

//                       const SizedBox(height: 12),

//                       TextField(
//                         controller: discountPriceController,
//                         keyboardType: TextInputType.number,
//                         decoration: const InputDecoration(
//                           labelText: 'discount Price',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Text('Cancel'),
//                 ),

//                 ElevatedButton(
//                   onPressed: () {
//                     if (product == null) {
//                       createProduct();
//                     } else {
//                       updateProduct(product);
//                     }
//                   },

//                   child: Text(product == null ? 'Create' : 'Update'),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Products"),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             onPressed: () {
//               showProductDialog();
//             },
//             icon: const Icon(Icons.add),
//           ),

//           IconButton(
//             onPressed: () {
//               //  context.read<ShopeBloc>().add(ClearAllProductsEvent());
//             },
//             icon: const Icon(Icons.delete_forever),
//           ),
//         ],
//       ),
//       body: BlocConsumer<ShopeBloc, ShopeState>(
//         listener: (context, state) {
//           if (state.errorMessage != null) {
//             ScaffoldMessenger.of(
//               context,
//             ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
//           }
//         },
//         builder: (context, state) {
//           return Column(
//             children: [
//               /// SEARCH
//               Padding(
//                 padding: const EdgeInsets.all(8.0),

//                 child: SizedBox(
//                   width: 400,

//                   child: TextField(
//                     controller: searchController,

//                     onSubmitted: (value) {
//                       if (value.trim().isEmpty) {
//                         context.read<ShopeBloc>().add(GetAllProductsEvent());
//                       } else {
//                         context.read<ShopeBloc>().add(
//                           SearchProductEvent(query: value),
//                         );
//                       }
//                     },

//                     decoration: InputDecoration(
//                       hintText: 'Search products',

//                       prefixIcon: const Icon(Icons.search),

//                       suffixIcon: IconButton(
//                         onPressed: () {
//                           searchController.clear();

//                           context.read<ShopeBloc>().add(GetAllProductsEvent());
//                         },
//                         icon: const Icon(Icons.close),
//                       ),

//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(16),
//                       ),

//                       filled: true,
//                       fillColor: Colors.grey.shade200,
//                     ),
//                   ),
//                 ),
//               ),

//               /// PRODUCT LIST
//               Expanded(
//                 child: state.isLoading
//                     ? const Center(child: CircularProgressIndicator())
//                     : state.products.isEmpty
//                     ? const Center(child: Text("No products found"))
//                     : ListView.builder(
//                         itemCount: state.products.length,

//                         itemBuilder: (context, index) {
//                           final product = state.products[index];

//                           return SizedBox(
//                             width: 600,

//                             child: Card(
//                               margin: const EdgeInsets.symmetric(
//                                 horizontal: 12,
//                                 vertical: 6,
//                               ),

//                               child: ListTile(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) =>
//                                           PoductDetail(productId: product.id),
//                                     ),
//                                   );
//                                 },

//                                 leading: product.imageUrl.isNotEmpty
//                                     ? ClipRRect(
//                                         borderRadius: BorderRadius.circular(8),
//                                         child: Image.network(
//                                           product.imageUrl.first.replaceAll(
//                                             'localhost',
//                                             '192.168.100.210',
//                                           ),
//                                           width: 80,
//                                           height: 90,
//                                           fit: BoxFit.cover,
//                                           errorBuilder:
//                                               (context, error, stackTrace) {
//                                                 return const Icon(
//                                                   Icons.broken_image,
//                                                 );
//                                               },
//                                         ),
//                                       )
//                                     : Icon(Icons.image),
//                                 title: Text(product.name),

//                                 subtitle: Text(product.description),

//                                 trailing: Row(
//                                   mainAxisSize: MainAxisSize.min,

//                                   children: [
//                                     /// UPDATE
//                                     IconButton(
//                                       onPressed: () {
//                                         showProductDialog(product: product);
//                                       },

//                                       icon: const Icon(
//                                         Icons.edit,
//                                         color: Colors.blue,
//                                       ),
//                                     ),

//                                     /// DELETE
//                                     IconButton(
//                                       onPressed: () {
//                                         context.read<ShopeBloc>().add(
//                                           DeleteProductEvent(id: product.id),
//                                         );
//                                       },

//                                       icon: const Icon(
//                                         Icons.delete,
//                                         color: Colors.red,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//               ),
//             ],
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showProductDialog();
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
