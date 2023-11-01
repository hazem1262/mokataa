import 'package:flutter/material.dart';
import 'package:mokataa/presentation/products_list/widgets/product_card.dart';

class AllowedProduct extends StatelessWidget {
  const AllowedProduct({super.key, required this.allowedProducts});
  final List allowedProducts;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: allowedProducts.length,
        itemBuilder: (cts, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ProductCard(product: allowedProducts[index]),
          );
        }
    );
  }
}
