import 'package:flutter/material.dart';

class TemplatesPage extends StatefulWidget {
  const TemplatesPage({super.key});

  @override
  State<TemplatesPage> createState() => _TemplatesPageState();
}

class _TemplatesPageState extends State<TemplatesPage> {
  final String _currentCarModel = 'Honda Civic';

  final List _communityTemplates = [
    {
      'title': 'Revisão de 50.000 km',
      'author': 'João Silva (Você)',
      'carModel': 'Honda Civic',
      'isPublic': true,
      'likes': 12,
      'description': 'Pontos de atenção para correias, fluidos e sistema de freio do Civic.',
    },
    {
      'title': 'Guia de Compra: Check no Civic Usado',
      'author': 'Clube Civic BR',
      'carModel': 'Honda Civic',
      'isPublic': true,
      'likes': 389,
      'description': 'Verificação de suspensão, barulhos na caixa de direção e fluido CVT.',
    },
    {
      'title': 'Checklist de Viagem de Férias',
      'author': 'Oficina Mecânica Express',
      'carModel': 'Todos os Veículos',
      'isPublic': true,
      'likes': 95,
      'description': 'Calibragem, nível de arrefecimento, palhetas e kit de emergência.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Templates da Comunidade'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: Colors.blue.shade50,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  const Icon(Icons.public, color: Colors.blue, size: 32),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Checklists Públicos para $_currentCarModel',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Aqui aparecem todas as listas compartilhadas publicamente pelos proprietários.',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Disponíveis para Importar',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 10),
          ..._communityTemplates.map((template) {
            final String title = template['title'].toString();
            final String author = template['author'].toString();
            final String carModel = template['carModel'].toString();
            final String description = template['description'].toString();
            final int likes = (template['likes'] as num).toInt();

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Chip(
                          label: Text(carModel, style: const TextStyle(fontSize: 11)),
                          backgroundColor: Colors.blue.shade100,
                          visualDensity: VisualDensity.compact,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.thumb_up_alt_outlined, size: 16, color: Colors.blue),
                            const SizedBox(width: 4),
                            Text('$likes', style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(color: Colors.grey.shade800, fontSize: 13),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Por $author',
                          style: const TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Checklist "$title" importado para o seu veículo!')),
                            );
                          },
                          icon: const Icon(Icons.download, size: 16),
                          label: const Text('Importar'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}