class DateUtil {
  DateUtil._(); // Construtor privado para não instanciar

  /// Formata DateTime para dd/MM/yyyy
  static String formatDate(DateTime date) {
    return '${_twoDigits(date.day)}/${_twoDigits(date.month)}/${date.year}';
  }

  /// Formata DateTime para dd/MM/yyyy HH:mm
  static String formatDateTime(DateTime date) {
    return '${_twoDigits(date.day)}/${_twoDigits(date.month)}/${date.year} '
        '${_twoDigits(date.hour)}:${_twoDigits(date.minute)}';
  }

  /// Converte string ISO ou dd/MM/yyyy HH:mm para DateTime
  static DateTime parse(String dateString) {
    try {
      return DateTime.parse(dateString);
    } catch (_) {
      // Tenta dd/MM/yyyy HH:mm
      final parts = dateString.split(RegExp(r'[/ :\-]'));
      if (parts.length >= 3) {
        return DateTime(
          int.parse(parts[2]),
          int.parse(parts[1]),
          int.parse(parts[0]),
          parts.length > 3 ? int.parse(parts[3]) : 0,
          parts.length > 4 ? int.parse(parts[4]) : 0,
        );
      }
      throw FormatException('Formato de data inválido: $dateString');
    }
  }

  /// Retorna DateTime.now()
  static DateTime now() => DateTime.now();

  /// Início do dia (00:00:00)
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Fim do dia (23:59:59)
  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59);
  }

  /// Auxiliar para garantir 2 dígitos
  static String _twoDigits(int n) => n.toString().padLeft(2, '0');
}
