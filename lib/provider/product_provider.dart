import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/models/product.dart';

class ProductNotifier extends StateNotifier<List<Product>> {
  ProductNotifier(super.products);

  void updateListProduct(List<Product> products) {
    state = products;
  }
}

final productsProvider = StateNotifierProvider<ProductNotifier, List<Product>>(
  (ref) => ProductNotifier(
    List.empty(),
  ),
);
