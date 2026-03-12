import 'package:ecommerce_frontend/core/util/common/widgets/circular_image_text.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/image_slider.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/product_card_vertical.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/section_header.dart';
import 'package:ecommerce_frontend/features/shope/view/all-products/all_products_page.dart';
import 'package:ecommerce_frontend/features/shope/view/home/widget/grid_layout.dart';
import 'package:ecommerce_frontend/features/shope/view/sub_catagory/sub_catagory_page.dart';
import 'package:ecommerce_frontend/features/shope/widgets/header_container.dart';
import 'package:ecommerce_frontend/features/shope/view/home/widget/home_app_bar.dart';
import 'package:ecommerce_frontend/features/shope/view/home/widget/search_Container.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderContainer(
              child: Column(
                children: [
                  HomeAppBar(),

                  SizedBox(height: 30),

                  SearchContainer(text: "Search in store"),
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

                        SizedBox(
                          height: 80,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 6,
                            itemBuilder: (_, index) {
                              return CircularImageText(
                                image: "assets/icons/esh.png",
                                title: 'shoes',
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SubCatagoryPage()));
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 32,)
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
                  ImageSlider(
                    banners: [
                      'assets/images/onbording/esh2.jpg',
                      'assets/images/onbording/eb.jpg',
                      'assets/images/onbording/e3.jpg',
                    ],
                  ),
                  SizedBox(height: 15,),

                  SectionHeader(title: "Popular Products",onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AllProductsPage()));
                  },),
                SizedBox(height: 15,),
             GridLayout(itemCount: 2,itemBuilder: (_,index)=> ProductCardVertical(),)
           
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

