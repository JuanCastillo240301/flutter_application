import 'package:flutter/material.dart';
import 'package:flutter_application_3/screens/firebase/email.auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final conNameUser = TextEditingController();
  final conEmailUser = TextEditingController();
  final conPassUser = TextEditingController();
  final emailAith = mailAuth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register a user'),
      ),
      body: Column(
        children: [
          TextField(
            controller: conNameUser,
          ),
          TextField(
            controller: conEmailUser,
          ),
          TextField(
            controller: conPassUser,
          ),
          ElevatedButton(
              onPressed: () {
                var email = conEmailUser.text;
                var pass = conPassUser.text;
                emailAith.createUSer(emailUser: email, passUser: pass);
              },
              child: Text('Save User'))
        ],
      ),
    );
  }
}
