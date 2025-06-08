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
        //'/home': (context) => HomePage(),
        '/profilestudent': (context) => ProfileStudentPage(),
        '/profileteacher': (context) => ProfileTeacherPage(),
        '/createclass': (context) => CreateClassPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/classDetail') {
          final classItem = settings.arguments as ClassItem;
          return MaterialPageRoute(
            builder: (context) => ClassDetailPage(classItem: classItem),
          );
        } else if(settings.name == '/home'){
          final email = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => HomePage(email: email),
            );
        }
        return null;
      },
    );
  }
}
