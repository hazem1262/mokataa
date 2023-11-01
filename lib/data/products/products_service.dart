import 'package:firebase_database/firebase_database.dart';

class ProductsService {
  Future<dynamic> getProducts() async {
    final database = FirebaseDatabase.instance;
    DatabaseReference productsReference = database.ref('items');
     return (await productsReference.get()).value;
  }
}