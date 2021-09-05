import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        title: Text("Adicionar Pedido"),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          child: Column(children: [
            Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Título do Pedido',
                        hintText: 'Ex: Bolo de Morango'),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Duração do trabalho',
                        hintText: 'Ex: 01h00m'),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Data da entrega',
                        hintText: 'Ex: dd/mm/aaaa'),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Horário de Entrega',
                        hintText: 'Ex: 18h30m'),
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 25),
                child: Row(
                  children: [
                    Expanded(
                        child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancelar"),
                      style: TextButton.styleFrom(
                        side: BorderSide(color: Colors.blue),
                      ),
                    )),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                    ),
                    Expanded(
                        child: TextButton(
                            onPressed: () {},
                            child: Text("Enviar",
                                style: TextStyle(color: Colors.white)),
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.blue))),
                  ],
                ))
          ])),
    );
  }
}
