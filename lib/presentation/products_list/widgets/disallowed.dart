import 'package:flutter/material.dart';
import 'package:mokataa/presentation/products_list/widgets/product_card.dart';

class DisallowedProduct extends StatelessWidget {
  const DisallowedProduct({
    super.key,
    required this.disallowedProducts,
    required this.onReplacement
  });
  final List disallowedProducts;
  final Function(String) onReplacement;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: disallowedProducts.length,
        itemBuilder: (cts, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ProductCard(
              product: disallowedProducts[index],
              onReplacement: onReplacement
            ),
          );
        }
    );
  }
}
