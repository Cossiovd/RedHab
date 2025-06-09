import 'package:flutter/material.dart';

class CustomMenu extends StatelessWidget {
  final String email;
  final String userType;
  final String avatarPath;
  final Function(String) onSelected;

  const CustomMenu({
    Key? key,
    required this.email,
    required this.userType,
    required this.avatarPath,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      itemBuilder: (context) => [
        // Header con avatar
        PopupMenuItem<String>(
          enabled: false,
          height: 100,
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(avatarPath),
                radius: 30,
              ),
              const SizedBox(height: 8),
              Text(
                email,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                userType == 'teacher' ? 'Profesor' : 'Estudiante',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        // Opciones del menú
        const PopupMenuItem<String>(
          value: 'profile',
          child: ListTile(
            leading: Icon(Icons.person),
            title: Text('Mi perfil'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'home',
          child: ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'settings',
          child: ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configuración'),
          ),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem<String>(
          value: 'logout',
          child: ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.red),
            title: Text('Cerrar sesión', style: TextStyle(color: Colors.red)),
          ),
        ),
      ],
      onSelected: onSelected,
      child: Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: CircleAvatar(
          backgroundImage: AssetImage(avatarPath),
          radius: 18,
        ),
      ),
    );
  }
}