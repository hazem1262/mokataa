import 'package:flutter/material.dart';
import 'package:mokataa/presentation/products_list/widgets/allowed.dart';

class ReplacementScreen extends StatelessWidget {
  const ReplacementScreen({super.key});
  static const tag = 'ReplacementScreen';

  @override
  Widget build(BuildContext context) {
    final alternativesList = ModalRoute.of(context)?.settings.arguments as List;
    return Scaffold(
      body: AllowedProduct(
        allowedProducts: alternativesList,
      )
    );
  }
}
