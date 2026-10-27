import 'package:ecommerce_frontend/core/service/toast_service.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/circular_icon.dart';
import 'package:ecommerce_frontend/data/model/product_model.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_bloc.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_event.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteIcon extends StatelessWidget {
  final Product product;
  const FavoriteIcon({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopeBloc, ShopeState>(
      buildWhen: (previous, current) => previous.wishlist != current.wishlist,
      builder: (context, state) {
        final bloc = context.read<ShopeBloc>();

        final isFavorite = state.wishlist.any((e) => e.id == product.id);
        return CirculatIcon(
          icon: isFavorite ? Icons.favorite : Icons.favorite_border,
          backgroundColor: Colors.white,
          iconColor: Colors.red,
          onPressed: () {
            bloc.add(
              isFavorite
                  ? RemoveWishlistEvent(product.id)
                  : AddWishlistEvent(product.id),
            );
          },
        );
      },
    );
  }
}
