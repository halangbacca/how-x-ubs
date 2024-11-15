import 'package:flutter/material.dart';

class UnidadeScreen extends StatelessWidget {
  final List<String> unidades = [
    'Unidade de Saúde Centro-Vila',
    'Unidade de Saúde Nancy Patino Reiser – Fazenda',
    // Adicione as demais unidades aqui...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Unidades de Saúde')),
      body: ListView.builder(
        itemCount: unidades.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(unidades[index]),
            onTap: () {
              // Lógica ao selecionar uma unidade
            },
          );
        },
      ),
    );
  }
}
