import 'package:flutter/widgets.dart';

// -------------------------------------------------------------------------
// 1. Definição dos Breakpoints (Tamanhos de Tela)
// -------------------------------------------------------------------------

const double kMobileBreakpoint = 600.0;
const double kTabletBreakpoint = 1024.0;


// -------------------------------------------------------------------------
// 2. Classe Responsive
// -------------------------------------------------------------------------

/// Utilitário que fornece informações de responsividade (largura, altura e tipo de dispositivo).
class Responsive {

  // Construtor privado para evitar instanciação, já que é uma classe utilitária estática.
  const Responsive._();

  // ----------------------------------------------------------
  // Métodos de Acesso a Dimensões
  // ----------------------------------------------------------

  /// Retorna a largura total da tela.
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Retorna a altura total da tela.
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  // ----------------------------------------------------------
  // Métodos Utilitários de Sizing
  // ----------------------------------------------------------

  /// Retorna uma porcentagem da largura da tela.
  /// Exemplo: `Responsive.width(context, 0.5)` retorna 50% da largura.
  static double width(BuildContext context, double percentage) {
    return screenWidth(context) * percentage;
  }

  /// Retorna uma porcentagem da altura da tela.
  /// Exemplo: `Responsive.height(context, 0.25)` retorna 25% da altura.
  static double height(BuildContext context, double percentage) {
    return screenHeight(context) * percentage;
  }

  // ----------------------------------------------------------
  // Métodos de Verificação de Tipo de Dispositivo
  // ----------------------------------------------------------

  /// Retorna TRUE se a largura da tela for menor que 600px.
  static bool isMobile(BuildContext context) {
    return screenWidth(context) < kMobileBreakpoint;
  }

  /// Retorna TRUE se a largura da tela estiver entre 600px e 1024px.
  static bool isTablet(BuildContext context) {
    final width = screenWidth(context);
    return width >= kMobileBreakpoint && width < kTabletBreakpoint;
  }

  /// Retorna TRUE se a largura da tela for maior ou igual a 1024px.
  static bool isDesktop(BuildContext context) {
    return screenWidth(context) >= kTabletBreakpoint;
  }
}

// -------------------------------------------------------------------------
// 3. Widget de Layout Adaptável
// -------------------------------------------------------------------------

/// Um widget que constrói diferentes layouts com base no tamanho da tela.
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return desktop;
    }

    if (Responsive.isTablet(context)) {
      // Se tablet for null, retorna o layout de desktop.
      return tablet ?? desktop;
    }

    // Padrão: Mobile
    return mobile;
  }
}