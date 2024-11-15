import 'package:flutter/material.dart';

class MedicationsScreen extends StatefulWidget {
  const MedicationsScreen({super.key});

  @override
  _MedicationsScreenState createState() => _MedicationsScreenState();
}

class _MedicationsScreenState extends State<MedicationsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchTerm = '';

  // Lista de medicações disponíveis
  final List<String> _medications = [
    'Ácido acetilsalicílico comprimido 100mg',
    'Ácido fólico solução oral 0,2mg/mL',
    'Albendazol comprimido 400mg',
    'Albendazol suspensão oral 40mg/mL',
    'Alendronato de sódio comprimido 70mg',
    'Alopurinol comprimido 100mg',
    'Alopurinol comprimido 300mg',
    'Amiodarona comprimido 200mg',
    'Amoxicilina pó para suspensão oral 250mg/5mL',
    'Amoxicilina cápsula 500mg',
    'Amoxicilina + Clavulanato de potássio suspensão oral (50mg + 12,5mg)/mL',
    'Amoxicilina + Clavulanato de potássio comprimido 500/125mg',
    'Anlodipino comprimido 5mg',
    'Atenolol comprimido 50mg',
    'Atenolol comprimido 25mg',
    'Azitromicina comprimido 500mg',
    'Azitromicina pó para suspensão oral 200mg/5mL',
    'Benzilpenicilina benzatina pó para suspensão injetável 600.000 UI',
    'Benzilpenicilina benzatina pó para suspensão injetável 1.200.000 UI',
    'Benzilpenicilina procaína + potássica pó para suspensão injetável 300.000 + 100.000 UI',
    'Benzoilmetronidazol suspensão oral 40mg/mL',
    'Bromoprida comprimido 10mg',
    'Bromoprida solução oral 4mg/mL',
    'Carbonato de cálcio comprimido 500mg',
    'Carbonato de cálcio + Vitamina D comprimido 500mg + 400UI',
    'Carvedilol comprimido 25mg',
    'Carvedilol comprimido 6,25mg',
    'Cefalexina suspensão oral 50mg/mL',
    'Cefalexina cápsula 500mg',
    'Ceftriaxona pó para solução injetável 1g IM',
    'Ceftriaxona pó para solução injetável 500mg IM',
    'Ciprofloxacino comprimido 500mg',
    'Cloreto de sódio solução nasal 0,9%',
    'Dexametasona comprimido 4mg',
    'Dexametasona creme 0,1%',
    'Digoxina comprimido 0,25mg',
    'Dipirona solução oral 500mg/mL',
    'Dipirona comprimido 500mg',
    'Enalapril comprimido 5mg',
    'Enalapril comprimido 10mg',
    'Enalapril comprimido 20mg',
    'Espironolactona comprimido 25mg',
    'Espironolactona comprimido 100mg',
    'Estriol creme vaginal 1mg/g',
    'Fluconazol cápsula 150mg',
    'Furosemida comprimido 40mg',
    'Gentamicina solução oftálmica 5mg/mL',
    'Glibenclamida comprimido 5mg',
    'Glicazida comprimido de liberação prolongada 60mg',
    'Glicerol enema 120mg/mL',
    'Hidralazina comprimido 50mg',
    'Hidroclorotiazida comprimido 25mg',
    'Hidróxido de alumínio + magnésio suspensão oral 35,7 + 37mg/mL',
    'Ibuprofeno comprimido 300mg',
    'Ibuprofeno comprimido 600mg',
    'Ibuprofeno solução oral 50mg/mL',
    'Isossorbida comprimido 20mg',
    'Isossorbida comprimido 40mg',
    'Ivermectina comprimido 6mg',
    'Lactulose xarope 667mg/mL',
    'Levonorgestrel + Etinilestradiol comprimido ou drágea 0,15mg + 0,03mg',
    'Levotiroxina sódica comprimido 25mcg',
    'Levotiroxina sódica comprimido 50mcg',
    'Levotiroxina sódica comprimido 100mcg',
    'Loratadina solução oral 1mg/mL',
    'Loratadina comprimido 10mg',
    'Losartana potássica comprimido 50mg',
    'Medroxiprogesterona suspensão injetável 150mg/mL',
    'Metformina comprimido 500mg',
    'Metformina comprimido 850mg',
    'Metildopa comprimido 250mg',
    'Metoclopramida comprimido 10mg',
    'Metoclopramida solução oral 4mg/mL',
    'Metronidazol gel vaginal 100mg/g',
    'Metronidazol comprimido 250mg',
    'Miconazol creme 2% dermatológico',
    'Miconazol creme 2% vaginal',
    'Nistatina suspensão oral 100.000 UI/mL',
    'Nitrofurantoína cápsula 100mg',
    'Noretisterona comprimido 0,35mg',
    'Noretisterona + estradiol solução injetável (50mg + 5mg)/mL',
    'Óleo mineral',
    'Omeprazol cápsula 20mg',
    'Paracetamol solução oral 200mg/mL',
    'Paracetamol comprimido 500mg',
    'Pasta d’água',
    'Permanganato de potássio comprimido 100mg',
    'Permetrina loção 5%',
    'Prednisolona solução oral 3mg/mL',
    'Prednisona comprimido 5mg',
    'Prednisona comprimido 20mg',
    'Prometazina comprimido 25mg',
    'Propranolol comprimido 40mg',
    'Ranitidina comprimido 150mg',
    'Salbutamol aerossol oral 100mcg/dose',
    'Sais para reidratação oral pó para solução oral',
    'Sinvastatina comprimido 20mg',
    'Sinvastatina comprimido 40mg',
    'Sulfametoxazol + Trimetoprima suspensão oral (40mg + 8mg)/mL',
    'Sulfametoxazol + Trimetoprima comprimido 400mg + 80mg',
    'Sulfato ferroso comprimido 40mg',
    'Sulfato ferroso solução oral 25mg/mL',
    'Varfarina sódica comprimido 5mg',
    'Verapamil comprimido 80mg',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Filtra a lista de medicações com base no termo de pesquisa
    final List<String> filteredMedications = _medications
        .where((medication) =>
        medication.toLowerCase().contains(_searchTerm.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicações Disponíveis'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Caixa de pesquisa
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Buscar Medicação',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _searchController.clear();
                      _searchTerm = '';
                    });
                  },
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchTerm = value;
                });
              },
            ),
            const SizedBox(height: 16),
            // Exibição da lista de medicações em cards
            Expanded(
              child: filteredMedications.isEmpty
                  ? const Center(
                child: Text(
                  'Nenhuma medicação encontrada.',
                  style: TextStyle(fontSize: 18),
                ),
              )
                  : ListView.builder(
                itemCount: filteredMedications.length,
                itemBuilder: (context, index) {
                  final medication = filteredMedications[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        medication,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
