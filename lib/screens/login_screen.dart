import 'package:flutter/material.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override

  Widget build(BuildContext context) {
     TextEditingController txtConUser = TextEditingController();
 TextEditingController txtConPass = TextEditingController();
  final textUser = TextField(
controller: txtConUser,
obscureText: true,
decoration: const InputDecoration(
  border: OutlineInputBorder()
),
  );
    final txtPass = TextField(
controller: txtConPass,
obscureText: true,
decoration: const InputDecoration(
  border: OutlineInputBorder()
),
  );

final imgFondo= Opacity(
  opacity: 0.5,
  child:   Container(
  

  ),
);


final imLogo= Container(
  width: 200,
            decoration: const BoxDecoration(
    image: DecorationImage(
      
      image: NetworkImage('https://www.vhv.rs/dpng/d/183-1834544_google-flutter-hd-png-download.png')
      )
  ),

);

final btnEntrar =FloatingActionButton.extended(
  icon: Icon(Icons.login),
  label: const Text('ENTRAR'),
onPressed: (){
Navigator.pushNamed(context, '/dash');
},);

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
      image: DecorationImage(
      fit: BoxFit.cover,
        opacity: .5
        ,
        image: NetworkImage('https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExMnM2OWVoaWlzYXI5azY5amt3aWphdDh6ajR1dWtkOTc0dHQwb2pydiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/BK1EfIsdkKZMY/giphy.gif')
        )
    ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [imgFondo,
            Container(
              height: 200,
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.symmetric(horizontal: 30),
             //color: Colors.grey,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50)
                ,color: Colors.blueGrey
              ),
              child: Column(
              //  padding: EdgeInsets.symmetric(horizontal: 40),
                children: [
                textUser,
                const SizedBox(height: 15,)
                ,txtPass
                ],
              ),
            ),
           imLogo        
            ],
          ),
        ),
      ),
      floatingActionButtonLocation:  FloatingActionButtonLocation.centerDocked,
      floatingActionButton: btnEntrar,
    );
  }
}