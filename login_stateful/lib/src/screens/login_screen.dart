import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  Widget build(context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              emailField(),
              passwordField(),
              Container(
                margin: EdgeInsets.only(bottom: 20.0),
              ),
              submitButton(),
            ],
          )),
    );
  }

  Widget emailField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Email:',
        hintText: 'enter your email',
      ),
      validator: (value) {
        return (value != null && value.contains("@"))
            ? null
            : "Enter valid email.";
      },
      onSaved: (value) => {print(value)},
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget passwordField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password:',
        hintText: 'Password',
      ),
      obscureText: true,
      validator: (value) {
        if (value != null && value.length < 4) {
          return 'Password must be at least 4 characters';
        }
        return null;
      },
      onSaved: (value) => {print(value)},
    );
  }

  Widget submitButton() {
    return OutlinedButton(
      onPressed: () {
        final currentState = formKey.currentState;
        if (currentState != null) {
          if (currentState.validate()) {
            currentState.save();
          }
        }
      },
      child: Text('Submit!'),
      style: TextButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
    );
  }
}
