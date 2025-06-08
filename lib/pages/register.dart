import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'home.dart';
import 'package:flutter/services.dart' show rootBundle;

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? selectedUserType;

  late File jsonFile;

  Future<File> get _localFile async {
    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/users.json';

    final file = File(path);
    if (!(await file.exists())) {
      final data = await rootBundle.loadString('assets/data/users.json');
      await file.writeAsString(data);
    }
    return file;
  }

  Future<void> register() async {
    if (!_formKey.currentState!.validate()) return;

    if (selectedUserType == null) {
      setState(() {});
      return;
    }

    jsonFile = await _localFile;
    final content = await jsonFile.readAsString();
    final List<dynamic> users = json.decode(content);

    final name = nameController.text.trim();
    final lastName = lastNameController.text.trim();
    final age = ageController.text.trim();
    final gender = genderController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final userType = selectedUserType;

    final userExists = users.any((user) => user['email'] == email);
    if (userExists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El correo ya está registrado')),
      );
      return;
    }

    users.add({
      'name': name,
      'lastName': lastName,
      'age': age,
      'gender': gender,
      'email': email,
      'password': password,
      'userType': userType,
    });

    await jsonFile.writeAsString(json.encode(users));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cuenta registrada con éxito')),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomePage(email: email)),
    );
  }

  Widget _buildInputField({
    required String hint,
    required TextEditingController controller,
    bool obscure = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: const Color(0xFFF1F6FF),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        validator: validator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/registericon.png'),
                ),
                const SizedBox(height: 24),
                const Text("Registrarse", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 32),
                _buildInputField(
                  hint: 'Nombre',
                  controller: nameController,
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? 'Por favor ingresa tu nombre'
                      : null,
                ),
                _buildInputField(
                  hint: 'Apellido',
                  controller: lastNameController,
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? 'Por favor ingresa tu apellido'
                      : null,
                ),
                _buildInputField(
                  hint: 'Edad',
                  controller: ageController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return 'Por favor ingresa tu edad';
                    if (int.tryParse(value) == null) return 'La edad debe ser un número';
                    return null;
                  },
                ),
                _buildInputField(
                  hint: 'Género (M/F)',
                  controller: genderController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return 'Por favor ingresa tu género';
                    if (!['M', 'F', 'm', 'f'].contains(value.trim())) return 'Debe ser M o F';
                    return null;
                  },
                ),
                _buildInputField(
                  hint: 'Correo electrónico',
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return 'Por favor ingresa tu correo';
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return 'Correo inválido';
                    return null;
                  },
                ),
                _buildInputField(
                  hint: 'Contraseña',
                  controller: passwordController,
                  obscure: true,
                  validator: (value) =>
                      (value == null || value.trim().isEmpty) ? 'Por favor ingresa una contraseña' : null,
                ),
                const SizedBox(height: 12),
                
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Tipo de usuario',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedUserType = 'student';
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: selectedUserType == 'student'
                                    ? Colors.green
                                    : Colors.grey[300],
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                foregroundColor: selectedUserType == 'student'
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              child: const Text('Estudiante'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedUserType = 'teacher';
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: selectedUserType == 'teacher'
                                    ? Colors.green
                                    : Colors.grey[300],
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                foregroundColor: selectedUserType == 'teacher'
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              child: const Text('Profesor'),
                            ),
                          ),
                        ],
                      ),
                      if (selectedUserType == null)
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Por favor selecciona un tipo de usuario',
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Crear", style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("¿Ya tienes cuenta? Inicia sesión", style: TextStyle(color: Colors.blue)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
