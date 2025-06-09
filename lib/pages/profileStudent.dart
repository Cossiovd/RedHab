import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:redhab/pages/menu.dart';

class ProfileStudentPage extends StatelessWidget {
  final String email;
  final String userType;

  final List<Map<String, dynamic>> clases = List.generate(
    4,
    (index) => {
      "titulo": "Introducción a la programación Web",
      "hora": "Lunes, 4:00 pm",
      "progreso": 0.73,
    },
  );

  ProfileStudentPage({
    super.key,
    required this.email,
    required this.userType,
    required Map<String, dynamic> userData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: 
              CustomMenu(
                email: email,
                userType: userType,
                avatarPath: userType == 'teacher'
                    ? 'assets/images/avatar.png'
                    : 'assets/images/avatar.png',
                onSelected: (value) {
                  // Manejar las opciones del menú
                  switch (value) {
                    case 'home':
                      Navigator.pushReplacementNamed(
                        context, '/home',
                        arguments: {'email': email, 'userType': userType},
                      );
                      break;
                    case 'settings':
                      Navigator.pushNamed(context, '/settings');
                      break;
                    case 'logout':
                      _showLogoutDialog(context);
                      break;
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Jose F.\nCalderon',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('RACHA', style: TextStyle(fontWeight: FontWeight.bold)),
            const Text('RACHA ACTUAL', style: TextStyle(color: Colors.black54)),
            const SizedBox(height: 8),
            Row(
              children: const [
                Text(
                  '🔥 43 ',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                Text(
                  'DÍAS',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _DiaItem(dia: 'D', activo: false),
                _DiaItem(dia: 'L', activo: false),
                _DiaItem(dia: 'M', activo: false),
                _DiaItem(dia: 'N', activo: true),
                _DiaItem(dia: 'J', activo: true),
                _DiaItem(dia: 'V', activo: true),
                _DiaItem(dia: 'S', activo: true),
              ],
            ),
            const SizedBox(height: 24),
            DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.black,
                    tabs: const [
                      Tab(text: 'Mi clases'),
                      Tab(text: 'Calificaciones'),
                      Tab(text: 'Progreso'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ...clases.map((clase) => ClaseCard(clase: clase)).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Función para mostrar diálogo de logout
void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Cerrar sesión'),
        content: const Text('¿Estás seguro que deseas cerrar sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: const Text(
              'Cerrar sesión',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}

class _DiaItem extends StatelessWidget {
  final String dia;
  final bool activo;

  const _DiaItem({required this.dia, required this.activo});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          activo ? Icons.flash_on : Icons.flash_off,
          color: activo ? Colors.deepPurple : Colors.black,
        ),
        Text(dia, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class ClaseCard extends StatelessWidget {
  final Map<String, dynamic> clase;

  const ClaseCard({super.key, required this.clase});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  clase['titulo'],
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 16,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      clase['hora'],
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text('INGRESAR'),
                ),
              ],
            ),
          ),
          CircularPercentIndicator(
            radius: 40.0,
            lineWidth: 8.0,
            percent: clase['progreso'],
            center: Text(
              "${(clase['progreso'] * 100).toInt()}%",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            progressColor: Colors.green,
            backgroundColor: Colors.grey[300]!,
            circularStrokeCap: CircularStrokeCap.round,
          ),
        ],
      ),
    );
  }
}
