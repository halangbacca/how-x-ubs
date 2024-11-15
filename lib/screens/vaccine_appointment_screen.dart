import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../db/database_helper.dart';
import '../providers/auth_provider.dart';

class VaccineAppointmentScreen extends StatefulWidget {
  @override
  _VaccineAppointmentScreenState createState() => _VaccineAppointmentScreenState();
}

class _VaccineAppointmentScreenState extends State<VaccineAppointmentScreen> {
  String? _selectedVaccine;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  final List<String> _vaccineList = [
    'COVID-19', 'BCG', 'Hepatite B', 'Meningo C', 'Poliomielite 1, 2 e 3',
    'Tríplice viral', 'Difteria e Tétano (dT)', 'Febre Amarela', 'Hepatite A',
    'HPV', 'Dengue', 'Meningocócica ACWY',
  ];

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
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

  Future<void> _confirmVaccineAppointment() async {
    if (_selectedVaccine == null || _selectedDate == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
    } else {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final userId = authProvider.userId;
      final db = DatabaseHelper();

      try {
        await db.insertVaccineAppointment({
          'usuario_id': userId,
          'vacina': _selectedVaccine,
          'data': DateFormat('yyyy-MM-dd').format(_selectedDate!),
          'horario': _selectedTime!.format(context),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Agendamento de $_selectedVaccine realizado para '
                  '${DateFormat('dd/MM/yyyy').format(_selectedDate!)} às ${_selectedTime!.format(context)}.',
            ),
          ),
        );

        setState(() {
          _selectedVaccine = null;
          _selectedDate = null;
          _selectedTime = null;
          _dateController.clear();
          _timeController.clear();
        });
      } catch (e) {
        print('Erro ao salvar o agendamento de vacina: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao agendar a vacina.')),
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
        title: const Text('Agendamento de Vacina'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.vaccines,
                color: Theme.of(context).primaryColor,
                size: 80,
              ),
              const SizedBox(height: 24),
              const Text(
                'Agendar Vacinação',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),

              _buildDropdownField(
                labelText: 'Tipo de Vacina',
                value: _selectedVaccine,
                items: _vaccineList,
                onChanged: (value) {
                  setState(() {
                    _selectedVaccine = value;
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
                  onPressed: _confirmVaccineAppointment,
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
      validator: (value) => value == null ? 'Por favor, selecione uma vacina.' : null,
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
