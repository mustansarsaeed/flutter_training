import 'package:flutter/material.dart';
import '../mixins/validation_mixin.dart';

class LoginScreen extends StatefulWidget {
  createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> with ValidationMixin {
  final formKey = GlobalKey<FormState>();
  late var email;
  late var password;

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
      validator: validateEmail,
      onSaved: (value) {
        email = value != null ? value : '';
      },
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
      validator: validatePassword,
      onSaved: (value) => {
        password = value != null ? value : '';
      },
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
