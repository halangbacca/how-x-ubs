import 'package:flutter/material.dart';

class VaccineAppointmentListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> vaccineAppointments;

  const VaccineAppointmentListScreen({super.key, required this.vaccineAppointments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Próximas Vacinas'),
        centerTitle: true,
      ),
      body: vaccineAppointments.isEmpty
          ? const Center(
        child: Text(
          'Nenhum agendamento de vacina encontrado.',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: vaccineAppointments.length,
        itemBuilder: (context, index) {
          final appointment = vaccineAppointments[index];
          return ListTile(
            leading: const Icon(Icons.vaccines),
            title: Text(
              '${appointment['vacina']} - ${appointment['data']}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Horário: ${appointment['horario']}'),
          );
        },
      ),
    );
  }
}
