import 'package:flutter/material.dart';
import 'package:piggai/component/bottom_navigation_component/item_modal_bottom_component.dart';
import 'package:piggai/page/category_page.dart';

class ModalBottomComponent {
  show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 10,
              children: [
                ItemModalBottomComponent(
                  icon: Icons.attach_money,
                  title: "Receita",
                  description: "Adicione uma entrada de dinheiro",
                ),
                ItemModalBottomComponent(
                  icon: Icons.money_off,
                  title: "Despesa",
                  description: "Registre um gasto",
                ),
                ItemModalBottomComponent(
                  icon: Icons.category,
                  title: "Categoria",
                  description: "Crie uma categoria para organizar",
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context,MaterialPageRoute(builder: (context) => CategoryPage()));
                  }
                ),
                ItemModalBottomComponent(
                  icon: Icons.show_chart,
                  title: "Meta",
                  description: "Crie uma meta e acompanhe seu progresso",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
