import 'package:flutter/material.dart';
import 'package:piggai/component/category/category_modal_bottom.dart';
import 'package:piggai/controller/category_controller.dart';
import 'package:piggai/model/category_model.dart';
import 'package:piggai/util/color_util.dart';

class CategoryContainer extends StatelessWidget {
  final CategoryModel category;
  final CategoryController controller;

  const CategoryContainer({
    super.key,
    required this.category,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {

        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: ColorUtil().formatColor(category.color),
                child: Icon(
                  Icons.category,
                  color: ColorUtil().darken(
                      ColorUtil().formatColor(category.color),
                      0.25
                  ),
                  size: 30,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔹 Nome + Menu ⋮ alinhados na mesma linha
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            category.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        PopupMenuButton<String>(
                          icon: Icon(
                            Icons.more_vert,
                            color: Colors.grey,
                            size: 20,
                          ),
                          onSelected: (value) {
                            if (value == 'edit') {
                              CategoryModalBottom().show(context, controller,category: category);
                            } else if (value == 'delete') {
                              // ação de excluir
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'edit',
                              child: Text('Editar nome',
                                // style: TextStyle(
                                //     fontWeight: FontWeight.normal
                                // ),
                              ),
                            ),
                            PopupMenuItem(
                              value: 'delete',
                              child: Text('Excluir item',
                                  // style: TextStyle(
                                  //     fontWeight: FontWeight.normal
                                  // )
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      category.type == 'income' ? 'Receita' : 'Despesa',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
