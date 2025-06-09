import 'package:flutter/material.dart';

class ProfileTeacherPage extends StatelessWidget {
  
  
  final String email;
  final String userType;
  
  final List<Map<String, String>> clases = List.generate(5, (index) => {
        "titulo": "Introducción a la programación Web",
        "hora": "Lunes, 4:00 pm",
        "inscritos": "36 Inscritos",
      });

  ProfileTeacherPage({super.key, required this.email, required this.userType});

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
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Jose F.\nCalderon',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Colombia',
                      style: TextStyle(color: Colors.black54),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber),
                        Icon(Icons.star, color: Colors.amber),
                        Icon(Icons.star, color: Colors.amber),
                        Icon(Icons.star_border, color: Colors.grey),
                        Icon(Icons.star_border, color: Colors.grey),
                      ],
                    )
                  ],
                )
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
                      Tab(text: 'Cursos'),
                      Tab(text: 'Habilidades'),
                      Tab(text: 'Comentarios'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Clases programadas',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...clases.map((clase) => ClaseCard(clase: clase)).toList()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ClaseCard extends StatelessWidget {
  final Map<String, String> clase;

  const ClaseCard({super.key, required this.clase});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            clase['titulo']!,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                clase['inscritos']!,
                style: const TextStyle(color: Colors.green, fontSize: 14),
              ),
              Row(
                children: [
                  Text(
                    clase['hora']!,
                    style: const TextStyle(
                        color: Colors.teal, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {},
                    child: const Text('Editar'),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
