import 'package:flutter/material.dart';
import 'package:piece_of_cake/order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddController {
  OrderModel model = OrderModel();
  final formKey = GlobalKey<FormState>();

  String? validateName(String? value) =>
      value?.isEmpty ?? true ? "O nome não pode ser vazio" : null;

  String? validateDuration(String? value) {
    if (value == null) return "O nome não pode ser vazio";

    if (value.isEmpty)
      return "O nome não pode ser vazio";
    else {
      List<String> lst = value.split(":");
      // if (int.parse(lst[0]) > 23 || int.parse(lst[0]) < 0)
      // return "Insira uma hora entre 00 e 23";
      if (int.parse(lst[1]) > 59 || int.parse(lst[1]) < 0)
        return "Insira um minuto entre 00 e 59";
    }
  }

  String? validateDeadlineDate(String? value) {
    if (value == null) return "O nome não pode ser vazio";

    if (value.isEmpty)
      return "O nome não pode ser vazio";
    else {
      List<dynamic> lst = value.split(" ");
      List date = lst[0].split("/");
      List time = lst[1].split(":");

      date = date.map((e) => int.parse(e)).toList();
      time = time.map((e) => int.parse(e)).toList();

      int c_year = DateTime.now().year;
      int c_month = DateTime.now().month;
      int c_day = DateTime.now().day;
      int c_hour = DateTime.now().hour;
      int c_minute = DateTime.now().minute;

      if (date[0] > 31 || date[0] < 1) return "Insira um dia entre 01 e 31";
      // if (date[1] > 12 || date[1] < 1) return "Insira um mês entre 01 e 12";

      if (time[0] > 23 || time[0] < 0) return "Insira uma hora entre 23 e 00";
      if (time[1] > 59 || time[1] < 0) return "Insira um minuto entre 59 e 00";

      if (date[2] < c_year)
        return "Insira um ano igual ou maior a ${c_year}";
      else if (date[2] == c_year) {
        if (date[1] < c_month)
          return "Insira um ano igual ou maior a ${c_month}";
        else if (date[1] == c_month) {
          if (date[0] < c_day)
            return "Insira um dia igual ou maior a ${c_day}";
          else if (date[0] == c_day) {
            if (time[0] < c_hour)
              return "Insira uma hora igual ou maior a ${c_hour}";
            else if (time[0] == c_hour) if (time[1] < c_minute)
              return "Insira um minute igual ou maior a ${c_minute}";
          }
        }
      }
    }
  }

// 1234567890123456
// 00/00/0000 00:00

  void onChanged({String? name, String? duration, String? deadline}) {
    // if (deadline != null && deadline.length == 16) {
    //   List<dynamic> lst = deadline.split(" ");
    //   List date = lst[0].split("/");
    //   List time = lst[1].split(":");

    //   // ano/mes/dia/hora/min

    //   deadline = '${date.join()}${time.join()}';
    //   print('TESTE: ${deadline}');
    // }
    model = model.copyWith(
      name: name,
      duration: duration,
      deadline: deadline,
    );
  }

  Future<void> saveOrder() async {
    final instance = await SharedPreferences.getInstance();

    final orders = instance.getStringList("orders") ?? <String>[];
    orders.add(model.toJson());
    print("passou");
    print('SAVE: ${orders.length}');
    await instance.setStringList("orders", orders);
    return;
  }

  Future<void> registerOrder() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      return await saveOrder();
    }
  }
}
