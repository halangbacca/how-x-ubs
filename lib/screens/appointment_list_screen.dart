import 'package:flutter/material.dart';

class AppointmentListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> appointments;

  // Construtor que recebe a lista de consultas.
  const AppointmentListScreen({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Consultas'),
        centerTitle: true,
      ),
      body: appointments.isEmpty
          ? const Center(
        child: Text(
          'Nenhuma consulta encontrada.',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return ListTile(
            leading: const Icon(Icons.calendar_today),
            title: Text(
              '${appointment['tipo']} - ${appointment['data']}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Horário: ${appointment['horario']}'),
          );
        },
      ),
    );
  }
}
