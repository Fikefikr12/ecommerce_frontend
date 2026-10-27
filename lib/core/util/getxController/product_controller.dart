import 'package:ecommerce_frontend/core/service/product_service.dart';
import 'package:ecommerce_frontend/data/model/product_model.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final isloading = false.obs;
  // to get instance of class use Get.put()
  final productRepositery = Get.put(ProductService());
  RxList<Product> featuredProduct = <Product>[].obs;

  @override
  void onInit() {
    fetchFeathuredProducts();
    super.onInit();
  }

  void fetchFeathuredProducts() async {
    try {
      // show loader while loading products
      isloading.value = true;

      // fetch Products
      final products = await productRepositery.getAllProducts();
    } catch (e) {
    } finally {
      isloading.value = false;
    }
  }
}
