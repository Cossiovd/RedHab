// pages/class_detail.dart
import 'package:flutter/material.dart';
import '../widgets/classitem.dart';

class ClassDetailPage extends StatelessWidget {
  final ClassItem classItem;

  const ClassDetailPage({Key? key, required this.classItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(classItem.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(classItem.image),
            SizedBox(height: 16),
            Text(
              classItem.teacher,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("Horario: ${classItem.schedule}"),
            SizedBox(height: 8),
            Text("location: ${classItem.location}"),
          ],
        ),
      ),
    );
  }
}
