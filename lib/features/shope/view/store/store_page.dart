import 'package:ecommerce_frontend/core/util/common/widgets/custom_appbar.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/section_header.dart';
import 'package:ecommerce_frontend/data/model/brand.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_event.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_state.dart';
import 'package:ecommerce_frontend/features/shope/view/brand/all_brands_page.dart';
import 'package:ecommerce_frontend/features/shope/view/brand/brand_products.dart';
import 'package:ecommerce_frontend/features/shope/view/home/widget/grid_layout.dart';
import 'package:ecommerce_frontend/features/shope/view/home/widget/search_Container.dart';
import 'package:ecommerce_frontend/features/shope/view/store/widget/brand_card.dart';
import 'package:ecommerce_frontend/features/shope/view/store/widget/catagory_tab.dart';
import 'package:ecommerce_frontend/features/shope/view/store/widget/custom_tabBar.dart';
import 'package:ecommerce_frontend/features/shope/widgets/cart_counter_icon.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/shope_bloc.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  void initState() {
    super.initState();

    context.read<ShopeBloc>().add(GetAllCategoriesEvent());
    context.read<ShopeBloc>().add(GetAllBrandsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopeBloc, ShopeState>(
      builder: (context, state) {
        final cartCount = state.cart?.totalItems ?? 0;

        return DefaultTabController(
          length: state.categories.length,
          child: Scaffold(
            // appbar
            appBar: CustomAppbar(
              title: Text(
                "Store",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: CartCounterIcon(
                    count: cartCount,
                    iconColor: Colors.black,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            // header
            body: NestedScrollView(
              headerSliverBuilder: (_, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: true,
                    floating: true,
                    backgroundColor: Colors.white,
                    expandedHeight: 440,
                    flexibleSpace: Padding(
                      padding: EdgeInsets.all(24),
                      child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          // search bar
                          SizedBox(height: 16),
                          SearchContainer(
                            text: "search in store",
                            showBorder: true,
                            showBackground: true,
                            padding: EdgeInsets.zero,
                          ),
                          SizedBox(height: 24),

                          SectionHeader(
                            title: "Featured Brands",
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AllBrandsPage(),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 24),

                          GridLayout(
                            mainAxisExtent: 80,
                            itemCount: 4,
                            itemBuilder: (_, index) {
                              final brand = state.brands[index];
                              return BrandCard(
                                showBorder: true,
                                brand: brand,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => BrandProducts(
                                        brand: brand,
                                        title: brand.name,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    bottom: CustomTabBar(
                      tabs: state.categories.map((category) {
                        return Tab(child: Text(category.name));
                      }).toList(),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                children: state.categories.map((Category) {
                  return CatagoryTab(category: Category, brands: state.brands);
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
