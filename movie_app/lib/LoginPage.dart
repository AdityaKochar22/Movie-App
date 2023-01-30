import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'movie.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                validator: (input) {
                  if (input!.isEmpty) {
                    return 'Please enter an email';
                  }
                },
                onSaved: (input) => _email = input!,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                validator: (input) {
                  if (input!.isEmpty) {
                    return 'Please enter a password';
                  }
                },
                onSaved: (input) => _password = input!,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: signIn,
                child: Text('Sign in'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signIn() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      User? user = (await _auth.signInWithEmailAndPassword(
              email: _email, password: _password))
          .user;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => IntroScreen()));
    }
  }
}
