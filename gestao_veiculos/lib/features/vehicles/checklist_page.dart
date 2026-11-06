import 'package:flutter/material.dart';

class ChecklistPage extends StatefulWidget {
  const ChecklistPage({super.key});

  @override
  State<ChecklistPage> createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List _checklistItems = [
    {
      'title': 'Nível de Óleo do Motor',
      'category': 'Diário',
      'status': 'OK',
      'durability': 'Checar a frio',
      'notify': true,
      'isPublic': true,
      'isVideoPublic': true,
      'videoUrl': 'https://youtube.com/watch?v=exemplo_oleo',
    },
    {
      'title': 'Pressão dos Pneus',
      'category': 'Semanal',
      'status': 'Alerta',
      'durability': 'Calibrar 30 PSI',
      'notify': true,
      'isPublic': false,
      'isVideoPublic': false,
      'videoUrl': 'https://youtube.com/watch?v=exemplo_pneus',
    },
    {
      'title': 'Líquido de Arrefecimento',
      'category': 'Mensal',
      'status': 'OK',
      'durability': 'Reservatório de expansão',
      'notify': false,
      'isPublic': true,
      'isVideoPublic': true,
      'videoUrl': 'https://youtube.com/watch?v=exemplo_radiador',
    },
    {
      'title': 'Troca de Pastilhas de Freio',
      'category': 'Por KM',
      'status': 'Critico',
      'durability': 'A cada 20.000 km',
      'notify': true,
      'isPublic': false,
      'isVideoPublic': false,
      'videoUrl': 'https://youtube.com/watch?v=exemplo_freios',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'OK':
        return Colors.green;
      case 'Alerta':
        return Colors.orange;
      case 'Critico':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showTutorialDialog(Map item) {
    final bool isVideoPublic = item['isVideoPublic'] == true;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.play_circle_fill, color: Colors.red),
              const SizedBox(width: 8),
              Expanded(child: Text(item['title'].toString())),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.play_arrow, size: 50, color: Colors.white),
                    const SizedBox(height: 8),
                    Text(
                      isVideoPublic ? 'Vídeo Tutorial Público' : 'Vídeo Privado (Seu Uso)',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      isVideoPublic ? 'Visível para a comunidade' : 'Apenas no seu perfil',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Link: ${item['videoUrl']}',
                style: const TextStyle(fontSize: 12, color: Colors.blue),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    isVideoPublic ? Icons.public : Icons.lock_outline,
                    size: 16,
                    color: isVideoPublic ? Colors.green : Colors.orange,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    isVideoPublic ? 'Tutorial compartilhado' : 'Tutorial privado',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isVideoPublic ? Colors.green : Colors.orange,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  void _showAddItemDialog() {
    final titleController = TextEditingController();
    final durabilityController = TextEditingController();
    final videoController = TextEditingController();
    String selectedCategory = 'Diário';
    String selectedStatus = 'OK';
    bool enableNotification = true;
    bool isPublic = true;
    bool isVideoPublic = true;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Novo Checklist & Vídeo'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Nome do Item',
                        hintText: 'Ex: Troca de Óleo',
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      initialValue: selectedCategory,
                      decoration: const InputDecoration(labelText: 'Frequência'),
                      items: const [
                        DropdownMenuItem(value: 'Diário', child: Text('Diário')),
                        DropdownMenuItem(value: 'Semanal', child: Text('Semanal')),
                        DropdownMenuItem(value: 'Mensal', child: Text('Mensal')),
                        DropdownMenuItem(value: 'Por KM', child: Text('Por Quilometragem')),
                      ],
                      onChanged: (val) {
                        if (val != null) {
                          setDialogState(() => selectedCategory = val);
                        }
                      },
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: durabilityController,
                      decoration: const InputDecoration(
                        labelText: 'Regra / KM / Intervalo',
                        hintText: 'Ex: 10.000 km ou 6 meses',
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: videoController,
                      decoration: const InputDecoration(
                        labelText: 'Link do Vídeo Tutorial',
                        hintText: 'https://youtube.com/...',
                      ),
                    ),
                    const SizedBox(height: 12),
                    SwitchListTile(
                      title: const Text('Ativar Notificações'),
                      value: enableNotification,
                      onChanged: (val) => setDialogState(() => enableNotification = val),
                      contentPadding: EdgeInsets.zero,
                    ),
                    SwitchListTile(
                      title: const Text('Checklist Público'),
                      subtitle: const Text('Exibir item em Templates Comunitários'),
                      value: isPublic,
                      onChanged: (val) => setDialogState(() => isPublic = val),
                      contentPadding: EdgeInsets.zero,
                    ),
                    SwitchListTile(
                      title: const Text('Vídeo/Tutorial Público'),
                      subtitle: const Text('Permitir que outros assistam'),
                      value: isVideoPublic,
                      onChanged: (val) => setDialogState(() => isVideoPublic = val),
                      contentPadding: EdgeInsets.zero,
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
                        _checklistItems.add({
                          'title': titleController.text,
                          'category': selectedCategory,
                          'status': selectedStatus,
                          'durability': durabilityController.text.isEmpty
                              ? 'Não especificado'
                              : durabilityController.text,
                          'notify': enableNotification,
                          'isPublic': isPublic,
                          'isVideoPublic': isVideoPublic,
                          'videoUrl': videoController.text.isEmpty
                              ? 'https://youtube.com/tutorial'
                              : videoController.text,
                        });
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Checklist e tutorial salvos!')),
                      );
                    }
                  },
                  child: const Text('Salvar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checklist & Guia'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Diário'),
            Tab(text: 'Semanal'),
            Tab(text: 'Mensal'),
            Tab(text: 'Por KM'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCategoryList('Diário'),
          _buildCategoryList('Semanal'),
          _buildCategoryList('Mensal'),
          _buildCategoryList('Por KM'),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddItemDialog,
        icon: const Icon(Icons.add),
        label: const Text('Novo Checklist'),
      ),
    );
  }

