import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:piggai/component/category/category_container.dart';
import 'package:piggai/component/category/category_modal_bottom.dart';
import 'package:piggai/component/search_text_form_field.dart';
import 'package:piggai/controller/category_controller.dart';

class CategoryPage extends StatelessWidget {
  final _controller = CategoryController();

  CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categorias"),
        bottom: Tab(
          child: SearchTextFormField(controller: _controller.tecSearch),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          CategoryModalBottom().show(context,_controller);
        },
        icon: const Icon(Icons.add),
        label: const Text(
          "Criar categoria",
        ),
      ),
      body: FutureBuilder(
        future: _controller.initialize(context),
        builder: (context,snapshot) {
          return Observer(
            builder: (context) {
              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 80),
                itemCount: _controller.categoriesFiltered.length,
                itemBuilder: (context, index) {
                  final category = _controller.categoriesFiltered[index];
                  return CategoryContainer(
                    category: category,
                    controller: _controller,
                    enableLongPress: true,
                    enableSwipeActions: true,
                    showDeleteAction: true,
                    showEditAction: true,
                  );
                },
              );
            }
          );
        }
      ),
    );
  }
}
