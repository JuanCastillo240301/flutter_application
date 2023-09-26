import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [Fondo(), Contenido()],
      ),
    );
  }
}

class Contenido extends StatefulWidget {
  const Contenido({Key? key}) : super(key: key);

  @override
  State<Contenido> createState() => _ContenidoState();
}

class _ContenidoState extends State<Contenido> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Login',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          SizedBox(height: 5,),
          Text(
            'Bienvenido',
            style: const TextStyle(
              color: Colors.white,
              letterSpacing: 1.5,
              fontSize: 10,
            ),
          ),
          SizedBox(height: 5,),
          Datos(
            emailController: emailController,
            passwordController: passwordController,
          ),
        ],
      ),
    );
  }
}

class Datos extends StatefulWidget {
  const Datos({Key? key, required this.emailController, required this.passwordController})
      : super(key: key);

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<Datos> createState() => _DatosState();
}

class _DatosState extends State<Datos> {
  bool obs = true;

  bool isEmailValid(String email) {
    final emailRegExp =
        RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    return emailRegExp.hasMatch(email);
  }

  bool isPasswordValid(String password) {
    final passwordRegExp = RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");

    return passwordRegExp.hasMatch(password);
  }

  void _login() {
    final String email = widget.emailController.text.trim();
    final String password = widget.passwordController.text.trim();

    if (email.isEmpty) {
      _showToast('Ingrese su correo electrónico');
      return;
    }

    if (!isEmailValid(email)) {
      _showToast('Ingrese un correo electrónico válido');
      return;
    }

    if (password.isEmpty) {
      _showToast('Ingrese su contraseña');
      return;
    }

    if (!isPasswordValid(password)) {
      _showToast(
          'La contraseña debe contener al menos 8 caracteres, incluyendo letras y números');
      return;
    }

    // Puedes agregar aquí la lógica de autenticación
    // ...

    // Si la autenticación es exitosa, redirige al dashboard
    Navigator.pushNamed(context, '/dash');
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Email',
            style: TextStyle(
                color: Colors.red,
                fontSize: 25.0,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5,),
          TextFormField(
            controller: widget.emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'example@mail.com',
              hintStyle: TextStyle(color: Colors.red.shade300),
              labelStyle: TextStyle(color: Colors.red),
            ),
            style: TextStyle(color: Colors.red),
          ),
          const SizedBox(height: 5,),
          const Text(
            'Password',
            style: TextStyle(
                color: Colors.red,
                fontSize: 25.0,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5,),
          TextField(
            obscureText: obs,
            controller: widget.passwordController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: 'Password here',
              hintStyle: TextStyle(color: Colors.red.shade300),
              labelStyle: TextStyle(color: Colors.red),
              suffixIcon: IconButton(
                icon: const Icon(Icons.remove_red_eye_outlined),
                onPressed: () {
                  setState(() {
                    obs = !obs;
                  });
                },
              ),
            ),
            style: TextStyle(color: Colors.red),
          ),
          const Remember(),
          const SizedBox(height: 30,),
          Botones(onPressed: _login),
        ],
      ),
    );
  }
}

class Remember extends StatefulWidget {
  const Remember({Key? key}) : super(key: key);

  @override
  State<Remember> createState() => _RememberState();
}

class _RememberState extends State<Remember> {
  bool? valor;

  @override
  void initState() {
    super.initState();
    loadRememberMeState();
    valor = false;
  }

  void loadRememberMeState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      valor = prefs.getBool('rememberMe') ?? false;
    });
  }

  void saveRememberMeState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberMe', value);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        unselectedWidgetColor: Colors.red,
        selectedRowColor: Colors.red,
      ),
      child: Row(
        children: [
          Checkbox(
            value: valor ?? false,
            onChanged: (value) {
              setState(() {
                valor = value;
                saveRememberMeState(value ?? false);
              });
            },
            activeColor: Colors.red,
          ),
          Text(
            'Recuérdame',
            style: const TextStyle(
              color: Colors.red,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class Botones extends StatelessWidget {
  const Botones({Key? key, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: onPressed,
            child: Text(
              'Login',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Color.fromARGB(255, 255, 0, 0)),
            ),
          ),
        ),
      ],
    );
  }
}

class Fondo extends StatelessWidget {
  const Fondo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.red.shade300, Colors.red],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft)),
    );
  }
}
