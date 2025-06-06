import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../widgets/ClassCard.dart';
import '../widgets/classitem.dart'; // Asegúrate de que esta clase tenga el método fromJson
//import 'classDetail.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<ClassItem>> futureClasses;

  Future<List<ClassItem>> loadClasses() async {
    final jsonString = await rootBundle.loadString('assets/data/classes.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((data) => ClassItem.fromJson(data)).toList();
  }

  @override
  void initState() {
    super.initState();
    futureClasses = loadClasses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Explorar',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.blue),
            onPressed: () {},
          ),
          const Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.png'),
              radius: 18,
            ),
          ),
        ],
      ),
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
            Row(
              children: [
                FilterChip(
                  label: Text("Todos"),
                  selected: true,
                  onSelected: (_) {},
                ),
                SizedBox(width: 8),
                FilterChip(
                  label: Text("Idiomas"),
                  selected: false,
                  onSelected: (_) {},
                ),
                SizedBox(width: 8),
                FilterChip(
                  label: Text("Musica"),
                  selected: false,
                  onSelected: (_) {},
                ),
                SizedBox(width: 8),
                FilterChip(
                  label: Text("Tecnología"),
                  selected: false,
                  onSelected: (_) {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Destacado',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: FutureBuilder<List<ClassItem>>(
                future: futureClasses,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error al cargar los datos'));
                  } else {
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
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
