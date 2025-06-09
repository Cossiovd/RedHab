import 'package:flutter/material.dart';
import './pages/welcome.dart';
import './pages/login.dart';
import './pages/register.dart';
import './pages/home.dart';
import './pages/classDetail.dart';
import './pages/profileStudent.dart';
import './pages/profileTeacher.dart';
import './pages/createClass.dart';
import 'widgets/classitem.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RedHab',
      debugShowCheckedModeBanner: false,
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => WelcomePage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/createclass': (context) => CreateClassPage(),
      },
      onGenerateRoute: (settings) {
        // Manejo de rutas con parámetros
        switch (settings.name) {
          case '/home':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => HomePage(
                email: args['email'],
                userType: args['userType'],
              ),
            );
            
          case '/profilestudent':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => ProfileStudentPage(
                email: args['email'],
                userType: args['userType'], userData: {},
              ),
            );
            
          case '/profileteacher':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => ProfileTeacherPage(
                email: args['email'],
                userType: args['userType'],
              ),
            );
            
          case '/classDetail':
            final classItem = settings.arguments as ClassItem;
            return MaterialPageRoute(
              builder: (context) => ClassDetailPage(classItem: classItem),
            );
            
          default:
            return null;
        }
      },
    );
  }
}