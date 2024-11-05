import 'package:examen_movil/routes/routes.dart';
import 'package:flutter/material.dart';

class loginScreen extends StatefulWidget {
  loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {

  String? message;

  TextEditingController userController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return 
    Scaffold(
      body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Padding(padding:  EdgeInsets.all(16.0),
            child: 
              TextField(
                controller: userController,
                decoration: const InputDecoration(
                  labelText: 'User',
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(),
              ),
            ),
          Padding(padding: const EdgeInsets.all(16.1),
            child: 
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                Navigator.pushNamed(context, Routes.categoryScreen);


              // if (aaaaa.checkCredentials(userController.text, passwordController.text)) {
              //   Navigator.pushNamed(context, Routes.list);
              //   print("aaaa");
              // } else {
              //   message = 'Incorrecto';
              // }   
              });                   
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              backgroundColor: Colors.blue, 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text('Login'),
          ),
          if (message != null) 
            Text(
              message!,
              style: TextStyle(
                color: message == 'Login successful' ? Colors.green : Colors.red,
                fontSize: 16,
              ),
            ),
        ],
      ),
    )
    );
    
  }
}