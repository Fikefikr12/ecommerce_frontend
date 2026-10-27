import 'package:ecommerce_frontend/core/util/common/widgets/circular_image_text.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_bloc.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_state.dart';
import 'package:ecommerce_frontend/features/shope/view/sub_catagory/sub_catagory_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopeBloc, ShopeState>(
      builder: (context, state) {
        return SizedBox(
          height: 80,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: state.categories.length,
            itemBuilder: (_, index) {
              final category = state.categories[index];
              return CircularImageText(
                image: category.image.isNotEmpty
                    ? category.image.first
                    : "assets/icons/esh.png",
                title: category.name,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SubCatagoryPage(
                        products: state.products,
                        title: category.name,
                        image: category.image.isNotEmpty
                            ? category.image.first
                            : "assets/icons/esh.png",
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
