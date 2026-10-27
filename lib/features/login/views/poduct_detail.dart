import 'package:ecommerce_frontend/core/service/product_service.dart';
import 'package:ecommerce_frontend/data/model/product_model.dart';
import 'package:flutter/material.dart';

class PoductDetail extends StatefulWidget {
  final String productId;
  const PoductDetail({super.key, required this.productId});

  @override
  State<PoductDetail> createState() => _PoductDetailState();
}

class _PoductDetailState extends State<PoductDetail> {
  final databaseService = ProductService();
  Product? product;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getSingleProduct();
  }

  Future<void> getSingleProduct() async {
    try {
      setState(() {
        isLoading = true;
      });
      final result = await databaseService.getSingleProduct(widget.productId);

      setState(() {
        product = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Detail')),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : product == null
          ? const Center(child: Text("Product not found"))
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.shopping_bag, size: 80),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    product!.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    product!.description,
                    style: const TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    "Price: \$${product!.salePrice}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
