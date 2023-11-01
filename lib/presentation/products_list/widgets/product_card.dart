import 'package:flutter/material.dart';
import 'package:mokataa/utils/style/colors.dart';
import 'package:mokataa/utils/style/text_style.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    this.product,
    this.onReplacement
  });

  final product;
  final Function(String)? onReplacement;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8)
      ),
      elevation: 2,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    if(onReplacement != null) TextButton(
                      onPressed: () {
                        onReplacement?.call(product['alternatives']);
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.arrow_back_ios),
                          Text('شاهد البديل'),
                        ],
                      )
                    ),
                    Expanded(child: Container()),
                    Text(product['name'], style: urbanistSemiBold(color: AppColors.gray25, fontSize: 18), textAlign: TextAlign.end),
                  ],
                ),
                Text(product['description'], style: urbanistRegular(color: AppColors.gray25, fontSize: 16), textAlign: TextAlign.end),
              ],
            ),
          ),
          const SizedBox(width: 6,),
          ClipRRect(
            borderRadius: const BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
            child: Image.network(product['image'], width: 90, height: 90, fit: BoxFit.cover,)
          )
        ],
      ),
    );
  }
}
