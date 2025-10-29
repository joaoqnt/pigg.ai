import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:piggai/component/category/category_modal_bottom.dart';
import 'package:piggai/component/custom_blur_dialog.dart';
import 'package:piggai/component/custom_container.dart';
import 'package:piggai/component/dialog/custom_delete_dialog.dart';
import 'package:piggai/controller/category_controller.dart';
import 'package:piggai/model/category_model.dart';
import 'package:piggai/util/color_util.dart';

class CategoryContainer extends StatelessWidget {
  final CategoryModel category;
  final CategoryController? controller;
  final bool enableSwipeActions;
  final bool enableLongPress;
  final VoidCallback? onTap;
  final bool showEditAction;
  final bool showDeleteAction;

  const CategoryContainer({
    super.key,
    required this.category,
    this.controller,
    this.enableSwipeActions = false,
    this.enableLongPress = false,
    this.onTap,
    this.showEditAction = true,
    this.showDeleteAction = true,
  });

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (context) {
          // Widget base do container
          Widget container = InkWell(
            onTap: onTap,
            onLongPress: enableLongPress ? () => _showLongPressDialog(context) : null,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                children: [
                  CustomContainer(
                    backgroundColor: ColorUtil().formatColor(category.color),
                    iconColor: ColorUtil().darken(ColorUtil().formatColor(category.color), 0.3),
                    isLoading: controller?.isDeleting[category],
                    iconData: Icons.category_outlined,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
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
          );

          // Adiciona ações de swipe se habilitado
          if (enableSwipeActions) {
            return Slidable(
              key: ValueKey(category.id),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                extentRatio: 0.4,
                children: _buildSwipeActions(context),
              ),
              child: container,
            );
          }

          return container;
        }
    );
  }

  List<Widget> _buildSwipeActions(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final actions = <Widget>[];

    if (showEditAction) {
      actions.add(
        SlidableAction(
          onPressed: (_) => _editCategory(context),
          backgroundColor: colorScheme.tertiaryContainer,
          foregroundColor: colorScheme.onTertiaryContainer,
          icon: Icons.edit_outlined,
          label: "Editar",
        ),
      );
    }

    if (showDeleteAction) {
      actions.add(
        SlidableAction(
          onPressed: (_) async => _deleteCategory(context),
          backgroundColor: colorScheme.errorContainer,
          foregroundColor: colorScheme.onErrorContainer,
          icon: Icons.delete_outlined,
          label: "Excluir",
        ),
      );
    }

    return actions;
  }


  void _showLongPressDialog(BuildContext context) {
    final options = <BlurDialogOption>[];

    if (showEditAction) {
      options.add(
        BlurDialogOption(
          label: 'Editar',
          icon: Icons.edit,
          onTap: () {
            _editCategory(context);
          },
        ),
      );
    }

    if (showDeleteAction) {
      options.add(
        BlurDialogOption(
          label: 'Excluir',
          icon: Icons.delete,
          iconColor: Colors.redAccent,
          textColor: Colors.redAccent,
          fontWeight: FontWeight.bold,
          onTap: () {
            _deleteCategory(context);
          },
        ),
      );
    }

    if (options.isNotEmpty) {
      CustomBlurDialog.show(
        context: context,
        mainContent: CategoryContainer(
          category: category,
          controller: controller,
          enableSwipeActions: false,
          enableLongPress: false,
        ),
        options: options,
      );
    }
  }

  void _editCategory(BuildContext context) {
    CategoryModalBottom().show(context, controller!, category: category);
  }

  void _deleteCategory(BuildContext context) {
    CustomDeleteDialog.show(
      context,
      onPressed: () {
        Navigator.pop(context);
        controller?.alterCategory(category: category, isDelete: true);
      },
    );
  }
}