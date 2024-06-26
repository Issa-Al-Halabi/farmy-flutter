import 'package:flutter/cupertino.dart';

import 'package:pharma/presentation/resources/color_manager.dart';
import 'package:pharma/presentation/widgets/custom_prdouct_card.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/product_response.dart';

class CustomProductShimmer extends StatelessWidget {
  const CustomProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      itemCount: 4,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 26,
          mainAxisExtent: 227),
      itemBuilder: (context, index) {
        return Center(
            child: Shimmer.fromColors(
          baseColor: ColorManager.grayForPlaceholder,
          highlightColor: const Color(0xFFe2e4e9),
          child: CustomProductCard(
              productInfo: ProductResponse(
                  availabilityOfProduct: "",
                  discount: "",
                  nameOfProduct: "",
                  price: "",
                  quantity: 0,
                  sellerName: "", id: 0,
              ),),
        ));
      },
    );
  }
}
