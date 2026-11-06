import 'package:flutter/material.dart';

class DebtsPage extends StatefulWidget {
  const DebtsPage({super.key});

  @override
  State<DebtsPage> createState() => _DebtsPageState();
}

class _DebtsPageState extends State<DebtsPage> {
  final _debts = [
    {
      'title': 'IPVA 2026 - Cota Única',
      'amount': 1250.00,
      'status': 'Pendente',
      'date': '15/03/2026'
    },
    {
      'title': 'Licenciamento Anual',
      'amount': 160.00,
      'status': 'Pendente',
      'date': '30/04/2026'
    },
    {
      'title': 'Seguro DPVAT',
      'amount': 85.50,
      'status': 'Pago',
      'date': '10/01/2026'
    },
  ];

  void _showAddDebtDialog() {
    final titleController = TextEditingController();
    final amountController = TextEditingController();
    final dateController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Adicionar Débito / Custo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Descrição do Custo',
                  hintText: 'Ex: Multa de Trânsito',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Valor (R\$)',
                  hintText: '0.00',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: dateController,
                decoration: const InputDecoration(
                  labelText: 'Data de Vencimento',
                  hintText: 'Ex: 20/12/2026',
                ),
              ),
            ],
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
                    _debts.insert(0, {
                      'title': titleController.text,
                      'amount': double.tryParse(amountController.text) ?? 0.0,
                      'status': 'Pendente',
                      'date': dateController.text.isEmpty
                          ? 'A definir'
                          : dateController.text,
                    });
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Débito adicionado com sucesso!')),
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
        title: const Text('Financeiro & Débitos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddDebtDialog,
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _debts.length,
        itemBuilder: (context, index) {
          final debt = _debts[index];
          final String title = debt['title']?.toString() ?? 'Sem título';
          final double amount = (debt['amount'] as num?)?.toDouble() ?? 0.0;
          final String status = debt['status']?.toString() ?? 'Pendente';
          final String date = debt['date']?.toString() ?? '';
          final bool isPaid = status == 'Pago';

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: isPaid ? Colors.green.shade100 : Colors.orange.shade100,
                child: Icon(
                  isPaid ? Icons.check_circle : Icons.pending_actions,
                  color: isPaid ? Colors.green : Colors.orange,
                ),
              ),
              title: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Vencimento: $date'),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'R\$ ${amount.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: isPaid ? Colors.green : Colors.red,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isPaid ? Colors.green : Colors.orange,
                    ),
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  debt['status'] = isPaid ? 'Pendente' : 'Pago';
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddDebtDialog,
        icon: const Icon(Icons.add),
        label: const Text('Novo Débito'),
        backgroundColor: Colors.green,
      ),
    );
  }
}