import 'package:flutter/material.dart';
import '../widgets/classitem.dart';

class ClassDetailPage extends StatelessWidget {
  final ClassItem classItem;

  const ClassDetailPage({Key? key, required this.classItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(classItem.title)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  classItem.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 220,
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      classItem.category,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person, size: 24.0, color: Colors.grey),
                      SizedBox(width: 8),
                      Text(
                        classItem.teacher,
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    childAspectRatio: 2,
                    children: [
                      _infoCard(
                        icon: Icons.schedule,
                        iconBg: Color(0xFFD8E9FF),
                        iconColor: Colors.blue,
                        title: "Fecha y hora",
                        subtitle: classItem.schedule,
                      ),
                      _infoCard(
                        icon: Icons.location_on,
                        iconBg: Color(0xFFE8D6F7),
                        iconColor: Colors.purple,
                        title: "Ubicación",
                        subtitle: classItem.location,
                      ),
                      _infoCard(
                        icon: Icons.attach_money,
                        iconBg: Color(0xFFD8F0DD),
                        iconColor: Colors.green,
                        title: "Precio",
                        subtitle: classItem.price,
                      ),
                      _infoCard(
                        icon: Icons.groups,
                        iconBg: Color(0xFFEAEEDD),
                        iconColor: Colors.grey.shade700,
                        title: "Participantes",
                        subtitle:
                            "${classItem.participants} / ${classItem.capacity}",
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text(
                    "Descripción",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 6),
                  Text(classItem.description),
                  SizedBox(height: 16),
                  Text(
                    "Lo que aprenderás",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  ..._buildLearningItems(classItem.learnings),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Inscripción exitosa"),
                duration: Duration(seconds: 2),
              ),
            );
            Future.delayed(Duration(seconds: 2), () {
              Navigator.of(context).pushReplacementNamed('/home');
            });
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Colors.blue, // Color del botón
          ),
          child: Text( "Inscribirme a la clase",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xF0F2F9FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: iconColor),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                SizedBox(height: 4),
                Text(subtitle,
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildLearningItems(List<String> learnings) {
    return learnings.map((item) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 20),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                item,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}
