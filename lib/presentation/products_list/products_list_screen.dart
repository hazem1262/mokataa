import 'package:flutter/material.dart';
import 'package:mokataa/data/products/products_service.dart';
import 'package:mokataa/presentation/products_list/widgets/allowed.dart';
import 'package:mokataa/presentation/products_list/widgets/disallowed.dart';
import 'package:mokataa/presentation/replacements/replacements_screen.dart';
import 'package:mokataa/utils/force_update.dart';
import 'package:mokataa/utils/style/colors.dart';
import 'package:mokataa/utils/style/text_style.dart';

class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({super.key});
  static const tag = 'ProductsListScreen';
  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> with SingleTickerProviderStateMixin {
  final productsService = ProductsService();
  late TabController _tabController;
  List? products;
  List? filteredProducts;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Future.delayed(Duration.zero, () {
      setState(() {
        _tabController.animateTo(1);
      });
    });
    productsService.getProducts().then((value) {
      setState(() {
        products = value;
        filteredProducts = products;
      });
      _textController.addListener(() {
        setState(() {
          filteredProducts = products?.where((element) => element['name'].toString().toLowerCase().contains(_textController.text.toLowerCase())).toList();
        });
      });
    });
    showForceUpdateIfNeeded();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: filteredProducts == null ?
        const Center(child: CircularProgressIndicator()) :
        SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.coolMint.withOpacity(.25)
                  ),
                  child: TabBar(
                    unselectedLabelColor: AppColors.graniteGray,
                    indicatorColor: AppColors.coolMint,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.coolMint
                    ),
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'علينا'),
                      Tab(text: 'معانا'),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('ابحث عن منتج', style: urbanistSemiBold(color: AppColors.gray25, fontSize: 14), textAlign: TextAlign.end),
                )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  textAlign: TextAlign.end,
                  textDirection: TextDirection.rtl,
                  controller: _textController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.coolMint),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    hintText: 'أدخل اسم المنتج',
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    DisallowedProduct(
                      disallowedProducts: filteredProducts!.where((element) => element['type'] == 'disallowed').toList(),
                      onReplacement: (alternatives) {
                        final alternativesListIds = alternatives.split(',');
                        debugPrint('alternativesListIds:$alternativesListIds');
                        debugPrint('products:$products');
                        final alternativesList = products?.where((element) => alternativesListIds.contains(element['id'].toString())).toList();
                        debugPrint('alternativesList:$alternativesList');
                        Navigator.of(context).pushNamed(ReplacementScreen.tag, arguments: alternativesList??[]);
                      },
                    ),
                    AllowedProduct(allowedProducts: filteredProducts!.where((element) => element['type'] == 'allowed').toList()),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}