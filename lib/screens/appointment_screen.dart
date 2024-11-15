import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../db/database_helper.dart';
import '../providers/auth_provider.dart';

class AppointmentScreen extends StatefulWidget {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  String? _selectedAppointmentType;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  final List<String> _appointmentTypes = [
    'Consulta Médica',
    'Consulta Odontológica',
    'Acolhimento',
  ];

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(days: 1)),
      firstDate: now.add(const Duration(days: 1)),
      lastDate: now.add(const Duration(days: 365)),
      helpText: 'Selecione uma data',
      cancelText: 'Cancelar',
      confirmText: 'OK',
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: 'Selecione um horário',
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
        _timeController.text = pickedTime.format(context);
      });
    }
  }

  Future<void> _confirmAppointment() async {
    if (_selectedAppointmentType == null ||
        _selectedDate == null ||
        _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
    } else {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final userId = authProvider.userId;
      final db = DatabaseHelper();

      try {
        await db.insertAppointment({
          'usuario_id': userId,
          'tipo': _selectedAppointmentType,
          'data': DateFormat('yyyy-MM-dd').format(_selectedDate!),
          'horario': _selectedTime!.format(context),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Agendamento de ${_selectedAppointmentType!} realizado para '
                  '${DateFormat('dd/MM/yyyy').format(_selectedDate!)} às ${_selectedTime!.format(context)}.',
            ),
          ),
        );

        setState(() {
          _selectedAppointmentType = null;
          _selectedDate = null;
          _selectedTime = null;
          _dateController.clear();
          _timeController.clear();
        });
      } catch (e) {
        print('Erro ao salvar a consulta: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao agendar a consulta.')),
        );
      }
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendamento de Consulta'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.calendar_today,
                color: Theme.of(context).primaryColor,
                size: 80,
              ),
              const SizedBox(height: 24),
              const Text(
                'Agendar Consulta',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),

              _buildDropdownField(
                labelText: 'Tipo de Consulta',
                value: _selectedAppointmentType,
                items: _appointmentTypes,
                onChanged: (value) {
                  setState(() {
                    _selectedAppointmentType = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              _buildTextField(
                controller: _dateController,
                labelText: 'Data',
                hintText: 'Selecionar Data',
                onTap: () => _selectDate(context),
              ),
              const SizedBox(height: 16),

              _buildTextField(
                controller: _timeController,
                labelText: 'Horário',
                hintText: 'Selecionar Horário',
                onTap: () => _selectTime(context),
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _confirmAppointment,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Confirmar Agendamento',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String labelText,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      items: items.map((type) {
        return DropdownMenuItem(
          value: type,
          child: Text(type),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (value) => value == null ? 'Por favor, selecione um tipo.' : null,
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    String? hintText,
    required VoidCallback onTap,
  }) {
    return TextField(
      controller: controller,
      readOnly: true,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
