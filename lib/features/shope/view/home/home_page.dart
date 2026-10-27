import 'package:ecommerce_frontend/core/util/common/widgets/circular_image_text.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/image_slider.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/product_card_vertical.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/section_header.dart';
import 'package:ecommerce_frontend/core/util/getxController/product_controller.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_bloc.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_event.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_state.dart';
import 'package:ecommerce_frontend/features/shope/view/all-products/all_products_page.dart';
import 'package:ecommerce_frontend/features/shope/view/home/widget/grid_layout.dart';
import 'package:ecommerce_frontend/features/shope/view/home/widget/home_categories.dart';
import 'package:ecommerce_frontend/features/shope/view/sub_catagory/sub_catagory_page.dart';
import 'package:ecommerce_frontend/features/shope/view/websoket_page.dart';
import 'package:ecommerce_frontend/features/shope/widgets/header_container.dart';
import 'package:ecommerce_frontend/features/shope/view/home/widget/home_app_bar.dart';
import 'package:ecommerce_frontend/features/shope/view/home/widget/search_Container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    context.read<ShopeBloc>().add(GetAllCategoriesEvent());
    context.read<ShopeBloc>().add(GetAllProductsEvent(limit: 2));
    context.read<ShopeBloc>().add(GetAllBannersEvent());
    context.read<ShopeBloc>().add(GetCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(ProductController());
    return BlocBuilder<ShopeBloc, ShopeState>(
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                HeaderContainer(
                  child: Column(
                    children: [
                      HomeAppBar(),

                      // websocket
                      const SizedBox(height: 15),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const WebsoketPage(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.wifi),
                            label: const Text('Open WebSocket Demo'),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // SizedBox(height: 30),
                      SearchContainer(
                        text: "Search in store",
                        showBorder: false,
                      ),
                      SizedBox(height: 15),

                      Padding(
                        padding: const EdgeInsets.only(left: 24.0),
                        child: Column(
                          children: [
                            SectionHeader(
                              title: "Popular Catagories",
                              ShowActionButton: false,
                              textColor: Colors.white,
                            ),

                            SizedBox(height: 15),

                            HomeCategories(),
                            SizedBox(height: 32),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                /// body part
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      ImageSlider(banners: state.banners),
                      SizedBox(height: 15),

                      SectionHeader(
                        title: "Popular Products",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AllProductsPage(),
                            ),
                          ).then(
                            (_) => {
                              context.read<ShopeBloc>().add(
                                GetAllProductsEvent(limit: 2),
                              ),
                            },
                          );
                        },
                      ),
                      SizedBox(height: 15),
                      GridLayout(
                        itemCount: state.products.length,
                        itemBuilder: (_, index) {
                          final product = state.products[index];
                          return ProductCardVertical(product: product);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
