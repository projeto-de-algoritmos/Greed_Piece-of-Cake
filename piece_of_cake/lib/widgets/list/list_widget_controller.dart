import 'package:flutter/material.dart';
import 'package:piece_of_cake/order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListWidgetController {
  int maxLateness = 0;
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

      schedulingToMinimaze(orders);
    } catch (e) {
      orders = <OrderModel>[];
    }
  }

  Future<void> removeOrder(OrderModel order) async {
    try {
      orders.removeWhere((element) => element == order);
      final instance = await SharedPreferences.getInstance();
      List<String> strOrders = orders.map((e) => e.toJson()).toList();
      await instance.setStringList("orders", strOrders);
    } catch (e) {
      return;
    }
  }

  DateTime formatToDate(String data) {
    var lst = data.split(" ");
    List date = lst[0].split("/");
    List time = lst[1].split(":");

    var temp = date[0];
    date[0] = date[2];
    date[2] = temp;
    data = date.join("-") + " " + time.join(":");
    return DateTime.parse(data);
  }

  String formatToString(DateTime data) {
    List lst = data.toString().split(" ");
    List date = lst[0].split("-");
    List time = lst[1].split(":");
    time.removeLast();

    var temp = date[0];
    date[0] = date[2];
    date[2] = temp;

    return date.join("/") + " " + time.join(":");
  }

  int formatToInt(String data) {
    var lst = data.split(" ");
    List date = lst[0].split("/");
    List time = lst[1].split(":");

    var temp = date[0];
    date[0] = date[2];
    date[2] = temp;
    data = date.join() + time.join();

    return int.parse(data);
  }

  void schedulingToMinimaze(List<OrderModel> lstOrders) {
    List lstInt = [];
    List<DateTime> lstDeadlineDate = [];
    for (int i = 0; i < lstOrders.length; i++) {
      lstInt.add(formatToInt(lstOrders[i].deadline!));
    }

    for (int i = 0; i < lstOrders.length; i++) {
      var done = true;
      for (int i = 1; i < lstOrders.length; i++) {
        if (lstInt[i - 1] > lstInt[i]) {
          var temp = lstInt[i];
          lstInt[i] = lstInt[i - 1];
          lstInt[i - 1] = temp;

          temp = lstOrders[i];
          lstOrders[i] = lstOrders[i - 1];
          lstOrders[i - 1] = temp;

          done = false;
        }
      }
      if (done == true)
        break;
      else
        done = true;
    }

    for (int i = 0; i < lstOrders.length; i++) {
      lstDeadlineDate.add(formatToDate(lstOrders[i].deadline!));
    }

    var temp = lstOrders[0].duration!.split(":");
    int durationMinutes = int.parse(temp[0]) * 60 + int.parse(temp[1]);

    DateTime newStart = DateTime.now();
    DateTime newEnd = newStart.add(Duration(minutes: durationMinutes));
    Duration newLateness = lstDeadlineDate[0].difference(newEnd);

    List lst = newLateness.toString().split(":");
    lst.removeLast();
    String strNewLateness = lst.join(":");

    lstOrders[0] = lstOrders[0].copyWith(
      start: formatToString(newStart),
      end: formatToString(newEnd),
      lateness: strNewLateness.toString(),
    );

    Duration durMaxLateness = newLateness;
    if (durMaxLateness.isNegative)
      maxLateness = 0;
    else
      maxLateness = -1;

    for (int i = 1; i < lstOrders.length; i++) {
      temp = lstOrders[i].duration!.split(":");
      durationMinutes = int.parse(temp[0]) * 60 + int.parse(temp[1]);

      newStart = formatToDate(lstOrders[i - 1].end!);
      newEnd = newStart.add(Duration(minutes: durationMinutes));
      newLateness = lstDeadlineDate[i].difference(newEnd);

      if (durMaxLateness > newLateness && newLateness.isNegative) {
        durMaxLateness = newLateness;
        maxLateness = i;
      }

      List lst = newLateness.toString().split(":");
      lst.removeLast();
      String strNewLateness = lst.join(":");

      lstOrders[i] = lstOrders[i].copyWith(
        start: formatToString(newStart),
        end: formatToString(newEnd),
        lateness: strNewLateness.toString(),
      );
    }

    if (maxLateness != -1) {
      lstOrders[maxLateness] = lstOrders[maxLateness].copyWith(
        isMaxLatness: true,
      );
    }
  }
}
