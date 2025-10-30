import 'package:flutter/material.dart';

class CustomAlterButton extends StatelessWidget {
  final bool isInserting;
  final GlobalKey<FormState> formKey;
  final dynamic entity;
  final String entityName;
  final Future<void> Function() onPressed; // Versão mais simples

  CustomAlterButton({
    super.key,
    required this.isInserting,
    required this.formKey,
    required this.entityName,
    required this.onPressed,
    this.entity,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FilledButton(
            onPressed: () async {
              if(formKey.currentState!.validate() && !isInserting){
                await onPressed(); // Chama a função sem parâmetros
              }
            },
            child: isInserting ? Center(
                child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(color: Colors.white)
                )
            ) : Text("${entity == null ? "Criar" : "Editar"} $entityName"),
          ),
        ),
      ],
    );
  }
}