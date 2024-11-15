import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class UserRegistrationScreen extends StatefulWidget {
  const UserRegistrationScreen({super.key});

  @override
  _UserRegistrationScreenState createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cpfController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _cnsController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _addressController = TextEditingController();
  String? _selectedUnit;

  final List<String> _healthUnits = [
    'Centro-Vila', 'Fazenda', 'Praia Brava', 'Bambuzal', 'Imaruí', 'São João I',
    'São João II', 'Cidade Nova I', 'Cidade Nova II', 'Promorar II', 'Rio Bonito',
    'São Vicente', 'Canhanduba', 'Itaipava', 'Limoeiro', 'Parque do Agricultor',
    'Cordeiros', 'Costa Cavalcante', 'Jardim Esperança', 'Murta', 'Votorantim',
    'Espinheiros', 'Salseiros', 'Santa Regina', 'Nossa Senhora das Graças',
    'Cabeçudas', 'São Judas', 'Brilhante', 'Portal II', 'São Roque'
  ];

  void _registerUser(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      final user = {
        'name': _nameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        'cpf': _cpfController.text,
        'birth_date': _birthDateController.text,
        'phone': _phoneController.text,
        'cns': _cnsController.text,
        'address': _addressController.text,
        'health_unit': _selectedUnit,
      };

      final success = await authProvider.registerUser(user);

      if (success) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuário registrado com sucesso!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Falha ao registrar o usuário.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Usuário'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 24),
              Icon(
                Icons.person_add,
                color: Theme.of(context).primaryColor,
                size: 80,
              ),
              const SizedBox(height: 24),
              const Text(
                'Registrar Novo Usuário',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),

              _buildTextField(
                controller: _nameController,
                labelText: 'Nome Completo',
                icon: Icons.person,
                validator: (value) =>
                value == null || value.isEmpty ? 'Insira seu nome completo' : null,
              ),
              _buildTextField(
                controller: _birthDateController,
                labelText: 'Data de Nascimento',
                icon: Icons.cake,
                keyboardType: TextInputType.datetime,
                validator: (value) =>
                value == null || value.isEmpty ? 'Insira sua data de nascimento' : null,
              ),
              _buildTextField(
                controller: _cpfController,
                labelText: 'CPF',
                icon: Icons.credit_card,
                keyboardType: TextInputType.number,
                validator: (value) =>
                value == null || value.isEmpty ? 'Insira seu CPF' : null,
              ),
              _buildTextField(
                controller: _phoneController,
                labelText: 'Telefone',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              _buildTextField(
                controller: _emailController,
                labelText: 'E-mail',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                value == null || value.isEmpty ? 'Insira seu e-mail' : null,
              ),
              _buildTextField(
                controller: _cnsController,
                labelText: 'Cartão SUS (CNS)',
                icon: Icons.card_membership,
              ),
              _buildTextField(
                controller: _addressController,
                labelText: 'Endereço',
                icon: Icons.home,
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: _selectedUnit,
                decoration: InputDecoration(
                  labelText: 'Unidade Básica de Saúde',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: _healthUnits.map((String unit) {
                  return DropdownMenuItem<String>(
                    value: unit,
                    child: Text(unit),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedUnit = value;
                  });
                },
                validator: (value) =>
                value == null ? 'Selecione uma unidade de saúde' : null,
              ),
              const SizedBox(height: 16),

              _buildTextField(
                controller: _passwordController,
                labelText: 'Senha',
                icon: Icons.lock,
                obscureText: true,
                validator: (value) =>
                value == null || value.length < 6 ? 'A senha deve ter pelo menos 6 caracteres' : null,
              ),
              _buildTextField(
                controller: _confirmPasswordController,
                labelText: 'Confirmar Senha',
                icon: Icons.lock_outline,
                obscureText: true,
                validator: (value) =>
                value != _passwordController.text ? 'As senhas não coincidem' : null,
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _registerUser(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Registrar',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          prefixIcon: Icon(icon),
        ),
        validator: validator,
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cpfController.dispose();
    _birthDateController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _cnsController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
