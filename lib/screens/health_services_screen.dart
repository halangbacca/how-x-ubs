import 'package:flutter/material.dart';

class HealthUnitServicesScreen extends StatelessWidget {
  HealthUnitServicesScreen({Key? key}) : super(key: key);

  // Lista de serviços com nome e ícone para cada serviço.
  final List<Map<String, dynamic>> _services = [
    {
      'title': 'Consultas médicas e odontológicas',
      'icon': Icons.medical_services,
      'description': 'Atendimento médico, de enfermagem e saúde bucal.'
    },
    {
      'title': 'Vacinação',
      'icon': Icons.vaccines,
      'description': 'Aplicação de vacinas para diversas faixas etárias.'
    },
    {
      'title': 'Distribuição de medicamentos e curativos',
      'icon': Icons.local_pharmacy,
      'description': 'Fornecimento e administração de medicamentos e curativos.'
    },
    {
      'title': 'Visitas domiciliares',
      'icon': Icons.home,
      'description': 'Atendimento na residência do paciente.'
    },
    {
      'title': 'Educação em saúde',
      'icon': Icons.school,
      'description': 'Atividades de orientação e educação para a saúde.'
    },
    {
      'title': 'Acompanhamento de doenças crônicas',
      'icon': Icons.favorite,
      'description': 'Acompanhamento contínuo para pacientes com doenças crônicas.'
    },
    {
      'title': 'Acompanhamento psicológico',
      'icon': Icons.psychology,
      'description': 'Atendimento e apoio psicológico aos pacientes.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Serviços da UBS'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: GridView.count(
            crossAxisCount: 2, // Dois itens por linha
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            shrinkWrap: true, // Permite que o GridView se ajuste ao conteúdo
            physics: const NeverScrollableScrollPhysics(), // Evita rolagem interna do GridView
            children: _services.map((service) {
              return _buildServiceCard(
                context,
                title: service['title'],
                icon: service['icon'],
                description: service['description'],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  /// Cria um card de serviço com ícone, título e descrição.
  Widget _buildServiceCard(
      BuildContext context, {
        required String title,
        required IconData icon,
        required String description,
      }) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(description),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Fechar'),
              ),
            ],
          ),
        );
      },
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
