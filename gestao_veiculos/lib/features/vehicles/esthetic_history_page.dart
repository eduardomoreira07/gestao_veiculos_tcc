import 'package:flutter/material.dart';

class EstheticHistoryPage extends StatefulWidget {
  const EstheticHistoryPage({super.key});

  @override
  State<EstheticHistoryPage> createState() => _EstheticHistoryPageState();
}

class _EstheticHistoryPageState extends State<EstheticHistoryPage> {
  final _services = [
    {
      'title': 'Lavagem Detalhada + Cera',
      'date': '20/10/2026',
      'cost': 120.00,
      'place': 'Lava Rápido AutoBrilho',
      'icon': Icons.local_car_wash,
    },
    {
      'title': 'Higienização Interna dos Bancos',
      'date': '15/08/2026',
      'cost': 250.00,
      'place': 'Estética Automotiva VIP',
      'icon': Icons.cleaning_services,
    },
    {
      'title': 'Polimento Técnico e Cristalização',
      'date': '02/05/2026',
      'cost': 450.00,
      'place': 'Detailing Studio',
      'icon': Icons.auto_awesome,
    },
  ];

  void _showAddServiceDialog() {
    final titleController = TextEditingController();
    final placeController = TextEditingController();
    final costController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Novo Serviço Estético'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Descrição do Serviço',
                    hintText: 'Ex: Polimento, Lavagem...',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: placeController,
                  decoration: const InputDecoration(
                    labelText: 'Local / Estabelecimento',
                    hintText: 'Ex: Lava Rápido X',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: costController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Valor (R\$)',
                    hintText: '0.00',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  setState(() {
                    _services.insert(0, {
                      'title': titleController.text,
                      'date': 'Hoje',
                      'cost': double.tryParse(costController.text) ?? 0.0,
                      'place': placeController.text.isEmpty
                          ? 'Não informado'
                          : placeController.text,
                      'icon': Icons.auto_awesome,
                    });
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Serviço adicionado!')),
                  );
                }
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico Estético'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _services.length,
        itemBuilder: (context, index) {
          final service = _services[index];
          final String title = service['title']?.toString() ?? '';
          final String date = service['date']?.toString() ?? '';
          final String place = service['place']?.toString() ?? '';
          final double cost = (service['cost'] as num?)?.toDouble() ?? 0.0;
          final IconData icon = (service['icon'] as IconData?) ?? Icons.build;

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.purple.shade100,
                child: Icon(icon, color: Colors.purple),
              ),
              title: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('$place • $date'),
              trailing: Text(
                'R\$ ${cost.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.purple,
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddServiceDialog,
        icon: const Icon(Icons.add),
        label: const Text('Registar Serviço'),
        backgroundColor: Colors.purple,
      ),
    );
  }
}