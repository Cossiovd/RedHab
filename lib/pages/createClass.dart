import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateClassPage extends StatefulWidget {
  @override
  State<CreateClassPage> createState() => _CreateClassPage();
}

class _CreateClassPage extends State<CreateClassPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _fecha;
  TimeOfDay? _hora;

  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _alumnosController = TextEditingController();
  final TextEditingController _ubicacionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Crear nueva clase',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                )
              ],
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(24),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(_tituloController, 'Título de la clase'),
                    const SizedBox(height: 10),
                    _buildTextField(_categoriaController, 'Categoría'),
                    const SizedBox(height: 10),
                    _buildTextField(_descripcionController, 'Descripción',
                        maxLines: 5),
                    const SizedBox(height: 10),
                    _buildDatePicker(context),
                    const SizedBox(height: 10),
                    _buildTimePicker(context),
                    const SizedBox(height: 10),
                    _buildTextField(_alumnosController, 'Cantidad Alumnos',
                        keyboardType: TextInputType.number),
                    const SizedBox(height: 10),
                    _buildTextField(_ubicacionController, 'Ubicación'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Lógica de publicación
                        }
                      },
                      child: const Text('Publicar Clase'),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint,
      {int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.blue[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) =>
          value == null || value.isEmpty ? 'Campo requerido' : null,
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        hintText: _fecha == null
            ? 'Fecha'
            : DateFormat('dd/MM/yyyy').format(_fecha!),
        prefixIcon: const Icon(Icons.calendar_today),
        filled: true,
        fillColor: Colors.blue[50],
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2024),
          lastDate: DateTime(2030),
        );
        if (picked != null) {
          setState(() {
            _fecha = picked;
          });
        }
      },
    );
  }

  Widget _buildTimePicker(BuildContext context) {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        hintText:
            _hora == null ? 'Hora' : _hora!.format(context),
        prefixIcon: const Icon(Icons.access_time),
        filled: true,
        fillColor: Colors.blue[50],
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
      onTap: () async {
        final TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (picked != null) {
          setState(() {
            _hora = picked;
          });
        }
      },
    );
  }
}
