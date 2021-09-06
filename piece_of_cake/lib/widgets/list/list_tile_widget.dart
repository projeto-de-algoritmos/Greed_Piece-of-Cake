import 'package:flutter/material.dart';
import 'package:piece_of_cake/order_model.dart';
import 'package:piece_of_cake/widgets/list/list_widget_controller.dart';

class ListTileWidget extends StatefulWidget {
  final OrderModel order;
  final ListWidgetController controller;
  ListTileWidget({Key? key, required this.order, required this.controller})
      : super(key: key);

  @override
  _ListTileWidgetState createState() => _ListTileWidgetState();
}

class _ListTileWidgetState extends State<ListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.horizontal,
            background: Container(
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.delete,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            onDismissed: (direction) async {
              await widget.controller.removeOrder(widget.order);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    Text(
                      '${widget.order.name}',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                duration: Duration(seconds: 1),
              ));
              await widget.controller.getOrders();
            },
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(widget.order.name!),
              subtitle: Text('Atraso: ${widget.order.lateness!}'),
              trailing: Text(
                  'Inicio: ${widget.order.start!}\nFim: ${widget.order.end}'),
            ),
          ),
          Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }
}

/*
Indice (opcional)
Nome
Inicio - Fim
Atraso
*/