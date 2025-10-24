class DateUtil {
  DateUtil._(); // Construtor privado para não instanciar

  /// Formata DateTime para dd/MM/yyyy
  static String formatDate(DateTime date) {
    return '${_twoDigits(date.day)}/${_twoDigits(date.month)}/${date.year}';
  }

  /// Formata DateTime para HH:mm (formato 24h)
  static String formatHour(DateTime date) {
    return '${_twoDigits(date.hour)}:${_twoDigits(date.minute)}';
  }

  /// Formata DateTime para dd/MM/yyyy HH:mm
  static String formatDateTime(DateTime date) {
    return '${formatDate(date)} ${formatHour(date)}';
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

  /// Combina string de data (dd/MM/yyyy) e hora (HH:mm) em um DateTime
  static DateTime parseFromDateAndHour(String dateString, String hourString) {
    try {
      // Divide a data
      final dateParts = dateString.split('/');
      if (dateParts.length != 3) {
        throw FormatException('Formato de data inválido: $dateString. Use dd/MM/yyyy');
      }

      // Divide a hora
      final hourParts = hourString.split(':');
      if (hourParts.length < 1 || hourParts.length > 2) {
        throw FormatException('Formato de hora inválido: $hourString. Use HH:mm');
      }

      // Parse dos componentes
      final day = int.parse(dateParts[0]);
      final month = int.parse(dateParts[1]);
      final year = int.parse(dateParts[2]);

      final hour = int.parse(hourParts[0]);
      final minute = hourParts.length > 1 ? int.parse(hourParts[1]) : 0;

      // Validações básicas
      if (hour < 0 || hour > 23) {
        throw FormatException('Hora inválida: $hour. Deve estar entre 00 e 23');
      }
      if (minute < 0 || minute > 59) {
        throw FormatException('Minuto inválido: $minute. Deve estar entre 00 e 59');
      }

      return DateTime(year, month, day, hour, minute);

    } catch (e) {
      if (e is FormatException) {
        rethrow;
      }
      throw FormatException('Erro ao converter data e hora: $dateString $hourString. Error: $e');
    }
  }

  /// Método alternativo que recebe uma string completa "dd/MM/yyyy HH:mm"
  static DateTime parseFromDateTimeString(String dateTimeString) {
    final parts = dateTimeString.split(' ');
    if (parts.length != 2) {
      throw FormatException('Formato inválido: $dateTimeString. Use "dd/MM/yyyy HH:mm"');
    }

    return parseFromDateAndHour(parts[0], parts[1]);
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