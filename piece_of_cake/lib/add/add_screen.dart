import 'package:flutter/material.dart';
import 'package:piece_of_cake/add/add_controller.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:piece_of_cake/list/list_screen.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final controller = AddController();

  final dateInputController = MaskedTextController(mask: "00/00/0000 00:00");
  final durationInputController = MaskedTextController(mask: "00:00");

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
              key: controller.formKey,
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (value) {
                      controller.onChanged(name: value);
                    },
                    validator: controller.validateName,
                    decoration: InputDecoration(
                        labelText: 'Título do Pedido',
                        hintText: 'Ex: Bolo de Morango'),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      controller.onChanged(duration: value);
                    },
                    controller: durationInputController,
                    validator: controller.validateDuration,
                    keyboardType: TextInputType.number,
                    maxLength: 5,
                    decoration: InputDecoration(
                        labelText: 'Duração do trabalho',
                        hintText: 'Ex: hh:mm'),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      controller.onChanged(deadline: value);
                    },
                    controller: dateInputController,
                    validator: controller.validateDeadlineDate,
                    keyboardType: TextInputType.number,
                    maxLength: 16,
                    decoration: InputDecoration(
                        labelText: 'Data da entrega',
                        hintText: 'Ex: dd/mm/aaaa hh:mm'),
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
                            onPressed: () async {
                              bool valid = await controller.registerOrder();
                              if(valid)
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => ListScreen()),
                                  (Route<dynamic> route) => false);
                            },
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
