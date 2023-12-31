import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mokataa/presentation/products_list/products_list_screen.dart';
import 'package:mokataa/presentation/replacements/replacements_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('ar'),
      debugShowCheckedModeBanner: false,
      title: 'Mokataa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: navigationKey,
      initialRoute: ProductsListScreen.tag,
      routes: {
        ProductsListScreen.tag : (ctx) => const ProductsListScreen(),
        ReplacementScreen.tag : (ctx) => const ReplacementScreen()
      },
    );
  }
}
final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
