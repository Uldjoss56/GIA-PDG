import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/models/orders.dart';

class OrdersMeNotifier extends StateNotifier<OrderMeData> {
  OrdersMeNotifier(super.orderDatas);

  void updateOrderData(OrderMeData orderDatas) {
    state = orderDatas;
  }
}

final orderMeDataProvider =
    StateNotifierProvider<OrdersMeNotifier, OrderMeData>(
  (ref) => OrdersMeNotifier(
    OrderMeData(),
  ),
);

class OrdersNotifier extends StateNotifier<OrderData> {
  OrdersNotifier(super.orderDatas);

  void updateOrderData(OrderData orderDatas) {
    state = orderDatas;
  }
}

final orderDataProvider = StateNotifierProvider<OrdersNotifier, OrderData>(
  (ref) => OrdersNotifier(
    OrderData(),
  ),
);
