import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../db/database_helper.dart';
import 'appointment_list_screen.dart';
import 'vaccine_list_screen.dart';
import 'notification_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  // Métodos para buscar dados do usuário (mantidos)
  Future<List<Map<String, dynamic>>> _fetchUserAppointments(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userId = authProvider.userId;
    if (userId != null) {
      return await DatabaseHelper().getUserAppointments(userId);
    }
    return [];
  }

  Future<List<Map<String, dynamic>>> _fetchUserVaccineAppointments(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userId = authProvider.userId;
    if (userId != null) {
      return await DatabaseHelper().getUserVaccineAppointments(userId);
    }
    return [];
  }

  Future<List<Map<String, String>>> _fetchNotifications() async {
    try {
      final db = DatabaseHelper();
      final tomorrow = DateTime.now().add(const Duration(days: 1));
      final formattedDate = DateFormat('yyyy-MM-dd').format(tomorrow);

      final upcomingAppointments = await db.getAppointmentsByDate(formattedDate);
      final upcomingVaccines = await db.getVaccinesByDate(formattedDate);

      List<Map<String, String>> notifications = [];

      for (var appointment in upcomingAppointments) {
        notifications.add({
          'title': 'Lembrete de Consulta',
          'body': 'Você tem uma consulta marcada para amanhã às ${appointment['horario']}.',
        });
      }

      for (var vaccine in upcomingVaccines) {
        notifications.add({
          'title': 'Lembrete de Vacinação',
          'body': 'Você tem uma vacinação marcada para amanhã às ${vaccine['horario']}.',
        });
      }

      return notifications;
    } catch (e) {
      print('Erro ao buscar notificações: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela Principal'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () async {
              final notifications = await _fetchNotifications();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationsScreen(notifications: notifications),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              final authProvider = Provider.of<AuthProvider>(context, listen: false);
              authProvider.logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Center( // Center para centralizar a grade
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
            shrinkWrap: true, // Permite que o GridView ocupe o espaço necessário
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              _buildOptionCard(
                context,
                title: 'Agendar Consultas',
                icon: Icons.local_hospital,
                onTap: () => Navigator.pushNamed(context, '/appointment'),
              ),
              _buildOptionCard(
                context,
                title: 'Próximas Consultas',
                icon: Icons.calendar_today,
                onTap: () async {
                  final appointments = await _fetchUserAppointments(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppointmentListScreen(appointments: appointments),
                    ),
                  );
                },
              ),
              _buildOptionCard(
                context,
                title: 'Agendar Vacina',
                icon: Icons.vaccines,
                onTap: () => Navigator.pushNamed(context, '/vaccine'),
              ),
              _buildOptionCard(
                context,
                title: 'Próximas Vacinas',
                icon: Icons.event_available,
                onTap: () async {
                  final vaccineAppointments = await _fetchUserVaccineAppointments(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VaccineAppointmentListScreen(
                        vaccineAppointments: vaccineAppointments,
                      ),
                    ),
                  );
                },
              ),
              _buildOptionCard(
                context,
                title: 'Serviços Oferecidos',
                icon: Icons.list,
                onTap: () => Navigator.pushNamed(context, '/services'),
              ),
              _buildOptionCard(
                context,
                title: 'Medicamentos Disponíveis',
                icon: Icons.medication,
                onTap: () => Navigator.pushNamed(context, '/medications'),
              ),
              _buildOptionCard(
                context,
                title: 'Contato',
                icon: Icons.location_on,
                onTap: () => Navigator.pushNamed(context, '/address'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard(
      BuildContext context, {
        required String title,
        required IconData icon,
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: Theme.of(context).primaryColor),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
