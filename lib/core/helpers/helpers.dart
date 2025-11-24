import 'dart:convert';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:app_tasking/core/theme/app_text_color.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Helpers {
  static List<String> months = [
    "Ene",
    "Feb",
    "Mar",
    "Abr",
    "May",
    "Jun",
    "Jul",
    "Ago",
    "Sep",
    "Oct",
    "Nov",
    "Dic"
  ];

  static String formatRangeDate(String startDate, String endDate) {
    if (startDate.isEmpty || endDate.isEmpty) return '';

    try {
      final start = DateTime.parse(startDate);
      final end = DateTime.parse(endDate);

      final startDay = start.day.toString().padLeft(2, '0');
      final startMonth = months[start.month - 1];
      final startYear = start.year;

      final endDay = end.day.toString().padLeft(2, '0');
      final endMonth = months[end.month - 1];
      final endYear = end.year;

      return '$startDay $startMonth $startYear - $endDay $endMonth $endYear';
    } catch (e) {
      return '';
    }
  }

  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  /* 📌 Obtenre días restantes*/
  static String getDaysRemaining(String endDate) {
    if (endDate.isEmpty) return '';
    DateTime endDatee = DateTime.parse(endDate);
    DateTime startDatee = DateTime.now();

    Duration difference = endDatee.difference(startDatee);
    int daysDifference = difference.inDays;
    return daysDifference.toString();
  }

  static String formatDateddMMString(String date) {
    if (date.isEmpty) return '';
    DateTime parsedDate = DateTime.parse(date);
    return "${parsedDate.day}/${months[parsedDate.month - 1]}";
  }

  /* 📌 Obtenre días restantes*/
  static Color getDaysRemainingColor(String endDate, context) {
    Color color = Colors.black;
    if (endDate.isEmpty) return color;
    DateTime endDatee = DateTime.parse(endDate);
    DateTime startDatee = DateTime.now();

    Duration difference = endDatee.difference(startDatee);
    int daysDifference = difference.inDays;

    switch (daysDifference) {
      case <= 5 && >= 0:
        color = AppTextColor.textDaysToFinishAbout(context);
        break;
      case < 0:
        color = AppTextColor.textDaysToFinishNegative(context);
        break;
      default:
        color = AppTextColor.textDaysToFinishOnTime(context);
    }
    return color;
  }

  /* 📌 Obtener iniciales de los nombres*/
  static String getInitial(String name) {
    if (name.isEmpty) return '';

    List<String> parts = name.trim().split(' ');
    String initials = parts
        .where((part) => part.isNotEmpty)
        .take(2) // Solo las primeras dos palabras
        .map((part) => part[0].toUpperCase())
        .join();
    return initials;
  }

  static String formattedDateToDMA(DateTime? date) {
    //dd/mm/yy
    if (date == null) return 'Fecha no disponible';

    String formattedDate = '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year.toString().substring(2)}';

    return formattedDate;
  }

  static String formattedRecords(String text) {
    if (text.isEmpty) return '';
    String formattedText = '';
    formattedText = text.replaceAll(RegExp(r'</(p|span)>'), '\n');
    formattedText = formattedText.replaceAll(
        RegExp(
            r'<span style="font-family:verdana,arial; font-size:10px; font-stretch:normal; font-style:normal;"><strong>'),
        '');
    formattedText = formattedText.replaceAll(
        RegExp(r'<span><br>------------------------------<br></p>'), '');
    formattedText = formattedText.replaceAll(RegExp(r'<p>'), '');
    formattedText = formattedText.replaceAll(RegExp(r'<br>'), '');
    formattedText = formattedText.replaceAll(RegExp(r'<span>'), '');
    formattedText = formattedText.replaceAll(RegExp(r'</strong>'), '');
    return formattedText.trimRight();
  }

  static int getHours(String time) {
    if (time.isEmpty) return 0;
    return int.parse(time.split(':')[0]);
  }

  static int getMinutes(String time) {
    if (time.isEmpty) return 0;
    return int.parse(time.split(':')[1]);
  }

  static String formattedDateddmmyy(DateTime? date) {
    if (date == null) return 'Fecha no disponible';

    String formattedDate = '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year.toString().substring(2)}';

    return formattedDate;
  }

  static String formatStringDateToddmmyy(String date) {
    if (date.isEmpty) return "Fecha no disponible";
    List<String> parts = date.split('-');
    return '${parts[2]}/${parts[1]}/${parts[0].substring(2)}';
  }

  static Future<dynamic> loadJsonAssets(String fileName) async {
    final response = await rootBundle.loadString("assets/json/$fileName");
    return json.decode(response);
  }

  static DateTime stringToDateTime(String dateTimeString) {
    try {
      final formatter = DateFormat('yyyy/MM/dd');
      return formatter.parse(dateTimeString);
    } catch (e) {
      return DateTime.now();
    }
  }

  static noRequiredDateTime(String? value, String date) {
    RegExp fechaRegex =
        RegExp(r'^(\d{4})/(0[1-9]|1[0-2])/(0[1-9]|1\d|2\d|3[01])$');
    if (value == null || value.isEmpty) {
      return null;
    } else if (!fechaRegex.hasMatch(date)) {
      return "Formato no válido";
    } else {
      return null;
    }
  }

  static noRequiredDateTimeDMY(String? value, String date) {
    RegExp fechaRegex =
        RegExp(r'^(0[1-9]|[12][0-9]|3[01])\/(0[1-9]|1[012])\/\d{4}$');
    if (value == null || value.isEmpty) {
      return null;
    } else if (!fechaRegex.hasMatch(date)) {
      return "Formato no válido";
    } else {
      return null;
    }
  }

  static String? regexFormSearch(
    String? value,
  ) {
    final regExp = RegExp(r'^$|^[0-9a-zA-ZáéíóúÁÉÍÓÚñÑ\s\-\_\(\)\/]*$');
    if (value == null || value.isEmpty) {
      return null;
    } else if (!regExp.hasMatch(value)) {
      return "Caracteres permitidos '/', '-' , '_' y '()'";
    } else {
      return null;
    }
  }

  /* 📌 comparar fechas en formato yyyy/mm/dd*/
  static int compareDates(String date1, String date2) {
    DateFormat format = DateFormat("yyyy/MM/dd");
    if (date1.isEmpty || date2.isEmpty) {
      return 0;
    }
    try {
      DateTime dateTime1 = format.parseStrict(date1);
      DateTime dateTime2 = format.parseStrict(date2);
      return dateTime1.compareTo(dateTime2);
    } catch (e) {
      // Error de formato de fecha
      return 0;
    }
  }

/* 📌 comparar fechas en formato dd/mm/yyyy*/
  static int compareDatesDMY(String date1, String date2) {
    DateFormat format = DateFormat("dd/MM/yyyy");
    if (date1.isEmpty || date2.isEmpty) {
      return 0;
    }
    try {
      DateTime dateTime1 = format.parseStrict(date1);
      DateTime dateTime2 = format.parseStrict(date2);
      return dateTime1.compareTo(dateTime2);
    } catch (e) {
      // Error de formato de fecha
      return 0;
    }
  }

  /* 📌 Formato del calendario mm/dd/yy */
  static String dateMMDDYY(String dateString) {
    if (dateString.isEmpty) return '';
    DateTime date = DateFormat('dd/MM/yy').parse(dateString);
    String newDate = DateFormat('MM/dd/yy').format(date);
    return newDate;
  }

  /* 📌 Formato del calendario */
  static String dateToStringTime(DateTime dateTime) {
    final formatter = DateFormat('yyyy/MM/dd');
    return formatter.format(dateTime);
  }

  /* 📌 Formato del calendario dd/mm/yyyy */
  static String dateToStringTimeDMY(DateTime dateTime) {
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(dateTime);
  }

  /* 📌 Formato del calendario dd/mm/yyyy */
  static String dateToStringDMY(DateTime dateTime) {
    final formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(dateTime);
  }

  /* 📌 Formato del calendario dd/mm/yyyy */
  static String dateToStringHourMinute(DateTime dateTime) {
    // final formatter = DateFormat('hh:mm a'); // Formato 12 horas con AM/PM
    final formatter = DateFormat.Hm();
    return formatter.format(dateTime);
  }

  static String formatDurationToHHMM(Duration duration) {
    final int hours = duration.inHours;
    final int minutes = duration.inMinutes.remainder(60);

    final String formattedHours = hours.toString().padLeft(2, '0');
    final String formattedMinutes = minutes.toString().padLeft(2, '0');

    return "$formattedHours:$formattedMinutes";
  }

  static String timeOfDayToString(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
    // final formatter = DateFormat('hh:mm a');
    // final formatter = DateFormat('hh:mm');
    final formatter = DateFormat.Hm(); // <- formato 24 horas "HH:mm"
    return formatter.format(dateTime);
  }

  Color getCircleColor(int idValidacion) {
    Color circleColor;
    switch (idValidacion) {
      case 1:
        circleColor = AppColors.validationTimely;
        break;
      case 2:
        circleColor = AppColors.validationLate;
        break;
      case 3:
        circleColor = AppColors.validationMissing;
        break;
      default:
        circleColor = AppColors.validationJustified;
        break;
    }
    return circleColor;
  }

  static Color getColorInvitationMeet(String? value) {
    if (value == null || value.isEmpty) {
      return AppColors.grayBlue;
    }
    Color circleColor;
    switch (value) {
      case 'Aceptado':
        circleColor = AppColors.validationTimely;
        break;
      case 'Pendiente':
        circleColor = AppColors.grayBlue;
        break;
      case 'Rechazado':
        circleColor = AppColors.validationMissing;
        break;
      default:
        circleColor = AppColors.grayBlue;
        break;
    }
    return circleColor;
  }

  String getWeekCurrent() {
    final now = DateTime.now();
    // Obtén el día de la semana actual (0 = domingo, 1 = lunes, ..., 6 = sábado)
    final currentDayOfWeek = now.weekday;
    // Calcula la fecha del lunes de la semana actual
    final startOfWeek = now.subtract(Duration(days: currentDayOfWeek - 1));
    // Calcula la fecha del viernes de la semana actual
    final endOfWeek = startOfWeek.add(const Duration(days: 4));
    final format = DateFormat('dd', 'es');
    final monthFormat = DateFormat('MMM', 'es');
    final startDayFormatted = format.format(startOfWeek);
    final endDayFormatted = format.format(endOfWeek);
    final monthFormatted = monthFormat.format(startOfWeek);

    return '$startDayFormatted - $endDayFormatted $monthFormatted.';
  }

  String getDateLarge() {
    final now = DateTime.now();
    final format = DateFormat('EEEE dd \'de\' MMM.', 'es');
    return format.format(now);
  }

  String formatDateNormal(DateTime fecha) {
    final DateFormat formato = DateFormat('yyyy-MM-dd');
    return formato.format(fecha);
  }

  static String formatDateAgeMonthDay(String date) {
    final parts = date.split('/');
    return '${parts[2]}-${parts[1]}-${parts[0]}';
  }

  static String formateDateTimeEsp(DateTime? date) {
    if (date == null) return '';
    final DateFormat formato = DateFormat('dd/MM/yyyy');
    return formato.format(date);
  }

  String formatDateShort(DateTime fecha) {
    final DateFormat formato = DateFormat('yyyy-MM');
    return formato.format(fecha);
  }

  /* 📌 Comparar que las contraseñas ingresadas sean iguales */
  static String? comparePassword(String firstPass, String secondPass) {
    if (firstPass != secondPass) {
      return "Asegúrate de que las contraseñas sean idénticas";
    } else {
      return null;
    }
  }

  /* 📌 Validar fecha en formato yyyy/MM/dd  */
  static String? validateDateFormat(String? value) {
    if (value == null || value.isEmpty) {
      return "Seleccionar una fecha";
    } else {
      final RegExp dateRegex =
          RegExp(r'^\d{4}\/(0[1-9]|1[0-2])\/(0[1-9]|[12][0-9]|3[01])$');
      if (!dateRegex.hasMatch(value)) {
        return "Formato de fecha inválido";
      }
      return null;
    }
  }

  /* 📌 Validar fecha en formato dd/MM/yyyy */
  static String? validateDateFormatDMY(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    } else {
      final RegExp dateRegex =
          RegExp(r'^(0[1-9]|[12][0-9]|3[01])\/(0[1-9]|1[012])\/\d{4}$');
      if (!dateRegex.hasMatch(value)) {
        return "Formato de fecha inválido";
      }
      return null;
    }
  }

  /* 📌 Cambiar formato de fecha de yyyy/MM/dd a dd/MM/yyyy */
  static String changeDateToddMMyyyy(String date) {
    DateFormat inputFormat =
        DateFormat('yyyy/MM/dd'); // Define el formato de entrada
    DateFormat outputFormat =
        DateFormat('dd/MM/yyyy'); // Define el formato de salida

    DateTime dateTime =
        inputFormat.parse(date); // Convierte la cadena de texto a DateTime
    String formattedDateString = outputFormat.format(
        dateTime); // Convierte DateTime de vuelta a la cadena de texto con el nuevo formato
    return formattedDateString;
  }

  /* 📌 Cambiar formato de fecha de  dd/MM/yyyy  a yyyy/MM/dd */
  static String changeDateToyyyyMMdd(String date) {
    DateFormat inputFormat =
        DateFormat('dd/MM/yyyy'); // Define el formato de entrada
    DateFormat outputFormat =
        DateFormat('yyyy/MM/dd'); // Define el formato de salida

    DateTime dateTime =
        inputFormat.parse(date); // Convierte la cadena de texto a DateTime
    String formattedDateString = outputFormat.format(
        dateTime); // Convierte DateTime de vuelta a la cadena de texto con el nuevo formato
    return formattedDateString;
  }

  // 📌 Saber que tipo de error es y mostrar un mensaje descriptivo al usuario
  static String knowTypeError(error) {
    if (error.toString().contains('NOT_INTERNET_EXCEPTION')) {
      return "kmessageErrorNetwork";
    }
    if (error.toString().contains('TIME_OUT')) {
      return "messageErrorOnTimeOut";
    }
    if (error.toString().contains('connection error')) {
      return "messageErrorNotResponse";
    } else {
      return "kmessageErrorGeneral";
    }
  }

  /* 📌 Cambiar formato de fecha de yyyy/MM/dd a dd/MM/yyyy */
  static String changeDateTodMy(String date) {
    DateFormat inputFormat =
        DateFormat('yyyy-MM-dd'); // Define el formato de entrada
    DateFormat outputFormat =
        DateFormat('dd/MM/yyyy'); // Define el formato de salida

    DateTime dateTime =
        inputFormat.parse(date); // Convierte la cadena de texto a DateTime
    String formattedDateString = outputFormat.format(
        dateTime); // Convierte DateTime de vuelta a la cadena de texto con el nuevo formato
    return formattedDateString;
  }

  /* 📌 Cambiar formato de fecha de yyyy/MM/dd a dd/MM/yyyy */
  static String changeStringDateToymd(String date) {
    DateFormat inputFormat =
        DateFormat('dd/MM/yyyy'); // Define el formato de entrada
    DateFormat outputFormat =
        DateFormat('yyyy-MM-dd'); // Define el formato de salida
    

    DateTime dateTime =
        inputFormat.parse(date); // Convierte la cadena de texto a DateTime
    String formattedDateString = outputFormat.format(
        dateTime); // Convierte DateTime de vuelta a la cadena de texto con el nuevo formato
    return formattedDateString;
  }
   /* 📌 Cambiar formato de fecha de yyyy/MM/dd a dd/MM/yyyy */
  static String ddMMyyyy(String? value) {
    if (value == null || value.isEmpty) return '';
    final date = DateTime.parse(value);
    DateFormat outputFormat =
        DateFormat('dd/MM/yyyy'); // Define el formato de salida
    String formattedDateString = outputFormat.format(
        date); // Convierte DateTime de vuelta a la cadena de texto con el nuevo formato
    return formattedDateString;
  }
  


  static String colorToHex(Color color) {
    int r = (color.r * 255).round();
    int g = (color.g * 255).round();
    int b = (color.b * 255).round();

    return '#'
        '${r.toRadixString(16).padLeft(2, '0')}'
        '${g.toRadixString(16).padLeft(2, '0')}'
        '${b.toRadixString(16).padLeft(2, '0')}';
  }

  static Map<String, int> extractTime(String text) {
    // Si el texto está vacío, devolvemos 0
    if (text.isEmpty) return {'hours': 0, 'minutes': 0};

    final parts = text.split(':');

    // Si solo hay un número (ej. "30"), lo tomamos como minutos
    if (parts.length == 1) {
      return {
        'hours': 0,
        'minutes': int.tryParse(parts[0]) ?? 0,
      };
    }

    // Si hay dos partes (ej. "1:30" o "30:00")
    return {
      'hours': int.tryParse(parts[0]) ?? 0,
      'minutes': int.tryParse(parts[1]) ?? 0,
    };
  }

  static Color hexToColor(String? hex) {
    // Si es nulo o vacío, devolvemos un color por defecto (por ejemplo, gris claro)
    if (hex == null || hex.trim().isEmpty) {
      return Colors.grey.shade400;
    }

    try {
      // Quitamos espacios y el símbolo '#'
      hex = hex.trim().replaceAll('#', '');

      // Validamos caracteres válidos
      final isValidHex = RegExp(r'^[0-9a-fA-F]+$').hasMatch(hex);
      if (!isValidHex) {
        return Colors.grey.shade400;
      }

      // Si es formato corto de 3 caracteres, expandimos a 6
      if (hex.length == 3) {
        hex = hex.split('').map((c) => '$c$c').join();
      }

      // Si falta el canal alfa, lo agregamos como 'FF' (100% opacidad)
      if (hex.length == 6) {
        hex = 'FF$hex';
      }

      // Si la longitud no es la esperada (8), devolvemos color por defecto
      if (hex.length != 8) {
        return Colors.grey.shade400;
      }

      // Convertimos el string a color
      return Color(int.parse(hex, radix: 16));
    } catch (e) {
      // En caso de error, devolvemos un color por defecto
      return Colors.grey.shade400;
    }
  }

  static String percentageFormatted(String value) {
    double number = double.tryParse(value) ?? 0.0;

    return number.round().toString();
  }

  static String getNameBtn(int? state) {
    if (state == null) return 'Iniciar';
    String nameState = '';
    switch (state) {
      case 0:
        nameState = 'Iniciar';
      case 1:
        nameState = 'En progreso';
      case 2:
        nameState = 'Ver acta';
    }
    return nameState;
  }

  static String formatTimeToAmPm(String? dateTimeString) {
    //Ejm 2025-10-30T15:37:00 a 15:37 PM
    if (dateTimeString == null || dateTimeString.isEmpty) return '';

    try {
      final dateTime = DateTime.parse(dateTimeString);
      int hour = dateTime.hour;
      final minute = dateTime.minute.toString().padLeft(2, '0');
      String period = 'AM';

      if (hour >= 12) {
        period = 'PM';
        if (hour > 12) hour -= 12;
      } else if (hour == 0) {
        hour = 12;
      }

      final hourFormatted = hour.toString().padLeft(2, '0');
      return '$hourFormatted:$minute $period';
    } catch (e) {
      return '';
    }
  }

  /// Devuelve un número formateado a dos dígitos, por ejemplo:
  static String twoDigits(int? number) {
    /// 1 -> "01", 9 -> "09", 12 -> "12"
    if (number == null) return '00';
    return number.toString().padLeft(2, '0');
  }

  static String getRangoHora({
    required String? reunionHoraIni,
    required int reunionTotalHoras,
    required int reunionMinutos,
  }) {
    // 1️⃣ Validación
    if (reunionHoraIni == null || reunionHoraIni.isEmpty) {
      return '-';
    }

    try {
      // 2️⃣ Parsear la hora inicial
      DateTime horaInicio = DateTime.parse(reunionHoraIni);

      // 3️⃣ Sumar horas y minutos
      DateTime horaFin = horaInicio.add(
        Duration(hours: reunionTotalHoras, minutes: reunionMinutos),
      );

      // 4️⃣ Formatear en HH:mm:ss
      String inicioStr =
          '${horaInicio.hour.toString().padLeft(2, '0')}:${horaInicio.minute.toString().padLeft(2, '0')}:${horaInicio.second.toString().padLeft(2, '0')}';
      String finStr =
          '${horaFin.hour.toString().padLeft(2, '0')}:${horaFin.minute.toString().padLeft(2, '0')}:${horaFin.second.toString().padLeft(2, '0')}';

      // 5️⃣ Resultado final
      return '$inicioStr a $finStr';
    } catch (e) {
      // Por si el formato no es válido
      return '-';
    }
  }
}
