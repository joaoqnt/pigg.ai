import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:piggai/component/category/category_container.dart';
import 'package:piggai/component/category/category_modal_bottom.dart';
import 'package:piggai/component/custom/button/custom_small_add_button.dart';
import 'package:piggai/component/custom/search_text_form_field.dart';
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SearchTextFormField(controller: _controller.tecSearch),
          ),
        ),
        actions: [
          CustomSmallAddButton(
              onTap: () => CategoryModalBottom().show(context,_controller)
          )
        ],
      ),
      body: FutureBuilder(
        future: _controller.initialize(context),
        builder: (context,snapshot) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Observer(
              builder: (context) {
                return ListView.builder(
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
            ),
          );
        }
      ),
    );
  }
}
