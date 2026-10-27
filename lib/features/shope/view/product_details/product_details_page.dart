import 'package:ecommerce_frontend/core/util/common/widgets/section_header.dart';
import 'package:ecommerce_frontend/data/model/product_model.dart';
import 'package:ecommerce_frontend/features/shope/view/productReview/product_review_page.dart';
import 'package:ecommerce_frontend/features/shope/view/product_details/widget/bottom_add_to_cart.dart';
import 'package:ecommerce_frontend/features/shope/view/product_details/widget/product_attribute.dart';
import 'package:ecommerce_frontend/features/shope/view/product_details/widget/product_image_slider.dart';
import 'package:ecommerce_frontend/features/shope/view/product_details/widget/product_meta_data.dart';
import 'package:ecommerce_frontend/features/shope/view/product_details/widget/ratingand_share.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;
  const ProductDetailsPage({required this.product, super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  String? _color;
  String? _size;
  String? _image;

  Product get _p => widget.product;

  ProductVariation? get _variation =>
      _p.findVariation(color: _color, size: _size);

  void _syncImage() {
    final v = _variation;
    _image = (v != null && v.image.isNotEmpty)
        ? v.image
        : _p.galleryImages.firstOrNull;
  }

  @override
  void initState() {
    super.initState();

    _color = _p.valuesOf('color').firstOrNull;
    _size = _p.valuesOf('size').firstOrNull;
  }

  @override
  Widget build(BuildContext context) {
    final product = _p;
    final v = _variation;

    final price = v?.price ?? product.price;
    final salePrice = v?.salePrice ?? product.salePrice;
    final stock = v?.stock ?? product.totalStock;

    return Scaffold(
      bottomNavigationBar: BottomAddToCart(
        product: product,
        selectedSize: _size,
        selectedColor: _color,
        selectedImage: _image,
        enabled: stock > 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // image slider
            ProductImageSlider(
              product: product,
              images: product.galleryImages,
              selectedImage: _image,
              onImageChanged: (url) => setState(() => _image = url),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 24.0, left: 24, bottom: 24),
              child: Column(
                children: [
                  RatingandShare(),
                  ProductMetaData(
                    product: product,
                    price: price,
                    salePrice: salePrice,
                    stock: stock,
                  ),
                  SizedBox(height: 24),
                  // attribute
                  ProductAttributeWidget(
                    product: product,
                    price: price,
                    salePrice: salePrice,
                    stock: stock,
                    selectedColor: _color,
                    selectedSize: _size,
                    onColorSelected: (c) => setState(() {
                      _color = c;
                      _syncImage();
                    }),
                    onSizeSelected: (s) => setState(() {
                      _size = s;
                      _syncImage();
                    }),
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text("Checkout"),
                    ),
                  ),
                  SizedBox(height: 24),
                  SectionHeader(title: "Description", ShowActionButton: false),
                  SizedBox(height: 24),
                  ReadMoreText(
                    widget.product.description ?? '',
                    trimMode: TrimMode.Line,
                    trimLines: 2,
                    trimCollapsedText: 'show more',
                    trimExpandedText: 'Less',
                    moreStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                    lessStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 24),
                  Divider(),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SectionHeader(
                        title: "Reviews(199)",
                        onPressed: () {},
                        ShowActionButton: false,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductReviewPage(),
                            ),
                          );
                        },
                        icon: Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
