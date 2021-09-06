import 'package:flutter/material.dart';
import 'package:piece_of_cake/order_model.dart';
import 'package:piece_of_cake/widgets/list/list_widget_controller.dart';
import 'package:piece_of_cake/widgets/list/list_tile_widget.dart';

class ListWidget extends StatefulWidget {
  final ListWidgetController controller;
  ListWidget({Key? key, required this.controller}) : super(key: key);

  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ValueListenableBuilder<List<OrderModel>>(
          valueListenable: widget.controller.ordersNotifier,
          builder: (_, orders, __) => Column(
                children: orders
                    .map((e) => ListTileWidget(
                          order: e,
                          controller: widget.controller
                        ))
                    .toList(),
              )),
    );
  }
}
