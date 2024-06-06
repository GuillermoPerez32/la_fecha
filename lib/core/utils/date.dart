final List<String> days = [
  'Domingo',
  'Lunes',
  'Martes',
  'Miércoles',
  'Jueves',
  'Viernes',
  'Sábado'
];
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

final currentDate = DateTime.now();
final currentYear = currentDate.year;
final currentMonth = currentDate.month;

String dateFormatter(String date) {
  final List<String> dateParts = date.split('-');
  final int day = int.parse(dateParts[0]);
  final int month = int.parse(dateParts[1]);
  final DateTime dateTime = DateTime(currentYear, month, day);
  final String monthName = months[dateTime.month - 1];
  final String dayName = days[dateTime.weekday - 1];
  return '$dayName $day de $monthName';
}
