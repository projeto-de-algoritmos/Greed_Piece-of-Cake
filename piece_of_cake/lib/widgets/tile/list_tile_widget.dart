import 'package:flutter/material.dart';
import 'package:piece_of_cake/order_model.dart';

class ListTileWidget extends StatefulWidget {
  final OrderModel order;
  ListTileWidget({Key? key, required this.order}) : super(key: key);

  @override
  _ListTileWidgetState createState() => _ListTileWidgetState();
}

class _ListTileWidgetState extends State<ListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(widget.order.name!),
        subtitle: Text(widget.order.deadline!),
        trailing: Text(widget.order.duration!),
        //leading: Text(widget.order.duration!), indice
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