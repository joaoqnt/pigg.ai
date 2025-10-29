import 'dart:ui';
import 'package:flutter/material.dart';

class CustomDeleteDialog {
  static Future<bool?> show(
      BuildContext context, {
        String title = 'Remover este item?',
        String message = 'O item será removido permanentemente, incluindo todos os dados relacionados.'
            '\n'
            'Você não poderá desfazer esta ação.',
        String cancelText = 'Cancelar',
        String confirmText = 'Excluir',
        Color confirmColor = Colors.redAccent,
        Function()? onPressed,
      }) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              width: 300,
              child: Column(
                spacing: 10,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title,style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(message),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: colorScheme.tertiaryContainer),
                          top: BorderSide(color: colorScheme.tertiaryContainer),
                      )
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextButton(
                              onPressed: onPressed,
                              child: Text(confirmText,
                                style: TextStyle(
                                    color: confirmColor,
                                    fontWeight: FontWeight.bold
                                )
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: colorScheme.tertiaryContainer)
                        )
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(cancelText,
                                style: TextStyle(color: colorScheme.onTertiaryContainer)
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
    );
  }
}