  Widget _buildCategoryList(String category) {
    final filtered = _checklistItems.where((item) => item['category'] == category).toList();

    if (filtered.isEmpty) {
      return Center(
        child: Text('Nenhum item cadastrado em "$category"'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final item = filtered[index];
        final String title = item['title'].toString();
        final String status = item['status'].toString();
        final String durability = item['durability'].toString();
        final bool notify = item['notify'] == true;
        final bool isPublic = item['isPublic'] == true;
        final Color statusColor = _getStatusColor(status);

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ExpansionTile(
            leading: CircleAvatar(
              backgroundColor: statusColor.withValues(alpha: 0.2),
              child: Icon(
                status == 'OK'
                    ? Icons.check_circle
                    : status == 'Alerta'
                        ? Icons.warning
                        : Icons.error,
                color: statusColor,
              ),
            ),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                if (isPublic)
                  const Chip(
                    label: Text('Público', style: TextStyle(fontSize: 10, color: Colors.white)),
                    backgroundColor: Colors.blue,
                    visualDensity: VisualDensity.compact,
                  ),
              ],
            ),
            subtitle: Text('Validade/Regra: $durability'),
            trailing: IconButton(
              icon: Icon(
                notify ? Icons.notifications_active : Icons.notifications_off,
                color: notify ? Colors.blue : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  item['notify'] = !notify;
                });
              },
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _showTutorialDialog(item),
                      icon: const Icon(Icons.ondemand_video, color: Colors.white),
                      label: const Text('Ver Tutorial'),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          if (item['status'] == 'OK') {
                            item['status'] = 'Alerta';
                          } else if (item['status'] == 'Alerta') {
                            item['status'] = 'Critico';
                          } else {
                            item['status'] = 'OK';
                          }
                        });
                      },
                      icon: const Icon(Icons.refresh),
                      label: Text('Status: $status'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}