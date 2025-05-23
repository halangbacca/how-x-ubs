import 'package:flutter/material.dart';

class SymptomCheckScreen extends StatefulWidget {
  const SymptomCheckScreen({super.key});

  @override
  State<SymptomCheckScreen> createState() => _SymptomCheckScreenState();
}

class _SymptomCheckScreenState extends State<SymptomCheckScreen> {
  final Map<String, bool> _symptoms = {
    'Febre alta (acima de 39°C)': false,
    'Falta de ar intensa': false,
    'Dor forte no peito': false,
    'Vômito constante': false,
    'Crise convulsiva': false,
    'Corte, fratura ou sangramento': false,
    'Tontura ou desmaio recente': false,
    'Suspeita de dengue': false,
    'Nenhum desses sintomas': false,
  };

  final List<String> _emergencySymptoms = [
    'Febre alta (acima de 39°C)',
    'Falta de ar intensa',
    'Dor forte no peito',
    'Vômito constante',
    'Crise convulsiva',
    'Corte, fratura ou sangramento',
    'Tontura ou desmaio recente',
  ];

  String? _result;
  Color? _resultColor;

  void _evaluateSymptoms() {
    final selected =
        _symptoms.entries.where((e) => e.value).map((e) => e.key).toList();

    if (selected.contains('Nenhum desses sintomas')) {
      _result =
          'Sem sinais de urgência. Você pode procurar uma UBS para atendimento de rotina ou agendamento.';
      _resultColor = Colors.green;
    } else if (selected.isEmpty) {
      _result = 'Por favor, selecione pelo menos um sintoma.';
      _resultColor = Colors.orange;
    } else if (selected.any((s) => _emergencySymptoms.contains(s))) {
      _result =
          'Atenção: sintomas indicam urgência médica. Procure uma UPA imediatamente.';
      _resultColor = Colors.red;
    } else {
      _result =
          'Recomenda-se procurar uma UBS próxima para avaliação e acompanhamento.';
      _resultColor = Colors.green;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Autoavaliação de Sintomas')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selecione os sintomas que você está sentindo:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: _symptoms.keys.map((symptom) {
                  return CheckboxListTile(
                    title: Text(symptom),
                    value: _symptoms[symptom],
                    onChanged: (value) {
                      setState(() {
                        if (symptom == 'Nenhum desses sintomas' &&
                            value == true) {
                          _symptoms.updateAll((key, _) => key == symptom);
                        } else {
                          _symptoms[symptom] = value ?? false;
                          _symptoms['Nenhum desses sintomas'] = false;
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _evaluateSymptoms,
                child: const Text('Enviar'),
              ),
            ),
            if (_result != null) ...[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _resultColor!.withOpacity(0.1),
                  border: Border.all(color: _resultColor!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _result!,
                  style: TextStyle(
                    color: _resultColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (_resultColor == Colors.green) ...[
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.calendar_month),
                    label: const Text('Agendar Consulta'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/appointment');
                    },
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
