import 'dart:ui';
import 'package:flutter/material.dart';

/// 🧊 Classe genérica para exibir um diálogo com fundo borrado
/// e opções personalizadas abaixo de um widget principal.
///
/// Exemplo de uso:
/// ```dart
/// CustomBlurDialog.show(
///   context: context,
///   mainContent: MyWidget(),
///   options: [
///     BlurDialogOption(label: 'Editar', icon: Icons.edit, onTap: () {}),
///     BlurDialogOption(label: 'Excluir', icon: Icons.delete, onTap: () {}),
///   ],
/// );
/// ```
class CustomBlurDialog {
  static void show({
    required BuildContext context,
    required Widget mainContent,
    required List<BlurDialogOption> options,
    double width = 300,
    double blurSigma = 8,
    double scale = 1.05,
    Color backgroundColor = const Color.fromRGBO(0, 0, 0, 0.15),
    Color menuColor = Colors.white,
    double borderRadius = 16,
    Duration transitionDuration = const Duration(milliseconds: 200),
    bool barrierDismissible = true,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: 'blur_dialog',
      barrierColor: backgroundColor,
      transitionDuration: transitionDuration,
      pageBuilder: (context, animation, secondaryAnimation) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 🔹 Fundo borrado
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
                child: Container(color: Colors.transparent),
              ),

              // 🔹 Conteúdo central com animação
              FadeTransition(
                opacity: CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOut,
                ),
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.15),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  )),
                  child: SizedBox(
                    width: width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // 🔸 Widget principal destacado
                        Transform.scale(
                          scale: scale,
                          child: Material(
                            elevation: 8,
                            borderRadius: BorderRadius.circular(borderRadius),
                            clipBehavior: Clip.antiAlias,
                            child: mainContent,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // 🔸 Menu de opções
                        Material(
                          color: menuColor,
                          borderRadius: BorderRadius.circular(borderRadius),
                          elevation: 6,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for (var i = 0; i < options.length; i++) ...[
                                ListTile(
                                  leading: options[i].icon != null
                                      ? Icon(
                                    options[i].icon,
                                    color: options[i].iconColor,
                                  )
                                      : null,
                                  title: Text(
                                    options[i].label,
                                    style: TextStyle(
                                      color: options[i].textColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                    options[i].onTap?.call();
                                  },
                                ),
                                if (i != options.length - 1)
                                  const Divider(height: 0),
                              ]
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// 🔹 Modelo de opção para o menu
class BlurDialogOption {
  final String label;
  final IconData? icon;
  final Color? iconColor;
  final Color? textColor;
  final VoidCallback? onTap;

  BlurDialogOption({
    required this.label,
    this.icon,
    this.iconColor,
    this.textColor,
    this.onTap,
  });
}
