import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'custom_slide_action.dart';

class CustomSlidableActions {
  static ActionPane build({
    required BuildContext context,
    bool useDuplicate = false,
    bool useEdit = false,
    bool useDelete = false,
    VoidCallback? onDuplicate,
    VoidCallback? onEdit,
    VoidCallback? onDelete,
    List<CustomSlideAction> actions = const [],
    double extentRatio = 0.6,
  }) {
    final theme = Theme.of(context).colorScheme;

    final List<SlidableAction> panes = [];

    if (useDuplicate && onDuplicate != null) {
      panes.add(
        SlidableAction(
          onPressed: (_) => onDuplicate(),
          backgroundColor: theme.tertiaryContainer,
          foregroundColor: theme.onTertiaryContainer,
          icon: Icons.copy,
          label: 'Copiar',
        ),
      );
    }

    if (useEdit && onEdit != null) {
      panes.add(
        SlidableAction(
          onPressed: (_) => onEdit(),
          backgroundColor: theme.secondaryContainer,
          foregroundColor: theme.onSecondaryContainer,
          icon: Icons.edit_outlined,
          label: 'Editar',
        ),
      );
    }

    if (useDelete && onDelete != null) {
      panes.add(
        SlidableAction(
          onPressed: (_) => onDelete(),
          backgroundColor: theme.error,
          foregroundColor: theme.onError,
          icon: Icons.delete_outline,
          label: 'Excluir',
        ),
      );
    }

    panes.addAll(
      actions.map(
            (a) => SlidableAction(
          onPressed: (_) => a.onPressed(),
          backgroundColor: a.backgroundColor,
          foregroundColor: a.foregroundColor,
          icon: a.icon,
          label: a.label,
        ),
      ),
    );

    return ActionPane(
      motion: const ScrollMotion(),
      extentRatio: extentRatio,
      children: panes,
    );
  }
}
