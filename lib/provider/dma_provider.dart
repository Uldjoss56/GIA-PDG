import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/models/orders.dart';

class OrdersNotifier extends StateNotifier<OrderData> {
  OrdersNotifier(OrderData orderData) : super(orderData);

  void updateOrderData(OrderData orderData) {
    state = orderData;
  }
}

final orderDataProvider = StateNotifierProvider<OrdersNotifier, OrderData>(
  (ref) => OrdersNotifier(
    OrderData(),
  ),
);
