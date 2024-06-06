// ignore: prefer_function_declarations_over_variables
String dateFormatter(String date) {
  //date in format d-m to names of day and month
  final List<String> months = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre'
  ];
  final List<String> days = [
    'Domingo',
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado'
  ];
  final List<String> dateParts = date.split('-');
  final int day = int.parse(dateParts[0]);
  final int month = int.parse(dateParts[1]);
  final DateTime dateTime = DateTime(2021, month, day);
  final String monthName = months[dateTime.month - 1];
  final String dayName = days[dateTime.weekday - 1];
  return '$dayName $day de $monthName';
}
