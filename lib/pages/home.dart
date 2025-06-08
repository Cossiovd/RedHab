import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../widgets/ClassCard.dart';
import '../widgets/classitem.dart';


class HomePage extends StatefulWidget {
  final String email;

  HomePage({required this.email});
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<ClassItem>> futureClasses;

  @override
  void initState() {
    super.initState();
    futureClasses = loadClasses();
  }

  Future<List<ClassItem>> loadClasses() async {
    final jsonString = await rootBundle.loadString('assets/data/classes.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((data) => ClassItem.fromJson(data)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Clases disponibles cerca de ti',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 16),
            _buildCategoryChips(),
            const SizedBox(height: 24),
            const Text(
              'Destacado',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildClassList(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Text(
        'Explorar',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.blue),
          onPressed: () {
            // Implementar búsqueda en el futuro
          },
        ),
        const Padding(
          padding: EdgeInsets.only(right: 12.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/avatar.png'),
            radius: 18,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFilterChip("Todos", selected: true),
          _buildFilterChip("Idiomas"),
          _buildFilterChip("Música"),
          _buildFilterChip("Tecnología"),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, {bool selected = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) {}, // Se puede implementar filtrado por categoría
        showCheckmark: false,
        selectedColor: Colors.blueAccent,
        backgroundColor: Colors.grey.shade200,
        labelStyle: TextStyle(color: selected ? Colors.white : Colors.black),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(color: Colors.blue),
        ),
      ),
    );
  }

  Widget _buildClassList() {
    return Expanded(
      child: FutureBuilder<List<ClassItem>>(
        future: futureClasses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los datos'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay clases disponibles.'));
          }

          final classes = snapshot.data!;
          return ListView.builder(
            itemCount: classes.length,
            itemBuilder: (context, index) {
              final item = classes[index];
              return ClassCard(
                title: item.title,
                teacher: item.teacher,
                schedule: item.schedule,
                imagePath: item.image,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/classDetail',
                    arguments: item,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
