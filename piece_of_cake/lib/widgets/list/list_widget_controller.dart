import 'package:flutter/material.dart';
import 'package:piece_of_cake/order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListWidgetController {
  final ordersNotifier = ValueNotifier<List<OrderModel>>(<OrderModel>[]);
  List<OrderModel> get orders => ordersNotifier.value;
  set orders(List<OrderModel> value) {
    ordersNotifier.value = value;
  }

  ListWidgetController() {
    getOrders();
  }

  Future<void> getOrders() async {
    try {
      final instance = await SharedPreferences.getInstance();
      final response = instance.getStringList("orders") ?? <String>[];

      orders = response.map((e) => OrderModel.fromJson(e)).toList();
      print(orders);
    } catch (e) {
      orders = <OrderModel>[];
    }
  }
}
