import 'package:intl/intl.dart';
import '../db/database_helper.dart';
import 'notification_service.dart';

Future<void> checkUpcomingAppointments() async {
  final db = DatabaseHelper();
  final today = DateTime.now();
  final tomorrow = today.add(const Duration(days: 1));
  final formattedDate = DateFormat('yyyy-MM-dd').format(tomorrow);

  // Buscar consultas e vacinas agendadas para amanhã
  final upcomingAppointments = await db.getAppointmentsByDate(formattedDate);
  final upcomingVaccines = await db.getVaccinesByDate(formattedDate);

  for (var appointment in upcomingAppointments) {
    await NotificationService().showNotification(
      appointment['id'],
      'Lembrete de Consulta',
      'Você tem uma consulta marcada para amanhã às ${appointment['horario']}.',
    );
  }

  for (var vaccine in upcomingVaccines) {
    await NotificationService().showNotification(
      vaccine['id'],
      'Lembrete de Vacinação',
      'Você tem uma vacinação marcada para amanhã às ${vaccine['horario']}.',
    );
  }
}
