import 'package:examen_movil/modules/login/domain/dto/user_credentials.dart';
import 'package:examen_movil/modules/login/useCase/loginUseCase.dart';
import 'package:examen_movil/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

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
      appBar: AppBar(
        title: const Center(child: Text('Login')),
      ),
      body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              'https://servicios.unimodelo.edu.mx/merida/upa/images/appsmodelo.png',
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),
           Padding(padding:  EdgeInsets.all(0),
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
            Divider(),
          Padding(padding: const EdgeInsets.all(0),
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
          Divider(),
            TextButton(
             onPressed: () async {
              setState(() {
                message = null;
              });
              try {
                final LocalStorage storage = LocalStorage('localstorage_app');
                await storage.clear(); 

                final credentials = UserCredentials(
                user: userController.text,
                password: passwordController.text,
                );

                final response = await LoginUseCase().execute(credentials);
                storage.setItem("token", response.accesToken);

                Navigator.pushNamed(context, Routes.categoryScreen);
              } catch (e) {
                setState(() {
                message = 'Login failed: ${e.toString()}';
                  Future.delayed(const Duration(seconds: 2), () {
                  Navigator.pushNamed(context, Routes.categoryScreen);
                  });
                });
              }
              },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              backgroundColor: Colors.blue, 
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text('Ingresar', style: TextStyle(color: Colors.white)),
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