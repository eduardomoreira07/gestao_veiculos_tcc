import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _userName = 'João Silva';
  String _userEmail = 'joao.silva@email.com';
  String _selectedVehicle = 'Honda Civic (ABC-1234)';

  final List<String> _vehicles = [
    'Honda Civic (ABC-1234)',
    'VW Gol 1.0 (XYZ-9876)',
    'Fiat Uno (MNO-5544)',
  ];

  void _showEditProfileDialog() {
    final nameController = TextEditingController(text: _userName);
    final emailController = TextEditingController(text: _userEmail);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar Perfil'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'E-mail'),
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
                setState(() {
                  _userName = nameController.text;
                  _userEmail = emailController.text;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Perfil atualizado com sucesso!')),
                );
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _showAddVehicleDialog() {
    final brandController = TextEditingController();
    final modelController = TextEditingController();
    final plateController = TextEditingController();
    final yearController = TextEditingController();
    String selectedOwnerCount = '1º Dono';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Cadastrar Novo Veículo'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: brandController,
                      decoration: const InputDecoration(
                        labelText: 'Marca',
                        hintText: 'Ex: Toyota, Ford',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: modelController,
                      decoration: const InputDecoration(
                        labelText: 'Modelo',
                        hintText: 'Ex: Corolla, Onix',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: plateController,
                      decoration: const InputDecoration(
                        labelText: 'Placa',
                        hintText: 'Ex: BRA2E19',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: yearController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Ano de Fabricação',
                        hintText: 'Ex: 2023',
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: selectedOwnerCount,
                      decoration: const InputDecoration(
                        labelText: 'Proprietário',
                      ),
                      items: const [
                        DropdownMenuItem(value: '1º Dono', child: Text('1º Dono (Único Dono)')),
                        DropdownMenuItem(value: '2º Dono', child: Text('2º Dono')),
                        DropdownMenuItem(value: '3º Dono', child: Text('3º Dono')),
                        DropdownMenuItem(value: '4º Dono ou +', child: Text('4º Dono ou mais')),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setDialogState(() => selectedOwnerCount = value);
                        }
                      },
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
                    if (modelController.text.isNotEmpty && plateController.text.isNotEmpty) {
                      final newVehicleName = '${brandController.text} ${modelController.text} (${plateController.text.toUpperCase()})'.trim();
                      
                      setState(() {
                        _vehicles.add(newVehicleName);
                        _selectedVehicle = newVehicleName;
                      });

                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Veículo "$newVehicleName" ($selectedOwnerCount) cadastrado!')),
                      );
                    }
                  },
                  child: const Text('Cadastrar'),
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
        title: const Text('Meu Perfil'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Stack(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      iconSize: 18,
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: _showEditProfileDialog,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _userName,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            _userEmail,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 12),
          const Text(
            'Veículo Ativo',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedVehicle,
                  isExpanded: true,
                  icon: const Icon(Icons.directions_car),
                  items: _vehicles.map((String vehicle) {
                    return DropdownMenuItem<String>(
                      value: vehicle,
                      child: Text(
                        vehicle,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedVehicle = newValue;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Veículo alternado para: $newValue')),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          ListTile(
            leading: const Icon(Icons.add_circle_outline, color: Colors.blue),
            title: const Text('Cadastrar Novo Veículo'),
            trailing: const Icon(Icons.chevron_right),
            onTap: _showAddVehicleDialog,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Sair da Conta', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
    );
  }
}