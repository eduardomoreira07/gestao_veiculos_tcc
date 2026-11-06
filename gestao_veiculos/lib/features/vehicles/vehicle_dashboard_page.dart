import 'package:flutter/material.dart';
import 'checklist_page.dart';
import 'debts_page.dart';
import 'transfer_page.dart';
import 'esthetic_history_page.dart';
import 'profile_page.dart';
import 'templates_page.dart';

class VehicleDashboardPage extends StatelessWidget {
  final String vehicleId;
  const VehicleDashboardPage({super.key, required this.vehicleId});

  @override
  Widget build(BuildContext context) {
    const String plate = 'ABC-1234';
    const String brand = 'Honda';
    const String model = 'Civic';
    const int year = 2022;
    const num km = 45000;
    const int ownersCount = 1;
    const int pendingDebtsCount = 2;
    const int paidDebtsCount = 4;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Veículo'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, size: 28),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future<void>.delayed(const Duration(milliseconds: 300));
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const _VehicleHeader(
              plate: plate,
              brand: brand,
              model: model,
              year: year,
              km: km,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Proprietários',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '$ownersCountº dono',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 6),
                          const Text('Atualiza automaticamente após transferência'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Card(
                    color: Colors.blue.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Débitos Pendentes',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            pendingDebtsCount.toString(),
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Card(
                    color: Colors.green.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Débitos Pagos',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            paidDebtsCount.toString(),
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Atalhos',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            _QuickActionsGrid(
             onOpenTemplates: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const TemplatesPage()),
                );
              },
              onOpenChecklists: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ChecklistPage()),
                );
              },
              onOpenEstheticHistory: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const EstheticHistoryPage()),
                );
              },
              onOpenDebts: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const DebtsPage()),
                );
              },
              onOpenTransfer: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const TransferPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _VehicleHeader extends StatelessWidget {
  final String plate;
  final String brand;
  final String model;
  final int year;
  final num km;

  const _VehicleHeader({
    required this.plate,
    required this.brand,
    required this.model,
    required this.year,
    required this.km,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.blue.shade100,
              child: Text(
                plate.isNotEmpty ? plate[0].toUpperCase() : 'V',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plate,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text('$year • $brand $model'),
                  const SizedBox(height: 6),
                  Text('KM atual: ${km.toString()} km'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionsGrid extends StatelessWidget {
  final VoidCallback onOpenTemplates;
  final VoidCallback onOpenChecklists;
  final VoidCallback onOpenEstheticHistory;
  final VoidCallback onOpenDebts;
  final VoidCallback onOpenTransfer;

  const _QuickActionsGrid({
    required this.onOpenTemplates,
    required this.onOpenChecklists,
    required this.onOpenEstheticHistory,
    required this.onOpenDebts,
    required this.onOpenTransfer,
  });

  @override
  Widget build(BuildContext context) {
    Widget tile(String title, IconData icon, VoidCallback onTap, {Color? color}) {
      return InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: color ?? Colors.grey.shade100,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 26),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      );
    }

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.25,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: [
        tile('Templates', Icons.library_books_outlined, onOpenTemplates, color: Colors.orange.shade50),
        tile('Checklists', Icons.checklist_rtl_outlined, onOpenChecklists, color: Colors.blue.shade50),
        tile('Histórico', Icons.history_edu_outlined, onOpenEstheticHistory, color: Colors.purple.shade50),
        tile('Financeiro', Icons.receipt_long_outlined, onOpenDebts, color: Colors.green.shade50),
        tile('Transferir', Icons.qr_code_scanner_outlined, onOpenTransfer, color: Colors.red.shade50),
        tile('Adicionar', Icons.add_circle_outline, () {}, color: Colors.grey.shade200),
      ],
    );
  }
}