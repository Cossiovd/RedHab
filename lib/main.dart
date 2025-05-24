import 'package:flutter/material.dart';

void main() {
  runApp(RedHabApp());
}

class RedHabApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RedHab',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF6FF), // fondo claro
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.menu_book, size: 80, color: Colors.blue),
              const SizedBox(height: 16),
              const Text(
                'RedHab',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Intercambia conocimientos y aprende\nnuevas habilidades en tu comunidad',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/welcome.jpg', // asegúrate que esta ruta coincida
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 24),
              InfoTile(icon: Icons.search, text: 'Descubre clases cerca de ti'),
              InfoTile(icon: Icons.group, text: 'Conecta con personas que comparten tus intereses'),
              InfoTile(icon: Icons.share, text: 'Comparte tus conocimientos y aprende algo nuevo'),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Aquí puedes navegar a otra pantalla
                },
                child: const Text('Comenzar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoTile({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(text),
    );
  }
}
