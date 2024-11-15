import 'package:flutter/material.dart';

class HealthUnitContactScreen extends StatefulWidget {
  HealthUnitContactScreen({Key? key}) : super(key: key);

  @override
  _HealthUnitContactScreenState createState() =>
      _HealthUnitContactScreenState();
}

class _HealthUnitContactScreenState extends State<HealthUnitContactScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchTerm = '';

  //Lista de UBS com informações de contato
  final List<Map<String, String>> _healthUnits = [
    {
      'name': 'Unidade de Saúde Centro-Vila',
      'address': 'Rua Alberto Werner, nº 333 – Vila Operária',
      'phone': '(47) 3241-5932, 3241-5491, 98862-0145',
      'hours': '07h às 17h, de 2ª a 6ª feira',
      'email': 'us.centrovila@itajai.sc.gov.br',
    },
    {
      'name': 'Unidade de Saúde Nancy Patino Reiser – Fazenda',
      'address': 'Rua Milton R. da Luz, nº 200 – Fazenda',
      'phone': '(47) 3246-0448',
      'hours': '07h às 17h, de 2ª a 6ª feira',
      'email': 'us.fazenda@itajai.sc.gov.br',
    },
    {
      'name': 'Unidade de Saúde Vivaldo João Linhares – Praia Brava',
      'address': 'Rua Bráulio Werner, 124 – Praia Brava',
      'phone': '(47) 3346-6376, 3349-0258, 988330-2312',
      'hours': '07h às 17h, de 2ª a 6ª feira',
      'email': 'us.praiabrava@itajai.sc.gov.br',
    },
    {
      'name': 'Unidade de Saúde Rotariano Agenor Krobel – Bambuzal',
      'address': 'Rua São Joaquim, nº 399, Loteamento Bambuzal – São Vicente',
      'phone': '(47) 3346-1781, 99981-1347',
      'hours': '07h às 17h, de 2ª a 6ª feira',
      'email': 'us.bambuzal@itajai.sc.gov.br',
    },
    {
      'name': 'Unidade de Saúde Enfermeira Oswine Lorens – Imaruí',
      'address': 'Rua Leodegário Pedro da Silva, s/nº – Imaruí',
      'phone': '(47) 3346-4324, 3348-5139, 99981-0575',
      'hours': '07h às 17h, de 2ª a 6ª feira',
      'email': 'us.imarui@itajai.sc.gov.br',
    },
    {
      'name':
          'Unidade de Saúde Diva Vieira Abrantes - São João I (Policlínica)',
      'address': 'Rua Pedro Rangel, nº 130, ao lado da igreja – São João',
      'phone': '(47) 3241-6790, 3241-5234, 3241-6312, 98806-4147',
      'hours': '07h às 17h, de 2ª a 6ª feira',
      'email': 'us.saojoao@itajai.sc.gov.br',
    },
    {
      'name': 'Unidade de Saúde São João II – Padre Agostinho Staehelin',
      'address': 'Rua Juca Cesário, nº 89 – São João',
      'phone': '(47) 3246-0331, 3246-0593, 3246-3992, 3246-3414, 98806-6237',
      'hours': '07h às 17h, de 2ª a 6ª feira',
      'email': 'coord.saojoao2@itajai.sc.gov.br, saojoao2@itajai.sc.gov.br',
    },
    {
      'name': 'Unidade de Saúde Vinicius Ivan Alves Pedreira – Cidade Nova I',
      'address': 'Rua Agílio Cunha, s/nº – Cidade Nova',
      'phone': '(47) 3241-4744, 3241-4127, 98801-6766, 98862-0358, 99791-0252',
      'hours': '07h às 17h, de 2ª a 6ª feira',
      'email': 'us.cidadenova@itajai.sc.gov.br',
    },
    {
      'name': 'Unidade de Saúde João Victorino – Cidade Nova II',
      'address':
          'Rua Agílio Cunha, s/n°, em frente ao colégio Pedro Rizzi – Cidade Nova',
      'phone': '(47) 3241-4561, 3241-4929, 98832-8742',
      'hours': '07h às 17h, de 2ª a 6ª feira',
      'email': 'us.cidadenova2@itajai.sc.gov.br',
    },
    {
      'name': 'Unidade de Saúde Evilasio Victorino - Promorar II',
      'address':
          'Avenida Ministro Luiz Galloti, s/n°, Promorar II - Cidade Nova',
      'phone': '(47) 3249-1079, 3241-4561, 98814-0226',
      'hours': '07h às 17h, de 2ª a 6ª feira',
      'email': 'us.promorar@itajai.sc.gov.br',
    },
    {
      'name': 'Unidade de Saúde Bernardino Miguel Peirão – Rio Bonito',
      'address':
          'Avenida Arq. Nilson Edson dos Santos, s/nº, Loteamento Rio Bonito – São Vicente',
      'phone': '(47) 3344-5731, 3246-6248, 3241-2710, 3346-3232, 99772-0020',
      'hours': '07h às 17h, de 2ª a 6ª feira',
      'email': 'us.riobonito@itajai.sc.gov.br',
    },
    {
      'name': 'Unidade de Saúde São Vicente',
      'address': 'Rua Padre Paulo Condla, nº 392 – bairro São Vicente',
      'phone':
          '(47) 3246-5663, 3246-2502, 3246-5708, 3241-4384, 98827-2694, 98918-3836',
      'hours': '07h às 17h, de 2ª a 6ª feira',
      'email': 'us.saovicente@itajai.sc.gov.br',
    },
    {
      'name': 'Unidade de Saúde Manoel Amândio Vicente – Canhanduba',
      'address': 'Estrada Geral da Canhanduba, s/nº – Canhanduba',
      'phone': '(47) 3247-9720, 3249-5598',
      'hours': '07h às 17h, de 2ª a 6ª feira',
      'email': 'us.canhanduba@itajai.sc.gov.br',
    },
    {
      'name': 'Unidade de Saúde Fernando Wippel – Itaipava',
      'address': 'Avenida Itaipava, s/nº – Itaipava',
      'phone': '(47) 3348-9731, 3346-2702, 99622-0143',
      'hours': '07h às 17h, de 2ª a 6ª feira',
      'email': 'us.itaipava@itajai.sc.gov.br',
    },
    {
      'name': 'Unidade de Saúde Ignácio Theodoro Pereira – Limoeiro',
      'address': 'Rua Edmundo Leopoldo Merisio, s/nº – Limoeiro',
      'phone': '(47) 3247-0709, 3247-0681',
      'hours': '07h às 17h, de 2ª a 6ª feira',
      'email': 'us.limoeiro@itajai.sc.gov.br',
    },
    {
      'name': 'Unidade de Saúde Parque do Agricultor',
      'address':
          'Rua Mansueto Felizardo Vieira, nº 557 – Comunidade da Baía, junto ao Parque do Agricultor Gilmar Graf',
      'phone': '(47) 3131-2229, 98803-9427',
      'hours': '07h às 17h, de 2ª a 6ª feira',
      'email': 'us.parquedoagricultor@itajai.sc.gov.br',
    },
    {
      'name': 'Unidade de Saúde Miro Sedrez – Cordeiros',
      'address':
          'Rua Odílio Garcia, s/n°, próximo à igreja de São Cristóvão – Cordeiros',
      'phone': '(47) 3334-5992, 3349-6173, 98832-1555',
      'hours': '07h às 17h, de 2ª a 6ª feira',
      'email': 'us.cordeiros@itajai.sc.gov.br',
    },
    {
      'name': 'Unidade de Saúde Costa Cavalcante',
      'address': 'Rua Espírito Santo, s/nº - Costa Cavalcante',
      'phone': '(47) 3248-8608, 3246-2767, 99772-0111',
      'hours': '07h às 17h, de 2ª a 6ª feira',
      'email': 'us.costacavalcante@itajai.sc.gov.br',
    },
    {
      'name': 'Unidade de Saúde Jardim Esperança',
      'address':
          'Rua Sebastião Romeu Soares, s/n°, em frente ao colégio Melvin Jones – Cordeiros',
      'phone': '(47) 3346-6995, 3241-3286, 99714-1906',
      'hours': '07h às 17h, de 2ª a 6ª feira',
      'email': 'us.jardimesperanca@itajai.sc.gov.br',
    },
    {
      'name': 'Unidade de Saúde Bento Rampelotti – Murta',
      'address': 'Rua Orlandina Amália Pires Correa, nº 300 – Murta',
      'phone': '(47) 3347-8503, 3347-8917, 98918-0351',
      'hours': '07h às 17h, de 2ª a 6ª feira',
      'email': 'us.murta@itajai.sc.gov.br',
    },
    {
      'name': 'Unidade de Saúde Votorantim',
      'address':
          'Rua Selso Duarte Moreira, nº 1442, Loteamento Votorantim – Cordeiros',
      'phone': '(47) 3241-5772, 3246-2568, 98862-0651',
      'hours': '07h às 17h, de 2ª a 6ª feira',
      'email': 'us.votorantim@itajai.sc.gov.br',
    },
    {
      'name': 'Unidade de Saúde Rachel Dalçoquio de Borba – Espinheiros',
      'address': 'Rua Firmino Vieira Cordeiro, nº 1778 – Espinheiros',
      'phone': '(47) 3349-1782, 3349-1834, 98884-7496',
      'hours': '07h às 22h, de 2ª a 6ª feira',
      'email': 'us.espinheiros@itajai.sc.gov.br',
    },
    {
      'name': 'Unidade de Saúde Salseiros',
      'address': 'Rua César Augusto Dalçoquio, s/nº – Salseiros',
      'phone': '(47) 98801-1622',
      'hours': '07h às 17h, de 2ª a 6ª feira',
      'email': 'us.salseiros@itajai.sc.gov.br',
    },
    {
      'name': 'Unidade de Saúde Santa Regina',
      'address': 'Rua Domingos de Almeida, s/nº – Santa Regina',
      'phone': '(47) 3247-2288, 98920-1523',
      'hours': '07h às 22h, de 2ª a 6ª feira',
      'email': 'us.santaregina@itajai.sc.gov.br',
    },
    {
      'name': 'Unidade de Saúde Nossa Senhora das Graças',
      'address': 'Rua Uruguai, nº 458, bloco F7 da Univali – Centro',
      'phone':
          '(47) 3246-2567, 98804-7847, 98833-7558, 98848-9293, 98862-0593, 98919-0250',
      'hours': '07h às 17h, de 2ª a 6ª feira',
      'email': 'us.nossasenhoradasgracas@itajai.sc.gov.br',
    },
    {
      'name': 'Unidade de Saúde Fazenda e Cabeçudas',
      'address': 'Rua José Correia, nº 163 – Fazendinha',
      'phone': '(47) 3246-4958, 3246-4790',
      'hours': '07h às 17h, de 2ª a 6ª feira',
      'email': 'us.fazenda2@itajai.sc.gov.br',
    },
    {
      'name': 'Unidade de Saúde São Judas',
      'address': 'Rua Pedro Joaquim Vieira, 179 – São Judas',
      'phone': '(47) 3246-6322, 3246-3973, 98804-9016',
      'hours': '07h às 17h, de 2ª a 6ª feira',
      'email': 'us.saojudas@itajai.sc.gov.br',
    },
    {
      'name': 'Unidade de Saúde Leopoldo Fischer – Brilhante',
      'address': 'Rua José Lana, nº 70 – Brilhante',
      'phone': '(47) 3246-0378, 3248-4181, 99791-0242',
      'hours': '07h às 17h, de 2ª a 6ª feira',
      'email': 'us.brilhante@itajai.sc.gov.br',
    },
    {
      'name': 'Unidade de Saúde São Pedro',
      'address': 'Rua Francisco Boaventura da Silva, nº 54 – Itaipava',
      'phone': '(47) 3346-9410, 99981-0036',
      'hours': '07h às 17h, de 2ª a 6ª feira',
      'email': 'coord.ussaopedro@itajai.sc.gov.br',
    },
    {
      'name': 'Unidade de Saúde Elizabet Caetano Pacheco – Portal II',
      'address':
          'Rua Nono Emilio Dalçoquio, nº 760 – Loteamento Portal II – Espinheiros',
      'phone': '(47) 3908-6978, 98837-3786',
      'hours': '07h às 17h, de 2ª a 6ª feira',
      'email': 'us.portal2@itajai.sc.gov.br',
    },
    {
      'name': 'Unidade de Saúde São Francisco de Assis',
      'address':
          'Rua João Antônio Martins, s/nº, Loteamento São Francisco de Assis – Santa Regina',
      'phone': '(47) 3246-2860, 98862-0602',
      'hours': '07h às 17h, de 2ª a 6ª feira',
      'email': 'us.saofrancisco@itajai.sc.gov.br',
    },
    {
      'name': 'Unidade de Saúde São Roque',
      'address': 'Rua Domingos Rampelotti, nº 1299 – São Roque',
      'phone': '(47) 3241-5443, 98838-3281',
      'hours': '07h às 17h, de 2ª a 6ª feira',
      'email': 'us.saoroque@itajai.sc.gov.br',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Filtrar a lista de unidades de saúde com base no termo de busca
    final filteredUnits = _healthUnits.where((unit) {
      final searchTerm = _searchTerm.toLowerCase();
      return unit['name']!.toLowerCase().contains(searchTerm) ||
          unit['address']!.toLowerCase().contains(searchTerm) ||
          unit['phone']!.toLowerCase().contains(searchTerm) ||
          unit['email']!.toLowerCase().contains(searchTerm);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contatos das Unidades de Saúde'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Caixa de busca
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Buscar Unidade de Saúde',
                border: OutlineInputBorder(),
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
            // Lista de unidades de saúde filtradas
            Expanded(
              child: filteredUnits.isEmpty
                  ? const Center(
                      child: Text(
                        'Nenhuma unidade de saúde encontrada.',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredUnits.length,
                      itemBuilder: (context, index) {
                        final healthUnit = filteredUnits[index];
                        return _buildHealthUnitCard(
                          name: healthUnit['name']!,
                          address: healthUnit['address']!,
                          phone: healthUnit['phone']!,
                          hours: healthUnit['hours']!,
                          email: healthUnit['email']!,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  /// Constrói um card para exibir informações de contato da unidade de saúde
  Widget _buildHealthUnitCard({
    required String name,
    required String address,
    required String phone,
    required String hours,
    required String email,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16),
                const SizedBox(width: 8),
                Expanded(child: Text(address)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.phone, size: 16),
                const SizedBox(width: 8),
                Expanded(child: Text(phone)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.access_time, size: 16),
                const SizedBox(width: 8),
                Expanded(child: Text(hours)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.email, size: 16),
                const SizedBox(width: 8),
                Expanded(child: Text(email)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}