import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children:[   
        Fondo(),
        Contenido()
      ],
      ),
    );
  }
}

class Contenido extends StatefulWidget {
  const Contenido({super.key});

  @override
  State<Contenido> createState() => _ContenidoState();
}

class _ContenidoState extends State<Contenido> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Login',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
        ),
        SizedBox(height: 5,),
        Text('Bienvenido',
        style: TextStyle(
          color: Colors.white,
          letterSpacing: 1.5,
          fontSize: 10,
        ),
        ),
        SizedBox(height: 5,),
        Datos(),
      ],
      ),
    );
  }
}

class Datos extends StatefulWidget {
  const Datos({super.key});

  @override
  State<Datos> createState() => _DatosState();
}

class _DatosState extends State<Datos> {
  bool obs = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Email',
        style: TextStyle(
          color: Colors.red, // Establece el color del texto a rojo
              fontSize: 25.0,    // Opcional: ajusta el tamaño del texto
              fontWeight: FontWeight.bold
        ),
        ),
          const SizedBox(height: 5,),
TextFormField(
  keyboardType: TextInputType.emailAddress,
  decoration: InputDecoration(
    border: OutlineInputBorder(),
    hintText: 'example@mail.com',
    hintStyle: TextStyle(color: Colors.red.shade300),  // Cambia el color del texto
    labelStyle: TextStyle(color: Colors.red),  // Cambia el color del borde del campo cuando está enfocado
  ),  style: TextStyle(color: Colors.red)
),

          const SizedBox(height: 5,),
          const Text('password',
        style: TextStyle(
          color: Colors.red, // Establece el color del texto a rojo
              fontSize: 25.0,    // Opcional: ajusta el tamaño del texto
              fontWeight: FontWeight.bold
        ),
        ),
          const SizedBox(height: 5,),
          TextField(obscureText: obs,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
           hintText: 'Password here',
    hintStyle: TextStyle(color: Colors.red.shade300),  // Cambia el color del texto
    labelStyle: TextStyle(color: Colors.red), 
            suffixIcon: IconButton(icon: const Icon(Icons.remove_red_eye_outlined),
            onPressed: (){
              setState(() {
                obs == true ? obs = false : obs = true;
              });
            },
            ),
          ),
          style: TextStyle(color: Colors.red)
          ),
          const Remember(),
          const SizedBox(height: 30,),
          const Botones(),
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
    // Cargar el estado del checkbox desde SharedPreferences al iniciar
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
                // Guardar el estado del checkbox en SharedPreferences al cambiar
                saveRememberMeState(value ?? false);
              });
            },
            activeColor: Colors.red,
          ),
          Text(
            'Recuérdame',
            style: TextStyle(
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
  const Botones({Key? key}) : super(key: key);

  @override
  
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              // Redirigir al dashboard si "Recuérdame" está activado
              Navigator.pushNamed(context, '/dash');
            },
            child: Text(
              'Login',
              style: TextStyle(
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
  const Fondo({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors:[
          Colors.red.shade300,
          Colors.red,
        ] ,
        begin: Alignment.centerRight,
        end: Alignment.centerLeft)
      ),
    );
  }
}