import 'package:flutter/material.dart';
import 'package:piggai/component/category/category_container.dart';
import 'package:piggai/controller/transaction_controller.dart';

class CategoryBottomSheetToTransaction{
  void show(BuildContext context, TransactionController controller, String type) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        // Lista de categorias padrão - você pode substituir pelas suas
        final categories = controller.categories.where((element) => element.type == type).toList();

        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Selecionar categoria",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, size: 20),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return CategoryContainer(category: category);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}