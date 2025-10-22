import 'package:flutter/material.dart';
import 'package:piggai/component/bottom_navigation_component/item_modal_bottom_component.dart';

class ModalBottomComponent {
  show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true, // mantém acima da BottomNavigationBar
      backgroundColor: Colors.white,
      isScrollControlled: true, // importante para SafeArea funcionar corretamente
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 10,
              children: const [
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
