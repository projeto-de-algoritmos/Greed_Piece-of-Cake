import 'package:flutter/material.dart';
import 'package:piece_of_cake/widgets/list/list_widget.dart';
import 'package:piece_of_cake/widgets/list/list_widget_controller.dart';
import '../add/add_screen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final controller = ListWidgetController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Piece of Cake"),
        centerTitle: true,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              "Lista de encomendas",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        //Aqui entra a lista de encomentdas
        ListWidget(
          controller: controller,
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddScreen()));
        },
      ),
    );
  }
}
